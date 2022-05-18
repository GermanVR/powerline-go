#!/bin/bash

powerline_installed="$(cat  ~/.bashrc | grep "function _update_ps1() {")"

echo "Validating: [$powerline_installed]"
if [[ -z "$powerline_installed" ]]; then
    echo "Powerline is Not Installed"


sudo sh -c  "apt update -y && apt install golang-go -y"

go get -u github.com/justjanne/powerline-go

cat << \EOT  >> ~/.bashrc 
GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
EOT

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo sh -c "mv PowerlineSymbols.otf /usr/share/fonts/ && fc-cache -vf /usr/share/fonts/ && mv 10-powerline-symbols.conf /etc/fonts/conf.d/"

source ~/.bashrc

else
    echo "Powerline is Installed"
fi
