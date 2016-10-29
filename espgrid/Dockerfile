FROM debian:jessie
MAINTAINER munshkr <munshkr@gmail.com>

# Define ENV_VARS
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV USER esp
ENV HOME /home/$USER

# Create home and user dirs
RUN mkdir -p $HOME
RUN groupadd -r $USER && useradd -r -g $USER $USER

# Install dependencies
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -yq --no-install-recommends \
    ca-certificates \
    git \
    libgnustep-base-dev \
    make \
    wget \
  \
  && rm -rf /var/lib/apt/lists/*

# Download Supercollider source, compile and install
RUN git clone --depth=1 https://github.com/d0kt0r0/EspGrid.git $HOME/src \
  && cd $HOME/src/EspGrid \
  && make -j4 \
  && install espgridd /usr/local/bin \
  && mkdir $HOME/Documents

# Fix permissions
RUN chown -Rh $USER:$USER -- $HOME

# Init
USER $USER
WORKDIR $HOME

# Expose UDP ports for espgridd
EXPOSE 5509
EXPOSE 5510

CMD ["espgridd"]
