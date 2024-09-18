# SETUP #

# https://gist.github.com/Sairahcaz/104019bf733663668610fdd18590c509

DOMAIN=example.com
PROJECT_REPO="git@github.com:example.com/app.git"
AMOUNT_KEEP_RELEASES=5

RELEASE_NAME=$(date +%s--%Y_%m_%d--%H_%M_%S)
RELEASES_DIRECTORY=~/$DOMAIN/releases
DEPLOYMENT_DIRECTORY=$RELEASES_DIRECTORY/$RELEASE_NAME

# stop script on error signal (-e) and undefined variables (-u)
set -eu

printf '\nℹ️ Starting deployment %s\n' "$RELEASE_NAME"
mkdir -p "$RELEASES_DIRECTORY" && cd "$RELEASES_DIRECTORY"

printf '\nℹ️ Clone GIT project from %s and checkout branch %s\n' "$PROJECT_REPO" "$FORGE_SITE_BRANCH"
git clone "$PROJECT_REPO" "$RELEASE_NAME"
cd "$RELEASE_NAME"
git checkout "$FORGE_SITE_BRANCH"
git fetch origin "$FORGE_SITE_BRANCH"
git reset --hard FETCH_HEAD

printf '\nℹ️ Copy ./.env file\n'
ENV_FILE=~/"$DOMAIN"/current/.env
if [ -f "$ENV_FILE" ]; then
  cp $ENV_FILE ./.env
else
  printf '\nError: .env file is missing at %s.' "$ENV_FILE" && exit 1
fi

printf '\nℹ️ Link ./storage/app folder\n'
STORAGE_DIR=~/"$DOMAIN"/storage/app
if [ -d "$STORAGE_DIR" ]; then
  rm -rf ./storage/app
  ln -s -n -f -T $STORAGE_DIR ./storage/app
else
  printf '\nError: storage dir is missing at %s.' "$STORAGE_DIR" && exit 1
fi

printf '\nℹ️ Install Composer Dependency Updates\n'
$FORGE_COMPOSER install --no-interaction --prefer-dist --optimize-autoloader --no-dev

printf '\nℹ️ Installing NPM dependencies based on \"./package-lock.json\"\n'
npm ci
printf '\nℹ️ Generating JS App files\n'
npm run build

printf '\nℹ️ Laravel Artisan commands\n'
if [ -f artisan ]; then
  printf '\nℹ️ Link ./public/storage\n'
  $FORGE_PHP artisan storage:link

  printf '\nℹ️ Clear and cache routes, config, views, events\n'
  $FORGE_PHP artisan config:cache
  $FORGE_PHP artisan route:cache
  $FORGE_PHP artisan view:cache
  $FORGE_PHP artisan event:cache

  printf '\nℹ️ Database Migrations\n'
  $FORGE_PHP artisan migrate --force
fi

printf '\nℹ️ !!! Link Deployment Directory !!!\n'
echo "$RELEASE_NAME" >> $RELEASES_DIRECTORY/.successes
if [ -d ~/$DOMAIN/current ] && [ ! -L ~/$DOMAIN/current ]; then
  rm -rf ~/$DOMAIN/current
fi
ln -s -n -f -T "$DEPLOYMENT_DIRECTORY" ~/$DOMAIN/current

printf '\nℹ️ Restart PHP FPM\n'
( flock -w 10 9 || exit 1
    echo 'Restarting FPM...'; sudo -S service $FORGE_PHP_FPM reload ) 9>/tmp/fpmlock

printf '\nℹ️ Restart Horizon Queue Workers\n'
  $FORGE_PHP artisan horizon:terminate

# Clean Up
cd $RELEASES_DIRECTORY

printf '\nℹ️ Delete failed releases:\n'
if grep -qvf .successes <(ls -1)
then
  grep -vf .successes <(ls -1)
  grep -vf .successes <(ls -1) | xargs rm -rf
else
  echo "No failed releases found."
fi

printf '\nℹ️ Delete old successful releases:\n'
AMOUNT_KEEP_RELEASES=$((AMOUNT_KEEP_RELEASES-1))
LINES_STORED_RELEASES_TO_DELETE=$(find . -maxdepth 1 -mindepth 1 -type d ! -name "$RELEASE_NAME" -printf '%T@\t%f\n' | head -n -"$AMOUNT_KEEP_RELEASES" | wc -l)
if [ "$LINES_STORED_RELEASES_TO_DELETE" != 0 ]; then
  find . -maxdepth 1 -mindepth 1 -type d ! -name "$RELEASE_NAME" -printf '%T@\t%f\n' | sort -t $'\t' -g | head -n -"$AMOUNT_KEEP_RELEASES" | cut -d $'\t' -f 2-
  find . -maxdepth 1 -mindepth 1 -type d ! -name "$RELEASE_NAME" -printf '%T@\t%f\n' | sort -t $'\t' -g | head -n -"$AMOUNT_KEEP_RELEASES" | cut -d $'\t' -f 2- | xargs -I {} sed -i -e '/{}/d' .successes
  find . -maxdepth 1 -mindepth 1 -type d ! -name "$RELEASE_NAME" -printf '%T@\t%f\n' | sort -t $'\t' -g | head -n -"$AMOUNT_KEEP_RELEASES" | cut -d $'\t' -f 2- | xargs rm -rf
else
  AMOUNT_KEEP_RELEASES=$((AMOUNT_KEEP_RELEASES+1))
  LINES_STORED_RELEASES_TOTAL=$(find . -maxdepth 1 -mindepth 1 -type d -printf '%T@\t%f\n' | wc -l)
  printf 'There are only %s successfully stored releases, which is less than or equal to your\ndefined %s releases to keep, so none of them got deleted.' "$LINES_STORED_RELEASES_TOTAL" "$AMOUNT_KEEP_RELEASES"
fi

printf '\nℹ️ Status - stored releases:\n'
find . -maxdepth 1 -mindepth 1 -type d -printf '%T@\t%f\n' | sort -nr | cut -f 2-

printf '\n✅ Deployment DONE: %s\n' "$DEPLOYMENT_DIRECTORY"