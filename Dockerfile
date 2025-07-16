# Use the official Ubuntu 22.04 image as a base
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools for building software and the GnuCOBOL compiler
RUN apt-get update && apt-get install -y     build-essential     gnucobol     make     && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the entire CardDemo application into the container's /app directory
COPY . .

# Build the test runner using the Makefile. This ensures that the correct
# compiler flags are used for both fixed and free-format COBOL source files.
RUN make

# Set the default command to open a bash shell when the container starts.
# This allows us to interactively work inside the emulated environment.
CMD ["/bin/bash"]

