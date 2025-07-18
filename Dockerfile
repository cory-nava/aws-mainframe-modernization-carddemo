# Use the official Ubuntu 22.04 image as a base
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools, Hercules, and other dependencies for mainframe emulation.
# This is a multi-architecture setup to run 32-bit Hercules binaries on ARM64.
RUN dpkg --add-architecture i386 && \
    # 1. Restrict the default ARM64 repos to only look for ARM64 packages.
    sed -i 's/^deb /deb [arch=arm64] /' /etc/apt/sources.list && \
    # 2. Add the x86 repos specifically for the i386 architecture.
    echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list.d/i386.list && \
    echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/i386.list && \
    echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/i386.list && \
    echo "deb [arch=i386] http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list.d/i386.list && \
    # 3. Now, update and install all packages.
    apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gnucobol \
    make \
    bzip2 \
    libbz2-dev \
    zlib1g-dev \
    libtool \
    autoconf \
    g++ \
    hercules \
    c3270 \
    wget \
    unzip \
    libc6:i386     zlib1g:i386     libbz2-1.0:i386     && rm -rf /var/lib/apt/lists/*

# Download and extract the tk4- MVS distribution from the mirror site.
# Extract it into a dedicated directory to avoid conflicts with application files.
RUN mkdir -p /opt/tk4-mvs && wget https://wotho.pebble-beach.ch/tk4-/tk4-_v1.00_current.zip --no-check-certificate -O /opt/tk4-mvs/tk4-_v1.00_current.zip && \
    unzip /opt/tk4-mvs/tk4-_v1.00_current.zip -d /opt/tk4-mvs && \
    rm /opt/tk4-mvs/tk4-_v1.00_current.zip

    # RUN wget https://wotho.pebble-beach.ch/tk4-/tk4-_v1.00_current.zip --no-check-certificate && \
#     unzip tk4-_v1.00_current.zip && \
#     rm tk4-_v1.00_current.zip


# Verify the contents of the root directory after extraction.
RUN ls -l /

# Configure Hercules to run in console mode by creating the unattended/mode file
# within the tk4-mvs directory.
RUN echo "CONSOLE" > /opt/tk4-mvs/unattended/mode

# Add CTCI device for TCP/IP networking.
RUN echo "0700-0701 CTCI 10.0.0.2 10.0.0.1" >> /opt/tk4-mvs/conf/tk4-.cnf

# Set the working directory for the application code
WORKDIR /app

# Copy the entire CardDemo application into the container's /app directory
COPY . .

# Create the requested log directories.
RUN mkdir log

# Build the test runner using the Makefile.
RUN make

# Set the default command to open a bash shell when the container starts.
CMD ["/bin/bash"]

# Expose port 21 for FTP access.
EXPOSE 21

