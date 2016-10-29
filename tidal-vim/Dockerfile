FROM ikag/tidal
MAINTAINER munshkr <munshkr@gmail.com>

USER root

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -yq --no-install-recommends \
    tmux \
    vim \
  \
  && rm -rf /var/lib/apt/lists/*

USER $USER

RUN mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle \
  && wget -q https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim \
  \
  && wget -q https://github.com/munshkr/vim-tidal/archive/master.zip \
  && unzip master.zip -d $HOME/.vim/bundle \
  && rm master.zip \
  \
  && wget -q https://github.com/neovimhaskell/haskell-vim/archive/master.zip \
  && unzip master.zip -d $HOME/.vim/bundle \
  && rm master.zip

COPY ["config/.vimrc", "$HOME/.vimrc"]
COPY ["config/Monokai.vim", "$HOME/.vim/colors/Monokai.vim"]
