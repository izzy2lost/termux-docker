FROM ubuntu:latest

# Install host dependencies
RUN apt update && apt install -y \
    proot \
    wget \
    xz-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create Termux root directory
RUN mkdir -p /termux

# Download Termux bootstrap
RUN wget https://github.com/termux/termux-packages/releases/download/bootstrap-2023.07.04/bootstrap-aarch64.zip \
    -O /tmp/bootstrap.zip && \
    unzip /tmp/bootstrap.zip -d /termux && \
    rm /tmp/bootstrap.zip

# Configure environment
RUN echo 'export TERMUX=/termux' >> /etc/profile && \
    echo 'export PATH=$PATH:/termux/usr/bin' >> /etc/profile && \
    echo 'export LD_LIBRARY_PATH=/termux/usr/lib' >> /etc/profile

# Base Termux setup
RUN proot -b /proc -b /dev -b /sys \
    -r /termux \
    /usr/bin/env -i \
    HOME=/root \
    TERM=$TERM \
    PATH=/usr/bin:/usr/sbin \
    /termux/usr/bin/bash -c \
    "apt update && apt upgrade -y"

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
