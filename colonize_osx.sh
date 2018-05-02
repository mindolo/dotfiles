echo 'Colonizing $(hostname)'

echo 'Installing brew'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

CORE_TAPS="crisidev/homebrew-chunkwm koekeishiya/formulae caskroom/fonts"
CORE_PACKAGES="bash bash-completion git homeshick iproute2mac m-cli tmux watch fasd koekeishiya/formulae/skhd"
CORE_CASKS="qtpass shiftit gpgtools chromium ubersicht alfred java bitbar google-chrome font-sourcecodepro-nerd-font karabiner-elements"

for tap in "${CORE_TAPS}"; do
  brew tap "${tap}"
done

brew install ${CORE_PACKAGES}
brew cask install ${CORE_CASKS}



export HOMESHICK_DIR=/usr/local/opt/homeshick
source "/usr/local/opt/homeshick/homeshick.sh"

homeshick clone mindolo/dotfiles
homeshick link dotfiles 
