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

# Install Haskell, dependencies and other tools from repositories
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
  && rm -rf /var/lib/apt/lists/*

# Install Tidal (with EspGrid support) and dependencies
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
  && wget https://github.com/d0kt0r0/Tidal/archive/espgrid.zip -O $HOME/tidal-espgrid.zip \
  && unzip $HOME/tidal-espgrid.zip -d $HOME \
  && cd $HOME/Tidal-espgrid \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/Tidal-espgrid $HOME/tidal-espgrid.zip

# Install other Tidal-related libraries
RUN cabal update \
  && cabal install tidal-midi-0.8 \
  \
  # Install tidal-midi-gm
  && wget https://github.com/lvm/tidal-midi-gm/archive/master.zip -O $HOME/tidal-midi-gm.zip \
  && unzip $HOME/tidal-midi-gm.zip -d $HOME \
  && cd $HOME/tidal-midi-gm-master \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/tidal-midi-gm-master $HOME/tidal-midi-gm.zip \
  \
  # Install tidal-drum-patterns
  && wget https://github.com/lvm/tidal-drum-patterns/archive/master.zip -O $HOME/tidal-drum-patterns.zip \
  && unzip $HOME/tidal-drum-patterns.zip -d $HOME \
  && cd $HOME/tidal-drum-patterns-master \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/tidal-drum-patterns-master $HOME/tidal-drum-patterns.zip \
  \
  # Install tidal-scales
  && wget https://github.com/lvm/tidal-scales/archive/master.zip -O $HOME/tidal-scales.zip \
  && unzip $HOME/tidal-scales.zip -d $HOME \
  && cd $HOME/tidal-scales-master \
  && cabal configure && cabal build && cabal install \
  && rm -fr $HOME/tidal-scales-master $HOME/tidal-scales.zip

# Fix permissions
RUN chown -Rh $USER:$USER -- $HOME

# Init
USER $USER
WORKDIR $HOME
