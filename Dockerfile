FROM ubuntu:latest

# Install required dependencies
RUN apt update && apt install -y \
    proot \
    git \
    wget \
    curl \
    unzip \
    python3 \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Manually install proot-distro
RUN wget https://raw.githubusercontent.com/termux/proot-distro/main/proot-distro -O /usr/local/bin/proot-distro && \
    chmod +x /usr/local/bin/proot-distro

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
