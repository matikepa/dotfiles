###########################
# macOS base stuff install
###########################
 
# Install xcode first to activate development tools
xcode-select --install
# Install rosetta intel-to-apple emulator
softwareupdate --install-rosetta
 
# Install Homebrew for ARM
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add alias and PATH to ~/.zshrc for your convenience
echo "export PATH=\"/opt/homebrew/bin:\$PATH\"" >> ~/.zshrc
 
# check if brew is working fine
brew doctor
 
# Install cli tools
brew install brew-cask-completion watch wget tree jq yq tmux ncdu viddy coreutils
 
# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
 
# install multiple screen support through displaylink
brew tap homebrew/cask-drivers
brew install displaylink
 
# other useful stuff
brew install --cask iterm2                     # advanced terminal
brew install --cask visual-studio-code
brew install --cask sublime-text
brew install --cask flameshot                  # make a cool screens with arrows and stuff
brew install --cask termius                    # ssh sessions manager
brew install --cask postman
brew install libpq                             # psql for mac
brew link --force libpq                        # force link for zsh
 
 
# Install openJDK17 + maven + completion
brew install maven maven-completion
brew tap homebrew/cask-versions
brew install --cask temurin17
 
# Install temutin17 java manually
# Temurin installs to /Library/Java/JavaVirtualMachines/temurin-<version>.<jdk|jre>/
# wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jdk_aarch64_mac_hotspot_17.0.5_8.pkg
# sudo installer -verbose -pkg ./OpenJDK17U-jdk_aarch64_mac_hotspot_17.0.5_8.pkg -target / # type admin password
 
 
# change default version of maven to custom one
# ! VERSION CAN CHANGE SO KEEP THIS IN MIND !
 
cat << _EOFF > /opt/homebrew/Cellar/maven/3.8.6/bin/mvn
#!/bin/bash
JAVA_HOME="${JAVA_HOME}" exec "/opt/homebrew/Cellar/maven/3.8.6/libexec/bin/mvn"  "$
_EOFF
 
# Install Docker desktop
wget -O Docker.dmg "https://desktop.docker.com/mac/main/arm64/Docker.dmg"
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker
 
# Install other tools
brew install ansible terraform helm
brew install docker-completion
 
 
 
# Install cloudsql proxy
mkdir -p ~/bin
curl -o ~/bin/cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
chmod +x ~/bin/cloud_sql_proxy
 
# Install gcloud with kubectl
curl -kSLOC - https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-406.0.0-darwin-arm.tar.gz
tar -xvf google-cloud-cli-406.0.0-darwin-arm.tar.gz
./google-cloud-sdk/install.sh
 
#upgrade gcloud
gcloud components update
 
#install components
gcloud components install terraform-tools alpha beta kubectl kustomize
 
#gcloud set proxy
gcloud config set proxy/type http
gcloud config set proxy/address proxy
gcloud config set proxy/port 8081
 
#init account
gcloud init
 
 
######################
###     OPTIONAL   ###
######################
 
# Most times mac comes with a preinstalled version of git which you can use.
# If, however, you do not want to use it
sudo mv /usr/bin/git /usr/bin/default-git
brew install git
brew link --force git #OPTIONAL
git --version
git config --global user.name "yourname"
git config --global user.email "yourmail"
