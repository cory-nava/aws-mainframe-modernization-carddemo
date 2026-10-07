#!/bin/bash
#############################################################################
# Upload CardDemo Files to TK4- MVS
#
# This script prepares CardDemo source files for upload to MVS and provides
# guidance on completing the upload process.
#
# OVERVIEW:
# ---------
# CardDemo requires the following file types to be uploaded to MVS:
#   - COBOL source files (.cbl) -> CARDDEMO.COBOL dataset
#   - Copybooks (.cpy)          -> CARDDEMO.COPY dataset
#   - BMS maps (.bms)           -> CARDDEMO.BMS dataset
#   - JCL files (.jcl)          -> CARDDEMO.JCL dataset
#
# MVS DATASET REQUIREMENTS:
# -------------------------
# All datasets must be created as Partitioned Datasets (PDS) with:
#   - RECFM=FB (Fixed Block)
#   - LRECL=80 (80-byte logical records)
#   - BLKSIZE=6160 (77 records per block)
#
# UPLOAD METHODS:
# ---------------
# 1. FTP (if working on your system)
# 2. IND$FILE via 3270 terminal (requires IND$FILE on MVS)
# 3. Card reader (for small files, JCL submission)
#
# Usage: ./upload-to-mvs.sh [container_id]
#
# If container_id is not provided, the script will attempt to find
# the running carddemo-mvs container automatically.
#############################################################################

set -e

# Get script directory for relative paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Get container ID from argument or find running container
CONTAINER_ID=${1:-$(docker ps -q --filter "name=carddemo-mvs" 2>/dev/null)}

if [ -z "$CONTAINER_ID" ]; then
    echo "=============================================="
    echo "  CardDemo Upload Helper"
    echo "=============================================="
    echo ""
    echo "Error: No running carddemo-mvs container found."
    echo ""
    echo "Please start MVS first with:"
    echo "  ./start-mvs.sh"
    echo ""
    echo "Or provide a container ID:"
    echo "  $0 <container_id>"
    exit 1
fi

echo "=============================================="
echo "  CardDemo Upload Helper"
echo "=============================================="
echo ""
echo "Container ID: $CONTAINER_ID"
echo "Project Root: $PROJECT_ROOT"
echo ""

#############################################################################
# STEP 1: Verify Container Status
#############################################################################
echo "[Step 1/4] Verifying container status..."

if ! docker ps -q | grep -q "$CONTAINER_ID"; then
    echo "Error: Container $CONTAINER_ID is not running"
    exit 1
fi

echo "  Container is running"
echo ""

#############################################################################
# STEP 2: Stage Files in Container
#############################################################################
echo "[Step 2/4] Staging CardDemo files in container..."

# Create staging directory
docker exec "$CONTAINER_ID" mkdir -p /opt/carddemo-upload

# Count source files
COBOL_COUNT=$(ls -1 "$PROJECT_ROOT/app/cbl/"*.cbl 2>/dev/null | wc -l | tr -d ' ')
COPY_COUNT=$(ls -1 "$PROJECT_ROOT/app/cpy/"*.cpy 2>/dev/null | wc -l | tr -d ' ')
BMS_COUNT=$(ls -1 "$PROJECT_ROOT/app/bms/"*.bms 2>/dev/null | wc -l | tr -d ' ')
JCL_COUNT=$(ls -1 "$SCRIPT_DIR/"*.jcl 2>/dev/null | wc -l | tr -d ' ')

echo "  Found source files:"
echo "    COBOL programs: $COBOL_COUNT"
echo "    Copybooks:      $COPY_COUNT"
echo "    BMS maps:       $BMS_COUNT"
echo "    JCL files:      $JCL_COUNT"

# Copy files to container staging area
echo ""
echo "  Copying files to container..."

# COBOL source
docker exec "$CONTAINER_ID" mkdir -p /opt/carddemo-upload/cobol
for f in "$PROJECT_ROOT/app/cbl/"*.cbl; do
    [ -f "$f" ] && docker cp "$f" "$CONTAINER_ID:/opt/carddemo-upload/cobol/"
done

# Copybooks
docker exec "$CONTAINER_ID" mkdir -p /opt/carddemo-upload/copy
for f in "$PROJECT_ROOT/app/cpy/"*.cpy; do
    [ -f "$f" ] && docker cp "$f" "$CONTAINER_ID:/opt/carddemo-upload/copy/"
