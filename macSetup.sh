
#!/bin/bash

start=`date +%s`
bold=$(tput bold)
normal=$(tput sgr0)
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# if test ! $(which gcc); then
#   echo "Installing command line developer tools..."
#   xcode-select --install
# fi

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
    brew install caskroom/cask/brew-cask
    #brew tap homebrew/cask-versions
    #brew tap homebrew/cask-cask
    #brew tap 'homebrew/bundle'
    #brew tap 'homebrew/cask'
    #brew tap 'homebrew/cask-drivers'
    #brew tap 'homebrew/cask-fonts'
    #brew tap 'homebrew/core'
    #brew tap 'homebrew/services'

fi

echo "Updating homebrew..."
brew update
brew upgrade


beginDeploy() {
    echo
    echo "${bold}$1${normal}"
}

############# General Tools #############
CaskGeneralToolList=(
    google-chrome
    firefox
    spotify
)

beginDeploy "############# General Tools #############"
echo "Do you wish to install General Tools (${bold}${green}y${reset}/${bold}${red}n${reset})? "
echo "Items to be installed: ${bold}${green}${CaskGeneralToolList[*]}${reset}"
read General

if [ "$General" != "${General#[Yy]}" ] ;then
    echo Yes
    brew install -f --cask --appdir="/Applications" ${CaskGeneralToolList[@]}
else
    echo No
fi

############# Developer Utilities #############
DeveloperUtilitiesList=(
    jq
    wget
    npm
    nvm
)
CaskDeveloperUtilitiesList=(
    cheatsheet
)

beginDeploy "############# Developer Utilities #############"
echo -n "Do you wish to install Developer Utilities (${bold}${green}y${reset}/${bold}${red}n${reset})? "
echo "Items to be installed: ${bold}${green}${DeveloperUtilitiesList[*]} ${CaskDeveloperUtilitiesList[*]}${reset}"
read DeveloperUtilities

if [ "$DeveloperUtilities" != "${DeveloperUtilities#[Yy]}" ] ;then
    
    echo Yes
    brew install ${DeveloperUtilitiesList[@]}
    brew install --cask ${CaskDeveloperUtilitiesList[@]}


    mkdir ~/.nvm
    echo '
    # NVM CONFIG
    export NVM_DIR="$HOME/.nvm"
        [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
        [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion' >> ~/.bash_profile
else
    echo No
fi


############# IDEs #############
CaskIDEsList=(
    visual-studio-code
)
beginDeploy "############# IDEs #############"
echo -n "Do you wish to install IDEs (${bold}${green}y${reset}/${bold}${red}n${reset})? "
echo "Items to be installed: ${bold}${green}${CaskIDEsList[*]}${reset}"
read IDEs

if [ "$IDEs" != "${IDEs#[Yy]}" ] ;then
    echo Yes
    brew install --cask --appdir="/Applications" ${CaskIDEsList[@]}
    cat vscode-extensions.txt | xargs -L1 code --install-extension
else
    echo No
fi


############# DevOps #############
CaskDevOpsToolList=(
    docker
)
beginDeploy "############# DevOps #############"
echo -n "Do you wish to install DevOps Tools (${bold}${green}y${reset}/${bold}${red}n${reset})? "
echo "Items to be installed: ${bold}${green}${CaskDevOpsToolList[*]}${reset}"
read DevOps

if [ "$DevOps" != "${DevOps#[Yy]}" ] ;then
    echo Yes
    brew install --cask ${CaskDevOpsToolList[@]}

    ## DOCKER APP
    wget -P ~/Downloads/ https://github.com/docker/app/releases/download/v0.8.0/docker-app-darwin.tar.gz
    tar -xvf ~/Downloads/docker-app-darwin.tar.gz -C ~/Downloads/
    mv ~/Downloads/docker-app-darwin /usr/local/bin/docker-app
    rm ~/Downloads/docker-app-darwin.tar.gz
else
    echo No
fi


############# Productivity Tools #############
CaskProductivityToolList=(
    slack
    zoom
)
beginDeploy "############# Productivity Tools #############"
echo -n "Do you wish to install Productivity Tools (${bold}${green}y${reset}/${bold}${red}n${reset})? "
echo "Items to be installed: ${bold}${green}${CaskProductivityToolList[*]}${reset}"
read Productivity

if [ "$Productivity" != "${Productivity#[Yy]}" ] ;then
    echo Yes
    brew install -f --cask --appdir="/Applications" ${CaskProductivityToolList[@]}
else
    echo No
fi

beginDeploy "############# CLEANING HOMEBREW #############"
brew cleanup

beginDeploy "############# SETUP BASH PROFILE #############"
source ~/.bash_profile

runtime=$((($(date +%s)-$start)/60))
beginDeploy "############# Total Setup Time ############# $runtime Minutes"
