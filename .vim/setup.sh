# from http://sontek.net/turning-vim-into-a-modern-python-ide
git init
cd autoload
rm -f pathogen.vim
wget --no-check-certificate https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim
cd -

git submodule add https://github.com/vim-scripts/pep8.git bundle/pep8
git submodule add https://github.com/mitechie/pyflakes-pathogen.git bundle/pyflakes
git submodule add https://github.com/ervandew/supertab.git bundle/supertab
git submodule add https://github.com/msanders/snipmate.vim.git bundle/snipmate

git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

mkdir ~/.vim/snippets
