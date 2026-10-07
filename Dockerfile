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

# Download and extract KICKS for TSO (CICS-compatible transaction processor)
# KICKS allows running CICS-style applications on MVS 3.8j
RUN mkdir -p /opt/kicks && \
    wget --no-check-certificate https://github.com/moshix/kicks/raw/master/kicks-tso-v1r5m0.zip -O /opt/kicks/kicks-tso-v1r5m0.zip && \
    unzip /opt/kicks/kicks-tso-v1r5m0.zip -d /opt/kicks || true && \
    rm /opt/kicks/kicks-tso-v1r5m0.zip

# Create a helper script for KICKS installation guidance
RUN echo '#!/bin/bash' > /opt/kicks/install-kicks.sh && \
    echo 'echo "=============================================="' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "KICKS Installation Guide for TK4- MVS"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "=============================================="' >> /opt/kicks/install-kicks.sh && \
    echo 'echo ""' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "KICKS files are located at: /opt/kicks/kicks-tso-v1r5m0/"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo ""' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "Installation Steps (run inside MVS via 3270 terminal):"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "1. Log on to TSO as HERC01 or HERC02"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "2. Use IND\$FILE or FTP to upload kicks-tso-v1r5m0/xmi/kicks.v1r5m0.install.xmi"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "3. Run RECEIVE INDSN(uploaded.xmi) to unpack"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "4. Follow prompts to install to KICKS.V1R5M0.INSTALL"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "5. Edit and submit V1R5M0 member to unpack all datasets"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo ""' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "For detailed instructions, see:"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "  - /opt/kicks/kicks-tso-v1r5m0/User'\''s Guide/"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo "  - https://www.jaymoseley.com/hercules/kicks/index.htm"' >> /opt/kicks/install-kicks.sh && \
    echo 'echo ""' >> /opt/kicks/install-kicks.sh && \
    chmod +x /opt/kicks/install-kicks.sh

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

# Expose ports for access:
# - 21: FTP access
# - 3270: 3270 terminal access
# - 3505: Card reader (for submitting JCL)
EXPOSE 21 3270 3505

