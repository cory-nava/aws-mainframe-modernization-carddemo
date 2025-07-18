# Lessons Learned from Dockerizing CardDemo

This document outlines key challenges and solutions encountered while setting up the Docker environment for the CardDemo mainframe application. These insights are valuable for anyone attempting similar mainframe emulation projects.

## 1. COBOL Source File Formatting

**Challenge:** Initial attempts to compile COBOL programs within Docker resulted in `invalid indicator 'F' at column 7` and other syntax errors. This was misleading, as the files compiled correctly on macOS.

**Root Cause:** COBOL source files, especially those originating from mainframe environments, often have specific fixed-format requirements (e.g., code starting in column 8). While `dos2unix` was initially considered for line ending issues, the primary problem was incorrect column alignment for the GnuCOBOL compiler.

**Solution:** Manually padding the COBOL source files (`.cbl`) with leading spaces to ensure that the code started in column 8 (Area A) resolved the `invalid indicator` errors. This highlighted the strictness of fixed-format COBOL compilation.

## 2. GnuCOBOL Compilation with Mixed Formats

**Challenge:** The project's `Makefile` was designed to compile some COBOL files in `free` format and others in `fixed` format. Initial Dockerfile attempts to force a single compilation format (`-fixed` or `-free`) for all files led to persistent compilation errors.

**Root Cause:** The `Makefile` correctly specified the `-free` or `-fixed` flags per source file. The Docker build process needed to respect this existing build logic.

**Solution:** Instead of trying to compile individual files directly in the `Dockerfile`, the `Dockerfile` was updated to simply run `make`. This allowed the project's `Makefile` to handle the nuanced compilation process, ensuring the correct flags were applied to each COBOL source file.

## 3. Cross-Architecture Docker Builds (ARM64 Host, i386 Binaries)

**Challenge:** Running the `tk4-` MVS distribution (which contains 32-bit Intel binaries) on an ARM64 host (like Apple Silicon) within a Docker container led to `qemu-i386: Could not open '/lib/ld-linux.so.2'` and `error while loading shared libraries: libz.so.1` errors.

**Root Cause:** The `tk4-` distribution's Hercules executable and its dependencies are compiled for `i386` (32-bit Intel) architecture. The `ubuntu:22.04` base image is `arm64`. While Docker Desktop handles the QEMU emulation, the `arm64` Ubuntu repositories do not provide `i386` versions of all necessary system libraries by default.

**Solution:** A multi-step approach was required in the `Dockerfile`:
    1.  `dpkg --add-architecture i386`: Enabled the `i386` architecture for `apt`.
    2.  **Crucially**, modified `/etc/apt/sources.list` to explicitly specify `[arch=arm64]` for the default Ubuntu repositories. This prevented `apt` from trying to find `i386` packages in the `arm64`-only `ports.ubuntu.com` repositories, which would result in 404 errors.
    3.  Added new `sources.list.d` entries specifically for `[arch=i386]` pointing to the standard `archive.ubuntu.com` and `security.ubuntu.com` repositories (which *do* host `i386` packages).
    4.  Installed the required 32-bit libraries (e.g., `libc6:i386`, `zlib1g:i386`, `libbz2-1.0:i386`) alongside their 64-bit counterparts.

This complex configuration ensures that `apt` can correctly resolve and install dependencies for both architectures, allowing the 32-bit Hercules binaries to run via QEMU emulation.

## 4. `tk4-` Distribution Location and Execution

**Challenge:** After successful build, the `mvs` startup script for TK4- would immediately exit with a `Shutdown sequence complete` message.

**Root Cause:** The `tk4-` distribution extracts its files directly into the root directory (`/`) of the container. The `Dockerfile` sets the `WORKDIR` to `/app`. When `mvs` was executed from `/app`, it could not find its necessary configuration files and disk images.

**Solution:** The `docker run` command was modified to explicitly set the working directory to the root (`/`) using the `-w /` flag when launching the container for the mainframe. This ensures that the `mvs` script is executed from the correct context.

```bash
docker run -it --rm -w / carddemo ./mvs
```

These lessons highlight the intricacies of working with legacy systems and cross-architecture environments within Docker, emphasizing the importance of precise configuration and understanding underlying system requirements.