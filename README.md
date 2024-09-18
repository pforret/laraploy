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
Version : v0.0.1 (Apr 22 16:07:13 2023)
Purpose : Laravel deployment for Forge - zero downtime
Usage   : laraploy [-h] [-q] [-v] [-f] [-l <log_dir>] [-t <tmp_dir>] <action>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -q|--quiet       : [flag] no output [default: off]
    -v|--verbose     : [flag] also show debug messages [default: off]
    -f|--force       : [flag] do not ask for confirmation (always yes) [default: off]
    -l|--log_dir <?> : [option] folder for log files   [default: /Users/pforret/log/script]
    -t|--tmp_dir <?> : [option] folder for temp files  [default: /tmp/script]
    <action>         : [choice] action to perform  [options: action1,action2,check,env,update]
                                  
### TIPS & EXAMPLES
* use laraploy action1 to ...
  laraploy action1
* use laraploy action2 to ...
  laraploy action2
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

* script created with [bashew](https://github.com/pforret/bashew)

&copy; 2024 Peter Forret
