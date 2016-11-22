FROM ubuntu:latest
MAINTAINER Mark Larah <mark@larah.me>

RUN     apt-get update && \
            apt-get install -y software-properties-common && \
            add-apt-repository -y ppa:neovim-ppa/unstable

RUN     apt-get update && apt-get install -y \
            make \
            virtualenv

# Install assumed dependencies
RUN     apt-get update && apt-get install -y \
            git \
            neovim \
            tmux \
            wget \
            zsh \
            && apt-get clean

# Run as a new user
RUN     useradd -ms /bin/bash kryten -p 2X4B

# Install dotfiles
COPY    . /home/kryten/dotfiles
WORKDIR /home/kryten/dotfiles

# Set permissions at create venv
RUN     chown -R kryten:kryten /home/kryten
RUN     make venv

USER    kryten
WORKDIR /home/kryten/dotfiles

# Run test
CMD    [\
    "/bin/bash", "-c", \
    ". venv/bin/activate && venv/bin/python test/install_test.py" \
]
