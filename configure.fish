# install neovim python deps
pip3 install neovim --user

# install nightly rust
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly

source "$HOME/.cargo/env"

# install rust utils

cargo install bat bingrep cargo-edit cargo-update choose du-dust exa fd-find git-delta gitui gpg-tui hyperfine jql lsd ripgrep skim tealdeer

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install jethrokuan/fzf
fisher install wfxr/forgit

# install vim-plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# link vimrc to $HOME/.vimrc
ln -s (pwd)/vimrc $HOME/.vimrc
# link vimrc to $HOME/.config/nvim/init.vim
mkdir -p $HOME/.config/nvim/
ln -s (pwd)/vimrc $HOME/.config/nvim/init.vim
# link tmux.conf -> $HOME/.tmux.conf
ln -s (pwd)/tmux.conf $HOME/.tmux.conf



# clone go
pushd $HOME

git clone https://github.com/golang/go.git
# add go1.4 bootstrap
# <golang pushd>
pushd go
git worktree add $HOME/go1.4 release-branch.go1.4
# </golang pushd>
popd

popd
# end -- go
