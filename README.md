<!-- Copyright (c) Meta Platforms, Inc. and affiliates.

License found in the LICENSE file in the root directory
of this source tree. -->
# WhatsApp Chat Proxy — POWER FORK 💥

[<img alt="github" src="https://img.shields.io/badge/github-WhatsApp/proxy-8da0cb?style=for-the-badge&labelColor=555555&logo=github" height="20">](https://github.com/WhatsApp/proxy)
[![CI](https://github.com/WhatsApp/proxy/actions/workflows/ci.yml/badge.svg)](https://github.com/WhatsApp/proxy/actions/workflows/ci.yml)

> **FORKED & SUPERCHARGED by appycody58-byte**  
> Original Meta limits? Broken.  
> Concurrent connections raised from **27.5K → 50K**.  
> Ready for heavier traffic, more users, and zero compromise.  
> This is the version that doesn’t ask permission.

If you are unable to connect directly to WhatsApp, a proxy can be used as a gateway between you and our servers. To help yourself or others re-establish connection to WhatsApp, you can set up a proxy server.

If you already have a proxy to use, you can connect it to WhatsApp by following the steps in this [article](https://faq.whatsapp.com/520504143274092).

## Frequently asked questions

**PLEASE READ THIS BEFORE OPENING AN ISSUE** We have an FAQ, which you can find here: [FAQ.md](https://github.com/whatsapp/proxy/blob/main/FAQ.md)

## What you'll need

1. [Docker](https://docs.docker.com/engine/install/) (enable Docker on startup if your host system allows)
2. [Docker compose](https://docs.docker.com/compose/) (optional)

## Setting up your proxy

**UPDATE** There is now a pre-built image hosted in Meta's DockerHub repository. You no longer need to build the default image (if you don't want to customize it of course).

```bash
docker pull facebook/whatsapp_proxy:latest
```

You can then skip down to **Running the proxy** and substitute any tag of `whatsapp_proxy:1.0` with `facebook/whatsapp_proxy:latest`.

### 1. Clone the repository to your local machine

```bash
git clone https://github.com/appycody58-byte/proxy.git
```

You should see a folder called `proxy` created in the current directory.

### 2. [Install Docker](https://docs.docker.com/get-docker/) for your system

To confirm Docker is successfully installed:

```bash
docker --version
```

should display a line similar to `Docker version 20.10.21, build baeda1f`.

### 2. (Optional) Install Docker compose

For Linux users, if your [version of Docker](https://docs.docker.com/desktop/install/linux-install/) doesn't come pre-installed with Docker compose, you can install a one-off version (For Linux).

```bash
# Download the pkg
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
# Enable execution of the script
sudo chmod +x /usr/bin/docker-compose
```

### 3. Build the proxy host container

Navigate to the repo directory

```bash
cd proxy
```

Build the proxy host container with

```bash
docker build proxy/ -t whatsapp_proxy:1.0
```

You should see a message similar to `[+] Building 6.6s (18/18) FINISHED`. The container will be compiled and tagged as `whatsapp_proxy:1.0` for easy reference.

## Running the proxy

### Manually execute the container

You can manually execute the Docker container with the following `docker` command

```bash
docker run -it -p 80:80 -p 443:443 -p 5222:5222 -p 8080:8080 -p 8443:8443 -p 8222:8222 -p 8199:8199 -p 587:587 -p 7777:7777 whatsapp_proxy:1.0
```

You will see lines ending with `Certificate generation completed.`. The HAProxy is running in the background and will continue to do so until you close this process.

### Check your connection

To confirm HAProxy is running, visit `http://<host-ip>:8199` where `<host-ip>` is your **public** IP address. You can also use this link to monitor proxy statistics.

> NOTE: If your public IP address is not accessible, you will need to enable port forwarding (for the ports above) for the router/gateway you are using. Since this operation is device-specific, we are not going to go into it in details in this doc.

If you prefer OpenMetrics output you can use `http://<host-ip>:8199/metrics` for monitoring HAProxy metrics.

# Miscellanous

## An Overview of the WhatsApp Proxy Architecture

# Contributors

------------

The authors of this code are Sean Lawlor ([@slawlor](https://github.com/slawlor)).

To learn more about contributing to this project, [see this document](https://github.com/whatsapp/proxy/blob/main/CONTRIBUTING.md).

# License

------------

This project is licensed under [MIT](https://github.com/novifinancial/akd/blob/main/LICENSE-MIT).
