FROM ubuntu:latest
MAINTAINER Mark Larah <mark@larah.me>

# Install assumed dependencies
RUN     apt-get update && 
        add-apt-repository -y ppa:neovim-ppa/unstable &&
        apt-get install -y \
            software-properties-common \
            git \
            zsh \
            neovim \
            && apt-get clean

# Run as a new user
RUN     useradd -ms /bin/bash kryten
USER    kryten
WORKDIR /home/kryten

# Install dotfiles
COPY    . /home/kryten/dotfiles
WORKDIR /home/kryten/dotfiles

# Run test
CMD    ["/home/kryten/dotfiles/bin/install_test.sh"]