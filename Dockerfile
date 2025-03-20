FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y \
    proot \
    git \
    wget \
    curl \
    unzip \
    python3 \
    file \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Clone and install proot-distro
RUN git clone https://github.com/termux/proot-distro.git /opt/proot-distro && \
    cd /opt/proot-distro && \
    chmod +x install.sh && \
    ./install.sh

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
