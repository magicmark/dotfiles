FROM ubuntu:latest
MAINTAINER Mark Larah <mark@larah.me>

RUN     apt-get update && \
            apt-get install -y software-properties-common && \
            add-apt-repository -y ppa:neovim-ppa/unstable

# Install assumed dependencies
RUN     apt-get update && apt-get install -y \
            git \
            zsh \
            neovim \
            && apt-get clean

# Run as a new user
RUN     useradd -ms /bin/bash kryten -p 2X4B
USER    kryten
WORKDIR /home/kryten

# Install dotfiles
COPY    . /home/kryten/dotfiles
WORKDIR /home/kryten/dotfiles

# Run test
RUN    make venv
CMD    ["bash", "-c", ". venv/bin/activate && /home/kryten/dotfiles/test/install_test.py"]
