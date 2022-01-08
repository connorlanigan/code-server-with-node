FROM codercom/code-server:latest

RUN sudo apt update
RUN sudo apt install -y build-essential nano

# Install "n", the node.js version manager
RUN curl -L https://git.io/n-install | bash -s -- -y lts latest

# This is needed for the PATH line to work
SHELL ["/bin/bash", "-c"]

# Install yarn, which is an alternative to npm
RUN PATH+=":$HOME/n/bin" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash

# Cache your git password for 15 minutes, so you don't have to enter it for every push
RUN git config --global credential.helper cache && git config --global core.editor "nano"