#!/bin/bash
#############################################################################
# CardDemo TK4- MVS Startup Script
#
# This script starts the TK4- MVS mainframe emulator with all necessary
# ports mapped and prepares KICKS installation files.
#
# OVERVIEW:
# ---------
# TK4- is a turnkey MVS 3.8j system running on the Hercules mainframe
# emulator. This script:
#   1. Validates Docker environment
#   2. Converts KICKS XMI file to Hercules AWS tape format
#   3. Starts MVS with required port mappings
#   4. Provides instructions for completing KICKS installation
#
# PORTS:
# ------
#   - 3270: IBM 3270 terminal emulation (for TSO/ISPF access)
#   - 2121: FTP server (mapped from container port 21)
#   - 8038: Hercules HTTP console (web-based system monitoring)
#
# KICKS:
# ------
# KICKS is a CICS-compatible transaction processor for MVS 3.8j.
# The KICKS installation file (XMI format) must be converted to
# Hercules AWS tape format before it can be read by MVS.
#
# Usage: ./start-mvs.sh
#############################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=============================================="
echo "  CardDemo TK4- MVS Startup Script"
echo "=============================================="
echo ""

#############################################################################
# STEP 1: Validate Docker Environment
#############################################################################
echo "[Step 1/5] Checking Docker environment..."

if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

if ! docker image inspect carddemo > /dev/null 2>&1; then
    echo "Error: 'carddemo' Docker image not found."
    echo "Please build it first with: docker build -t carddemo ."
    exit 1
fi

echo "  ✓ Docker is running"
echo "  ✓ carddemo image exists"
echo ""

#############################################################################
# STEP 2: Stop Existing Containers
#############################################################################
echo "[Step 2/5] Stopping any existing carddemo containers..."
docker ps -q --filter "name=carddemo-mvs" | xargs -r docker stop 2>/dev/null || true
docker ps -aq --filter "name=carddemo-mvs" | xargs -r docker rm 2>/dev/null || true
echo "  ✓ Cleanup complete"
echo ""

#############################################################################
# STEP 3: Convert KICKS XMI to AWS Tape Format
#############################################################################
echo "[Step 3/5] Preparing KICKS installation tape..."

# The KICKS distribution comes as an XMI file (IBM NETDATA format).
# This is the output of TSO TRANSMIT command and contains a packaged PDS.
#
# Hercules (the mainframe emulator) cannot read raw XMI files as tapes.
# We must convert it to AWS (Automatic Workstation) tape format, which
# is Hercules' native tape format.
#
# AWS Format Structure:
# - Each block has a 6-byte header:
#   - Bytes 0-1: Current block length (little-endian)
#   - Bytes 2-3: Previous block length (little-endian)
#   - Byte 4: Flags (0xA0=data block, 0x40=tape mark)
#   - Byte 5: Reserved (0x00)
# - Followed by the data block
# - Ends with a tape mark (zero-length block with 0x40 flag)

XMI_SOURCE="kicks-tso-v1r5m0.xmi"
AWS_OUTPUT="kicks-tso-v1r5m0.aws"

# Check if XMI file exists (either extracted or needs extraction)
if [ ! -f "$XMI_SOURCE" ]; then
    echo "  Extracting KICKS XMI from Docker image..."
    # Start temporary container to extract the file
    TEMP_CONTAINER=$(docker create carddemo)
    docker cp "$TEMP_CONTAINER:/opt/kicks/kicks-tso-v1r5m0/kicks-tso-v1r5m0.xmi" "$XMI_SOURCE" 2>/dev/null || true
    docker rm "$TEMP_CONTAINER" > /dev/null
fi

if [ ! -f "$XMI_SOURCE" ]; then
    echo "Error: Cannot find KICKS XMI file."
    echo "Please ensure the Docker image was built correctly."
    exit 1
fi

echo "  Converting XMI to AWS tape format..."

# Python script to convert NETDATA XMI to Hercules AWS tape format
python3 << 'PYTHON_SCRIPT'
"""
XMI to AWS Tape Converter

Converts IBM NETDATA (XMI) files to Hercules AWS tape format.

The XMI file is the raw output of TSO TRANSMIT - it's just the data
that would have been written to tape. We wrap it in AWS format so
Hercules can read it as a virtual tape.

AWS tape format (per block):
  - 2 bytes: current block length (little-endian unsigned short)
  - 2 bytes: previous block length (little-endian unsigned short)
  - 1 byte:  flags (0xA0 for data, 0x40 for tape mark)
  - 1 byte:  reserved (always 0x00)
  - N bytes: data (where N = current block length)
"""
import struct
import os
import sys

XMI_FILE = "kicks-tso-v1r5m0.xmi"
AWS_FILE = "kicks-tso-v1r5m0.aws"

