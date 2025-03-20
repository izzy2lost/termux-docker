FROM ubuntu:latest

# Install base dependencies
RUN apt update && apt install -y \
    proot \
    git \
    wget \
    curl \
    unzip \
    python3 \
    file \
    bash \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Create Termux root directory
RUN mkdir -p /termux

# Download and extract Termux bootstrap from GitHub
RUN wget https://github.com/termux/termux-packages/releases/latest/download/bootstrap-$(uname -m).zip -O /tmp/bootstrap.zip && \
    unzip /tmp/bootstrap.zip -d /termux && \
    rm /tmp/bootstrap.zip

# Set up basic environment
RUN echo "export TERMUX=/termux" >> /root/.bashrc && \
    echo "export PATH=\$PATH:/termux/usr/bin" >> /root/.bashrc && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/termux/usr/lib" >> /root/.bashrc

# Install required Termux packages through proot
RUN proot -b /proc -b /dev -b /sys \
    -r /termux \
    /usr/bin/env -i \
    HOME=/root \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/termux/usr/bin \
    /termux/usr/bin/bash -c " \
    apt update && \
    apt upgrade -y && \
    apt install -y \
        git \
        wget \
        make \
        python \
        getconf \
        zip \
        apksigner \
        clang \
        binutils \
        libglvnd-dev \
        aapt \
        which \
        ndk-multilib \
        termux-exec \
        libandroid-support \
    && apt clean"

# Set working directory and entrypoint
WORKDIR /workspace
ENTRYPOINT ["proot", "-b", "/proc", "-b", "/dev", "-b", "/sys", "-r", "/termux", "/termux/usr/bin/bash", "-l"]
