# VS Code in the browser, with NodeJS pre-installed

This is an extended version of [code-server](https://github.com/cdr/code-server). It allows you to run VS Code on any machine anywhere and access it in the browser.

This project adds the following features/tools:

- `n`, the NodeJS version manager
- two versions of NodeJS: the current LTS version and the current stable version. You can switch between them using the `n` command inside the docker container. For example: `n lts`, or `n latest`. You can also install other Node versions, for example: `n 12`.
- `npm`, the NodeJS package manager
- `yarn`, an alternative NodeJS package manager
- configures Git to cache your password for 15 minutes, so you don't have to enter it everytime

# Docker image

The docker image is [available in the public Docker registry](https://hub.docker.com/r/connorlanigan/code-server-with-node) as `connorlanigan/code-server-with-node`.

It is automatically rebuilt every week (on Monday) with the latest version of the `code-server` image.

# Example usage

This image can be used in-place instead of the original coder.com image. The following docker setup script is adapted from [the original coder.com Docker instructions](https://coder.com/docs/code-server/latest/install#docker):

```bash
# This will start a code-server container and expose it at http://127.0.0.1:8080.
# It will also mount your current directory into the container as `/home/coder/project`
# and forward your UID/GID so that all file system operations occur as your user outside
# the container.
#
# Your $HOME/.config is mounted at $HOME/.config within the container to ensure you can
# easily access/modify your code-server config in $HOME/.config/code-server/config.json
# outside the container.

mkdir -p ~/.config
docker run -it --name code-server -p 127.0.0.1:8080:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "$PWD:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  connorlanigan/code-server-with-node:latest
```
