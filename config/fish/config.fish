set -Ux LSCOLORS "Gxfxcxdxbxegedabagacad"

setenv GOPATH $HOME/g
setenv GOROOT $HOME/go
setenv GOROOT_BOOTSTRAP $HOME/go1.4

export PATH="$HOME/.cargo/bin:$GOPATH/bin:$GOROOT/bin:$HOME/bin:$PATH"

setenv EDITOR nvim

setenv LC_ALL en_US.UTF-8
setenv LANG en_US.UTF-8
setenv LANGUAGE en_US.UTF-8

# Colored man
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline<Paste>


# configure starship
source (starship init fish --print-full-init | psub)
# configure zoxide
zoxide init fish | source
alias vi=nvim
#
# configure gh completions
source (gh completion -s fish | psub)
