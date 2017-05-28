echo 'Colonizing $(hostname)'

echo 'Installing brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

CORE_PACKAGES="bash bash-completion git homeshick khd kwm iproute2mac m-cli tmux watch z"
CORE_CASKS="qtpass shiftit gpgtools chromium ubersicht alfred java"

brew install ${CORE_PACKAGES}
brew cask install ${CORE_CASKS}

export HOMESHICK_DIR=/usr/local/opt/homeshick
source "/usr/local/opt/homeshick/homeshick.sh"

homeshick clone mindolo/dotfiles
homeshick link dotfiles 
