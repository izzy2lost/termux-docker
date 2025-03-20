FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y proot-distro git wget curl unzip

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
