FROM debian:jessie
MAINTAINER Mauro <mauro@sdf.org>, munshkr <munshkr@gmail.com>

# Define ENV_VARS
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV USER tidal
ENV HOME /home/$USER

# Create home and user dirs
RUN mkdir -p $HOME
RUN groupadd -r $USER && useradd -r -g $USER $USER

# Install dependencies, download Tidal and other libraries
RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -yqt jessie-backports --no-install-recommends \
    cabal-install \
    ghc \
  && apt-get install -yq --no-install-recommends \
    ca-certificates \
    unzip \
    wget \
    # tidal-midi dependencies
    libasound2-dev \
    libportmidi0 \
    libportmidi-dev \
  \
  && wget https://github.com/d0kt0r0/Tidal/archive/espgrid.zip -O $HOME/tidal-espgrid.zip \
  && wget https://github.com/lvm/tidal-midi-gm/archive/master.zip -O $HOME/tidal-midi-gm.zip \
  && wget https://github.com/lvm/tidal-drum-patterns/archive/master.zip -O $HOME/tidal-drum-patterns.zip \
  \
  && rm -rf /var/lib/apt/lists/*

# Install Tidal
RUN cabal update \
  && cabal install \
    colour \
    hashable \
    hmt \
    'hosc > 0.13' \
    mersenne-random-pure64 \
    monad-loops \
    'mtl >=2.1' \
    parsec \
    text \
    'websockets > 0.8' \
  \
  # Install tidal-espgrid
  && unzip $HOME/tidal-espgrid.zip -d $HOME \
  && cd $HOME/Tidal-espgrid \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/Tidal-espgrid $HOME/tidal-espgrid.zip

# Install tidal-midi, tidal-midi-gm and tidal-drum-patterns
RUN cabal update \
  && cabal install tidal-midi-0.8 \
  \
  && unzip $HOME/tidal-midi-gm.zip -d $HOME \
  && cd $HOME/tidal-midi-gm-master \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/tidal-midi-gm-master $HOME/tidal-midi-gm.zip \
  \
  && unzip $HOME/tidal-drum-patterns.zip -d $HOME \
  && cd $HOME/tidal-drum-patterns-master \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/tidal-drum-patterns-master $HOME/tidal-drum-patterns.zip

# Fix permissions
RUN chown -Rh $USER:$USER -- $HOME

# Init
USER $USER
WORKDIR $HOME
