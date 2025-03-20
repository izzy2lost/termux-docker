FROM ubuntu:latest

# Install cross-compilation tools and dependencies
RUN apt update && apt install -y \
    build-essential \
    git \
    wget \
    python3 \
    make \
    zip \
    unzip \
    clang \
    binutils \
    libglvnd-dev \
    android-sdk-platform-tools \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    libc6-dev-armhf-cross \
    && rm -rf /var/lib/apt/lists/*

# Set up Android NDK
RUN mkdir -p /opt/android-ndk && \
    wget https://dl.google.com/android/repository/android-ndk-r25b-linux.zip -O /tmp/ndk.zip && \
    unzip /tmp/ndk.zip -d /opt/android-ndk && \
    rm /tmp/ndk.zip

# Set environment variables
ENV ANDROID_NDK_HOME=/opt/android-ndk/android-ndk-r25b
ENV PATH="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}"

# Create working directory
WORKDIR /workspace

# Set entrypoint
ENTRYPOINT ["/bin/bash"]
