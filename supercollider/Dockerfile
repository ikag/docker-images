FROM debian:jessie
MAINTAINER munshkr <munshkr@gmail.com>

# Define ENV_VARS
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV USER sc
ENV HOME /home/$USER

ENV SC_VERSION 3.7.2

# Create home and user dirs
RUN mkdir -p $HOME
RUN groupadd -r $USER && useradd -r -g $USER $USER

# Install dependencies
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    git \
    jackd \
    libasound2-dev \
    libavahi-client-dev \
    libcwiid-dev \
    libfftw3-dev \
    libicu-dev \
    libjack-dev \
    libreadline6-dev \
    libsndfile1-dev \
    libudev-dev \
    libxt-dev \
    pkg-config \
    wget \
  \
  && rm -rf /var/lib/apt/lists/*

# Download Supercollider source, compile and install
RUN mkdir -p $HOME/src \
  && cd $HOME/src \
  && wget -q https://github.com/supercollider/supercollider/releases/download/Version-$SC_VERSION/SuperCollider-$SC_VERSION-Source-linux.tar.bz2 -O sc.tar.bz2 \
  && tar xvf sc.tar.bz2 \
  && cd SuperCollider-Source \
  && mkdir -p build \
  && cd build \
  && cmake -DCMAKE_BUILD_TYPE="Release" -DBUILD_TESTING=OFF -DSUPERNOVA=OFF -DNATIVE=OFF -DSC_WII=OFF -DSC_QT=OFF -DSC_ED=OFF -DSC_EL=OFF .. \
  && make -j4 \
  && make install \
  && ldconfig \
  && cd .. \
  && mv /usr/local/share/SuperCollider/SCClassLibrary/Common/GUI /usr/local/share/SuperCollider/SCClassLibrary/scide_scqt/GUI \
  && mv /usr/local/share/SuperCollider/SCClassLibrary/JITLib/GUI /usr/local/share/SuperCollider/SCClassLibrary/scide_scqt/JITLibGUI \
  && mv SCClassLibrary/Common/GUI/Base/Model.sc /usr/local/share/SuperCollider/SCClassLibrary/Common/Core/ \
  && cd .. \
  && rm -rf src

RUN usermod -aG audio $USER

#RUN dpkg-reconfigure -p high jackd

# Copy configuration files
COPY ["config/.jackdrc", "$HOME/.jackdrc"]

# Fix permissions
RUN chown -Rh $USER:$USER -- $HOME

# Init
USER $USER
WORKDIR $HOME

CMD ["sclang"]