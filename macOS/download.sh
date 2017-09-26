#!/usr/bin/env bash

# post brew-cask.sh
## open Adobe CC installer downloaded by brew cask
open -a '/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app'
## Set Textmate as default text editor in Terminal
printf "%s\n" "" '# Textmate' 'export EDITOR="/usr/local/bin/mate -w"' >> $HOME/.bash_profile

# create temp folder for downloads
cd "$( dirname "${BASH_SOURCE[0]}" )"
mkdir -p temp
cd temp

# Solarized Terminal
git clone git://github.com/tomislav/osx-terminal.app-colors-solarized.git
open 'osx-terminal.app-colors-solarized/Solarized Light.terminal'
open 'osx-terminal.app-colors-solarized/Solarized Dark.terminal'

# Safari extension
wget http://cdn3.brettterpstra.com/instapaperbeyond/TabLinks.safariextz && open TabLinks.safariextz


cd ..
rm -rf temp
