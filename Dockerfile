FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y \
    proot \
    git \
    wget \
    curl \
    unzip \
    python3 \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Clone proot-distro from Termux and install it manually
RUN git clone --depth=1 https://github.com/termux/proot-distro.git /opt/proot-distro && \
    cp /opt/proot-distro/proot-distro /usr/local/bin/proot-distro && \
    chmod +x /usr/local/bin/proot-distro

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
