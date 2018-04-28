setopt histignorealldups sharehistory
bindkey -e
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git go osx rust zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
###### brew deps #####
export PATH=/usr/local/sbin:$PATH

############## for GO ###############
export GOROOT=$HOME/go
export GOROOT_BOOTSTRAP=$HOME/go1.4
export GOPATH=$GOROOT/go_get
export PATH=$HOME/bin:$GOROOT/bin:$GOPATH/bin:$PATH

#### Alias ######
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias loadnvm=". /usr/local/opt/nvm/nvm.sh"
alias dotfiles='/usr/local/bin/git --git-dir=/Users/mfrw/.dotfiles/ --work-tree=/Users/mfrw'
alias vi=vim

###tldr####
source ~/cutils/tldr-c-client/autocomplete/complete.zsh


#### NVM -- Node.js ####
export NVM_DIR="$HOME/.nvm"
