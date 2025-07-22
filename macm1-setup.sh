###########################
# macOS base stuff install
###########################

# Install xcode first to activate development tools
xcode-select --install
# Install rosetta intel-to-apple emulator
softwareupdate --install-rosetta

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Homebrew for ARM
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add alias and PATH to ~/.zshrc for your convenience
echo "export PATH=\"/opt/homebrew/bin:\$PATH\"" >>~/.zshrc

# check if brew is working fine
brew doctor

# Install cli tools
brew install brew-cask-completion watch wget tree jq yq tmux ncdu viddy coreutils rsync fzf pre-commit

# Install TF, helm 
brew install helmenv helmfile 
brew install tfenv tflint tfsec
tfenv install latest
helmenv install 3.15.4

# install amazon tools
brew install python3 pipx
pip3 install awscli

# # Set default prompt
# # append the ~/.zshrc with below
# cp ~/.zshrc ~/.zshrc_backup_$(date +%F)
# cat <<_EOFF >>~/.zshrc
# PROMPT='%{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'
# _EOFF
## Multiline zsh commandline prompt
PROMPT='%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m%{$reset_color%} [%D{%H:%M:%S}]
%{$fg[green]%}%~%{$reset_color%} %{$fg[red]%}$(parse_git_branch)%{$reset_color%}
> '

# install multiple screen support through displaylink
brew tap homebrew/cask-drivers
brew install displaylink

# other useful stuff
brew install --cask iterm2              # advanced terminal
brew install --cask visual-studio-code
brew install --cask sublime-text
brew install --cask dbeaver-community   # db tool
brew install --cask flameshot           # sudo xattr -rd com.apple.quarantine /Applications/flameshot.app # to allow execution
brew install --cask firefox-esr         # Firefox with extended support
brew install --cask google-chrome
brew install --cask orbstack            # replacement for docker desktop or use colima since its free
brew install --cask rectangle           # free window manager based on spectacle
brew install --cask postman
brew install --cask keystore-explorer
brew install --cask beyond-compare      # advanced diff tool
brew install libpq                      # psql for mac
brew link --force libpq                 # force link for zsh

# # Install Docker desktop
# wget -O Docker.dmg "https://desktop.docker.com/mac/main/arm64/Docker.dmg"
# sudo hdiutil attach Docker.dmg
# sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
# sudo hdiutil detach /Volumes/Docker

# Instead of docker install colima
brew install colima
colima start --cpu 4 --memory 8 --disk 50

brew install docker-completion hadolint


# Install kubectl
LATEST_STABLE=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO https://storage.googleapis.com/kubernetes-release/release/$LATEST_STABLE/bin/darwin/amd64/kubectl
chmod +x ./kubectl
mv kubectl ~/bin/

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

minikube start --kubernetes-version=v1.31 --addons metrics-server,ingress --driver=docker

# Generate SSH key
ssh-keygen -t ed25519 -f ~/.ssh/mkepa-xxx -a 100 -C "m.kepa@DOMAIN"

######################
###     OPTIONAL   ###
######################

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

## More optional stuff

# Most times mac comes with a preinstalled version of git which you can use.
# If, however, you do not want to use it
sudo mv /usr/bin/git /usr/bin/default-git
brew install git
brew link --force git #OPTIONAL
git --version
git config --global user.name "Mateusz (Mati) Kepa"
git config --global user.email "m.kepa@DOMAIN"
git config --global core.sshcommand "ssh -i /Users/user/.ssh/private_key"
git config --global gpg.format ssh
git config --global user.signingkey 'ssh-ed25519 AAAAxxxxxxx m.kepa@DOMAIN'
git config --global commit.gpgsign true
git config --global tag.gpgsign true

# In case ssh/gpg signing does not work, create following file
~/.config/git/allowed_signers
# with content (you can add more keys here)
nameEmailDomain ssh-ed25519 AAAAxxxxxxx m.kepa@DOMAIN
# add to global config
git config --global gpg.ssh.allowedSignersFile "$HOME/.config/git/allowed_signers"

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

cat <<_EOFF >/opt/homebrew/Cellar/maven/3.8.6/bin/mvn
#!/bin/bash
JAVA_HOME="${JAVA_HOME}" exec "/opt/homebrew/Cellar/maven/3.8.6/libexec/bin/mvn"  "$
_EOFF
