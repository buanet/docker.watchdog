# Watchdog for Docker

[![Source](https://img.shields.io/badge/source-github-blue)](https://github.com/buanet/docker.watchdog)
[![Release](https://img.shields.io/github/v/release/buanet/docker.watchdog)](https://github.com/buanet/docker.watchdog/releases)
[![Github Issues](https://img.shields.io/github/issues/buanet/docker.watchdog)](https://github.com/buanet/docker.watchdog/issues)<br>
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/buanet/watchdog/latest)](https://hub.docker.com/repository/docker/buanet/watchdog)
[![Docker Pulls](https://img.shields.io/docker/pulls/buanet/watchdog)](https://hub.docker.com/repository/docker/buanet/watchdog)
[![Docker Stars](https://img.shields.io/docker/stars/buanet/watchdog)](https://hub.docker.com/repository/docker/buanet/watchdog)<br>
[![License](https://img.shields.io/github/license/buanet/docker.watchdog)](https://github.com/buanet/docker.watchdog/blob/master/LICENSE.md)
[![Donate](https://img.shields.io/badge/donate-paypal-blue)](https://paypal.me/buanet)

Watchdog for Docker is a Docker image which provides (at the moment) just a simple watchdog to automatically restart unhealthy containers. Some more functions to monitor your containers will follow.

## Getting started

### Running from command line

To let the watchdog watch your running containers and automatically restart them when "unhealthy" status is detectet just run it like this:  

```
docker run \
    -d \
    --name watchdog \
    --restart=always \
    -e WATCHDOG_CONTAINER_LABEL=all \
    -v /var/run/docker.sock:/var/run/docker.sock \
    buanet/watchdog:latest
```

### Running with docker-compose

You can also run the watchdog by using docker-compose. Here is an example:

```
version: '2'

services:
  watchdog:
    container_name: watchdog
    image: buanet/watchdog:latest
    hostname: watchdog
    restart: always
    environment:
      - WATCHDOG_CONTAINER_LABEL=all
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

## Special settings and features

The following will give a short overview.

### Environment variables

To configure the watchdog you can set some environment variables.
You do not have to declare every single variable when setting up your container. Variables you do not set will come up with their default value.

|ENV|Default|Description|
|---|---|---|
|WATCHDOG_CONTAINER_LABEL|watchdog|Defines a label name the watchdog is looking for. If it finds a container with this lable set to "true" it will watch it. To watch all cntainers on the host the watchdog is running on set it to "all"|

## Miscellaneous

### Beta testing

If you want to get the newest features and changes feel free to use/ test the beta version of the Docker image. You can find the readme.md file for beta versions [here](https://github.com/buanet/docker-watchdog/blob/beta/README.md). Please make sure to read the changelog before testing beta versions.

### Roadmap

There are some more watchdog features planned e.g.
* Unhealthy/ Restart notifications by Telegram and/or e-mail

### Support the project

The easiest way to support this project is to leave me some likes/ stars on Github and Docker hub!<br>
If you want to give something back, feel free to take a look into the [open issues](https://github.com/buanet/docker-watchdog/issues) and helping me answering questions, fixing bugs or adding new features!<br>
And if you want to buy me a beer instead, you can do this here: <a href="https://www.paypal.me/buanet" target="_blank"><img src="https://buanet.de/wp-content/uploads/2017/08/pp128.png" height="20" width="20"></a><br>
Thank you!

## Changelog

### v1.0.1-beta.1 (2021-07-09)
* adding labels in OCI standard format
* v1.0.1-beta (2021-07-02)
  * moving auto build to github actions
  * publishing image on ghcr.io docker registry

### v1.0.0 (2020-08-18)
* pushing beta to first stable release
* v0.0.2beta (2020-08-17)
  * switched base image to balenalib alpine
  * added multiarch support for arm32v7, arm64v8 and amd64
  * added automated building of images
  * added documentation
* v0.0.1beta (2020-08-10)
  * project started / initial release

## License

MIT License

Copyright (c) 2020 [André Germann]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Credits

Inspired by https://github.com/willfarrell/docker-autoheal
