FROM ubuntu:latest

# Install host system dependencies
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

# Download and extract Termux rootfs
RUN wget https://termux.dev/termux-rootfs/termux-rootfs-latest.tar.xz && \
    tar -xJf termux-rootfs-latest.tar.xz -C /termux && \
    rm termux-rootfs-latest.tar.xz

# Basic Termux environment setup
RUN echo "export TERMUX=/termux" >> /root/.bashrc && \
    echo "export PATH=\$PATH:/termux/bin" >> /root/.bashrc

# Install required Termux packages through proot
RUN proot -b /proc -b /dev -b /sys \
    -r /termux \
    /bin/bash -c " \
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
ENTRYPOINT ["proot", "-b", "/proc", "-b", "/dev", "-b", "/sys", "-r", "/termux", "/bin/bash", "-l"]