done

# BMS maps
docker exec "$CONTAINER_ID" mkdir -p /opt/carddemo-upload/bms
for f in "$PROJECT_ROOT/app/bms/"*.bms; do
    [ -f "$f" ] && docker cp "$f" "$CONTAINER_ID:/opt/carddemo-upload/bms/"
done

# JCL files
docker exec "$CONTAINER_ID" mkdir -p /opt/carddemo-upload/jcl
for f in "$SCRIPT_DIR/"*.jcl; do
    [ -f "$f" ] && docker cp "$f" "$CONTAINER_ID:/opt/carddemo-upload/jcl/"
done

echo "  Files staged at /opt/carddemo-upload/"
echo ""

#############################################################################
# STEP 3: Display TSO Dataset Creation Commands
#############################################################################
echo "[Step 3/4] TSO Commands for Dataset Creation"
echo ""
echo "  Log into TSO (HERC01/CUL8TR) and run these commands at READY prompt:"
echo ""
echo "  ----------------------------------------------------------------"
echo "  ALLOC DA('CARDDEMO.COBOL') NEW CATALOG DSORG(PO) RECFM(F,B) -"
echo "        LRECL(80) BLKSIZE(6160) SPACE(5,5) CYL DIR(50)"
echo ""
echo "  ALLOC DA('CARDDEMO.COPY') NEW CATALOG DSORG(PO) RECFM(F,B) -"
echo "        LRECL(80) BLKSIZE(6160) SPACE(2,2) CYL DIR(50)"
echo ""
echo "  ALLOC DA('CARDDEMO.BMS') NEW CATALOG DSORG(PO) RECFM(F,B) -"
echo "        LRECL(80) BLKSIZE(6160) SPACE(2,2) CYL DIR(50)"
echo ""
echo "  ALLOC DA('CARDDEMO.JCL') NEW CATALOG DSORG(PO) RECFM(F,B) -"
echo "        LRECL(80) BLKSIZE(6160) SPACE(2,2) CYL DIR(50)"
echo "  ----------------------------------------------------------------"
echo ""

#############################################################################
# STEP 4: Display Upload Instructions
#############################################################################
echo "[Step 4/4] Upload Instructions"
echo ""
echo "=============================================="
echo "  OPTION A: FTP Upload (from host machine)"
echo "=============================================="
echo ""
echo "  ftp localhost 2121"
echo "  User: HERC01"
echo "  Password: CUL8TR"
echo ""
echo "  ascii"
echo "  cd CARDDEMO.COBOL"
echo "  lcd $PROJECT_ROOT/app/cbl"
echo "  mput *.cbl"
echo ""
echo "  cd ../CARDDEMO.COPY"
echo "  lcd $PROJECT_ROOT/app/cpy"
echo "  mput *.cpy"
echo ""
echo "  cd ../CARDDEMO.BMS"
echo "  lcd $PROJECT_ROOT/app/bms"
echo "  mput *.bms"
echo ""
echo "  cd ../CARDDEMO.JCL"
echo "  lcd $SCRIPT_DIR"
echo "  mput *.jcl"
echo ""
echo "  quit"
echo ""
echo "=============================================="
echo "  OPTION B: Python FTP Script (Recommended)"
echo "=============================================="
echo ""
echo "  python3 kicks/upload-carddemo.py"
echo ""
echo "  This handles MVS FTP quirks automatically."
echo ""
echo "=============================================="
echo ""
echo "After uploading, submit JCL jobs in order:"
echo "  1. SUBMIT 'CARDDEMO.JCL(DEFVSAM)'"
echo "  2. SUBMIT 'CARDDEMO.JCL(LOADUSR)'"
echo "  3. SUBMIT 'CARDDEMO.JCL(ASMFCT)'"
echo "  4. SUBMIT 'CARDDEMO.JCL(ASMPCT)'"
echo "  5. SUBMIT 'CARDDEMO.JCL(ASMPPT)'"
echo "  6. SUBMIT 'CARDDEMO.JCL(ASMMAP)'"
echo "  7. SUBMIT 'CARDDEMO.JCL(COMPCOB)'"
echo ""
echo "Check job status with: ST HERC01"
echo "=============================================="
