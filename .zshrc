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
plugins=(git rust zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


#### Alias ######
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias loadnvm=". /usr/local/opt/nvm/nvm.sh"
alias dotfiles='/usr/local/bin/git --git-dir=/Users/mfrw/.dotfiles/ --work-tree=/Users/mfrw'
alias vi=nvim


##### goto ####
source /Users/mfrw/cutils/goto/goto.sh



### z ###
source /Users/mfrw/cutils/z/z.sh

### Sanitize PATH ####
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"


# bash-my-aws
export PATH="$PATH:$HOME/.bash-my-aws/bin"
source ~/.bash-my-aws/aliases

# For ZSH users, uncomment the following two lines:
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

source ~/.bash-my-aws/bash_completion.sh