# Block size for tape records
# XMI files are typically FB80 (fixed block, 80-byte records)
# We use 3120 bytes per block (39 records x 80 bytes)
BLKSIZE = 3120

def write_aws_block(f, data, prev_len):
    """
    Write a data block in AWS tape format.

    Args:
        f: Output file handle
        data: Block data to write
        prev_len: Length of the previous block (for chaining)

    Returns:
        Length of current block (to pass as prev_len to next call)
    """
    cur_len = len(data)
    # AWS header: cur_len, prev_len (both little-endian), flags=0xA0, reserved=0x00
    header = struct.pack('<HH', cur_len, prev_len) + b'\xa0\x00'
    f.write(header)
    f.write(data)
    return cur_len

def write_tape_mark(f, prev_len):
    """
    Write a tape mark in AWS format.

    A tape mark signals end-of-file on tape. It's a zero-length
    block with the 0x40 flag set.
    """
    header = struct.pack('<HH', 0, prev_len) + b'\x40\x00'
    f.write(header)
    return 0

# Read the XMI file
try:
    with open(XMI_FILE, 'rb') as f:
        xmi_data = f.read()
except FileNotFoundError:
    print(f"Error: {XMI_FILE} not found")
    sys.exit(1)

# Write AWS tape
with open(AWS_FILE, 'wb') as f:
    prev_len = 0
    offset = 0
    block_count = 0

    # Write data blocks
    while offset < len(xmi_data):
        block_data = xmi_data[offset:offset + BLKSIZE]
        prev_len = write_aws_block(f, block_data, prev_len)
        block_count += 1
        offset += BLKSIZE

    # Write tape mark to signal end of file
    write_tape_mark(f, prev_len)

print(f"  Converted: {len(xmi_data):,} bytes -> {os.path.getsize(AWS_FILE):,} bytes")
print(f"  Blocks: {block_count}")
PYTHON_SCRIPT

if [ ! -f "$AWS_OUTPUT" ]; then
    echo "Error: Failed to create AWS tape file"
    exit 1
fi

echo "  ✓ AWS tape file created: $AWS_OUTPUT"
echo ""

#############################################################################
# STEP 4: Display Port Information
#############################################################################
echo "[Step 4/5] Starting TK4- MVS with the following ports:"
echo ""
echo "  Port 3270  -> 3270 Terminal (TSO/ISPF access)"
echo "  Port 2121  -> FTP Server (file uploads)"
echo "  Port 8038  -> Hercules Web Console"
echo ""

#############################################################################
# STEP 5: Show Post-Boot Instructions
#############################################################################
echo "[Step 5/5] Post-boot instructions:"
echo ""
echo "=============================================="
echo "  AFTER MVS BOOTS (wait for console to settle)"
echo "=============================================="
echo ""
echo "1. OPEN 3270 TERMINAL (new terminal window):"
echo "   docker exec -it carddemo-mvs c3270 localhost:3270"
echo ""
echo "2. LOG INTO TSO:"
echo "   - At 'ENTER USERID': type HERC01"
echo "   - At 'ENTER PASSWORD': type CUL8TR"
echo ""
echo "3. MOUNT KICKS TAPE (in Hercules console - this terminal):"
echo "   devinit 480 /opt/tk4-mvs/tapes/kicks.aws"
echo ""
echo "4. COPY TAPE TO DISK (submit JCL from TSO READY prompt):"
echo "   See kicks/INSTALL-GUIDE.txt for detailed instructions"
echo ""
echo "=============================================="
echo ""
echo "Press Enter to start MVS, or Ctrl+C to cancel..."
read

#############################################################################
# Start MVS Container
#############################################################################

# Copy the AWS tape file into the container after it starts
# We use a background process to do this once the container is running

(
    # Wait for container to be fully running
    sleep 5
    CONTAINER_ID=$(docker ps -q --filter "name=carddemo-mvs" 2>/dev/null)
    if [ -n "$CONTAINER_ID" ]; then
        # Create tapes directory if it doesn't exist
        docker exec "$CONTAINER_ID" mkdir -p /opt/tk4-mvs/tapes 2>/dev/null || true
        # Copy the AWS tape file
        docker cp "$AWS_OUTPUT" "$CONTAINER_ID:/opt/tk4-mvs/tapes/kicks.aws" 2>/dev/null || true
        echo ""
        echo "[Background] KICKS tape copied to container: /opt/tk4-mvs/tapes/kicks.aws"
        echo "[Background] Mount with: devinit 480 /opt/tk4-mvs/tapes/kicks.aws"
    fi
) &

# Start MVS interactively
# The Hercules console will be displayed here - this is where you
# enter Hercules commands like 'devinit' to mount tapes
docker run -it --rm \
    -p 3270:3270 \
    -p 2121:21 \
    -p 8038:8038 \
    -w /opt/tk4-mvs \
    --name carddemo-mvs \
    carddemo \
    ./mvs
