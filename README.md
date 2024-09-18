![bash_unit CI](https://github.com/pforret/laraploy/workflows/bash_unit%20CI/badge.svg)
![Shellcheck CI](https://github.com/pforret/laraploy/workflows/Shellcheck%20CI/badge.svg)
![GH Language](https://img.shields.io/github/languages/top/pforret/laraploy)
![GH stars](https://img.shields.io/github/stars/pforret/laraploy)
![GH tag](https://img.shields.io/github/v/tag/pforret/laraploy)
![GH License](https://img.shields.io/github/license/pforret/laraploy)
[![basher install](https://img.shields.io/badge/basher-install-white?logo=gnu-bash&style=flat)](https://www.basher.it/package/)

# laraploy

Laravel deployment for Forge - zero downtime

## 🔥 Usage

```
Program : laraploy  by peter@forret.com
Version : v0.1.0 (2024-09-18 22:07)
Purpose : Laravel deployment for Forge - zero downtime
Usage   : laraploy [-h] [-Q] [-V] [-f] [-L <LOG_DIR>] [-T <TMP_DIR>] [-D <DOMAIN>] [-R <REPO>] [-K <KEEP>] [-S <RELEASES>] <action>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -Q|--QUIET       : [flag] no output [default: off]
    -V|--VERBOSE     : [flag] also show debug messages [default: off]
    -f|--FORCE       : [flag] do not ask for confirmation (always yes) [default: off]
    -L|--LOG_DIR <?> : [option] folder for log files   [default: /home/pforret/log/laraploy]
    -T|--TMP_DIR <?> : [option] folder for temp files  [default: /tmp/laraploy]
    -D|--DOMAIN <?>  : [option] site domain
    -R|--REPO <?>    : [option] git repo URL
    -K|--KEEP <?>    : [option] releases to keep  [default: 5]
    -S|--RELEASES <?>: [option] releases folder
    <action>         : [choice] action to perform  [options: deploy,check,env,update]
                                                                                                                                                                                                                                                                     
### TIPS & EXAMPLES
* use laraploy deploy to deploy Laravel project on Forge with zero downtime
  laraploy deploy
* use laraploy check to check if this script is ready to execute and what values the options/flags are
  laraploy check
* use laraploy env to generate an example .env file
  laraploy env > .env
* use laraploy update to update to the latest version
  laraploy update
* >>> bash script created with pforret/bashew
* >>> for bash development, also check out pforret/setver and pforret/progressbar
```

## ⚡️ Examples

```bash
> laraploy -h 
# get extended usage info

> laraploy deploy
# deploy Laravel project on Forge with zero downtime

> laraploy env > .env
# create a .env file with default values
```

## 🚀 Installation

with [basher](https://github.com/basherpm/basher)

	$ basher install pforret/laraploy

or with `git`

	$ git clone https://github.com/pforret/laraploy.git
	$ cd laraploy

## 📝 Acknowledgements

* original deployment script: by [Zacharias Creutznacher - @Sairahcaz2k](https://x.com/Sairahcaz2k/status/1835800971986792834) - [gist.github.com](https://gist.github.com/Sairahcaz/104019bf733663668610fdd18590c509)
* script created with [bashew](https://github.com/pforret/bashew)

&copy; 2024 Peter Forret
