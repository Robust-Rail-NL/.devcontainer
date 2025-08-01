# Use Ubuntu 20.04 as the base image
FROM --platform=linux/amd64 ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN echo "UID=$USER_UID GID=$USER_GID USERNAME=$USERNAME"


RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Update package list and install dependencies
RUN apt update && apt install -y \
    wget \
    curl \
    git \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt update \
    && apt install -y gcc-9 g++-9 \
    && rm -rf /var/lib/apt/lists/*


# Set GCC and G++ 9.4.0 as the default versions
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

# Verify GCC and G++ installation
RUN gcc --version && g++ --version

# Install Conda (Anaconda 24.1.2)
RUN curl -o Anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh \
    && bash Anaconda.sh -b -p /opt/conda \
    && rm Anaconda.sh

# Set Conda environment variables
ENV PATH="/opt/conda/bin:$PATH"


# Download and install CMake 3.16.3
RUN apt update && apt install -y cmake


# Install Microsoft package repository for .NET
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN chmod 755 packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb


# Install .NET SDK 8.0
RUN apt-get update && apt-get install -y dotnet-sdk-8.0

USER $USERNAME


# Create workspace directory
WORKDIR /workspace

# Set default command to keep the container running
CMD [ "bash" ]
#root@528584ce6abc