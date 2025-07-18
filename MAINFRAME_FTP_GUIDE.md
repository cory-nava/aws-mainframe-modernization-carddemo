# Guide to FTP File Transfer to TK4- MVS

This guide provides step-by-step instructions on how to transfer application source files (BMS, COBOL, JCL) from your Docker container's Linux filesystem to the TK4- MVS mainframe environment using FTP.

## Prerequisites

*   Your container must be build (`docker build -t carddemo .`)
*   Your Docker container with TK4- MVS must be running (`docker run -it --rm -w / carddemo ./mvs`)
*   The FTP daemon on MVS must be started (`/start ftpd,srvport=21`)
*   You need the `CONTAINER ID` of your running Docker container (`docker ps`)

## Step 1: Ensure Dockerfile Exposes FTP Port

Your `Dockerfile` must include `EXPOSE 21` to indicate that the container listens on port 21 for FTP connections. This has already been added to your `Dockerfile`.

```dockerfile
# ... (other Dockerfile content)

# Set the default command to open a bash shell when the container starts.
CMD ["/bin/bash"]

# Expose port 21 for FTP access.
EXPOSE 21
```

## Step 2: Run the Docker Container with Port Mapping

When you start your Docker container, you must map the container's FTP port (21) to a port on your host machine (e.g., 2121). This allows your local FTP client to connect.

Open your terminal and run the following command:

```bash
docker run -it --rm -w /opt/tk4-mvs -p 2121:21 carddemo ./mvs
```

*   `-p 2121:21`: Maps port 2121 on your host to port 21 inside the container.

This terminal will become the mainframe's system console. Wait for MVS to boot up.

## Step 3: Start the FTP Daemon on MVS

Once MVS is running, you need to start the FTP server within the mainframe environment.

In the **Hercules console window** (the terminal where you ran the `docker run` command), type the following command and press **Enter**:

```
/start ftpd,srvport=21
```

Wait for messages in the console indicating that the FTP daemon has started successfully (e.g., `EZZ9301I FTPD INITIALIZATION COMPLETE`).

## Step 4: Get the IP Address of your Docker Container

Open a **NEW, separate terminal window** on your local machine (do not close the mainframe console or your 3270 terminal if it's open).

Run the following command to get the IP address of your running Docker container:

```bash
docker inspect -f '{{.NetworkSettings.IPAddress}}' <CONTAINER_ID>
```

Replace `<CONTAINER_ID>` with the actual ID of your running `carddemo` container (you can find it using `docker ps`).

## Step 5: Connect to the Mainframe via FTP

From your **local machine's terminal** (the new window you just opened), use the `ftp` command to connect to the mainframe. Use `localhost` and the host port you mapped (e.g., `2121`).

```bash
ftp localhost 2121
```

When prompted:
*   **Name:** `HERC01` (your TSO User ID)
*   **Password:** `CUL8TR` (your TSO password)

## Step 6: Transfer Your Application Files

Once logged into the FTP client, you can transfer your source files. Remember to set the transfer mode to `ascii` for text files.

**Important:** Before transferring, ensure you have allocated the necessary PDSs on the mainframe (e.g., `HERC01.CARDDEMO.BMS`, `HERC01.CARDDEMO.CBL`, `HERC01.CARDDEMO.CPY`, `HERC01.CARDDEMO.JCL`). If you haven't, you'll need to do that via TSO/ISPF first.

Here are the commands to transfer the main application source code directories:

*   **Set transfer mode to ASCII:**
    ```ftp
ascii
    ```

*   **Disable interactive prompting (optional, but recommended for `mput`):**
    ```ftp
prompt off
    ```

*   **Transfer BMS Maps (`app/bms`):**
    ```ftp
# First, change the remote directory to the target PDS
cd '//'HERC01.CARDDEMO.BMS''
# Then, change the local directory to your BMS source files
lcd /path/to/your/aws-mainframe-modernization-carddemo/app/bms
# Finally, use mput to transfer all .bms files
mput *.bms
    ```

*   **Transfer COBOL Programs (`app/cbl`):**
    ```ftp
# Change the remote directory to the target PDS
cd '//'HERC01.CARDDEMO.CBL''
# Change the local directory to your COBOL source files
lcd /path/to/your/aws-mainframe-modernization-carddemo/app/cbl
# Use mput to transfer all .cbl files
mput *.cbl
    ```

*   **Transfer Copybooks (`app/cpy`):**
    ```ftp
# Change the remote directory to the target PDS
cd '//'HERC01.CARDDEMO.CPY''
# Change the local directory to your Copybook source files
lcd /path/to/your/aws-mainframe-modernization-carddemo/app/cpy
# Use mput to transfer all .cpy files
mput *.cpy
    ```

*   **Transfer JCL (`app/jcl`):**
    ```ftp
# Change the remote directory to the target PDS
cd '//'HERC01.CARDDEMO.JCL''
# Change the local directory to your JCL source files
lcd /path/to/your/aws-mainframe-modernization-carddemo/app/jcl
# Use mput to transfer all .jcl files
mput *.jcl
    ```

*   **Exit FTP:**
    ```ftp
bye
    ```

This process will transfer all your source files into their respective PDSs on the mainframe. You can then proceed with compiling and defining your CICS resources using JCL.