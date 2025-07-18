# Common Mainframe Commands (TK4- MVS)

This document provides a quick reference for common commands and interactions within the TK4- MVS mainframe emulation environment.

## TSO (Time Sharing Option) Commands

After logging in to TSO, you will typically be at a `READY` prompt. You can enter commands directly.

*   **Logon:**
    *   **User ID:** `HERC01`
    *   **Password:** `CUL8TR`

*   **Start KICKS (CICS-like environment):**
    ```
    KICKS
    ```
    This will take you to the KICKS main menu.

*   **Exit KICKS / Return to TSO:**
    *   From within a KICKS screen, try pressing **PF3** (Escape then `3` in `c3270`).
    *   If on a diagnostic screen (like the VDU test screen), try typing `Z` or `END` and pressing **Enter**.

*   **List Datasets (similar to `ls`):**
    ```
    LISTCAT ENT('HERC01')
    ```
    (Replace `HERC01` with your TSO User ID or the HLQ you want to list)

*   **Edit a Dataset (using ISPF/PDF):**
    ```
    ISPFP
    ```
    Then navigate through the ISPF menus (option 2 for Edit, then enter dataset name).

*   **Submit a Job (JCL):**
    ```
    SUBMIT 'HERC01.JCL(JOBNAME)'
    ```
    (Replace `HERC01` with your TSO User ID and `JOBNAME` with the member name of your JCL).

*   **Check Job Status:**
    ```
    SDSF
    ```
    Then navigate to the `ST` (Status) panel.

*   **Allocate a New Dataset:**
    ```
    ALLOCATE
    ```
    This will bring up a menu to define a new dataset.

*   **Delete a Dataset:**
    ```
    DELETE 'HERC01.DATASET.NAME'
    ```

*   **Copy a Dataset:**
    ```
    COPY
    ```
    This will bring up a menu to copy datasets.

*   **Display System Information:**
    ```
    D T
    ```
    (Display Time)

    ```
    D A,L
    ```
    (Display Active tasks, Long format)

## Hercules Console Commands

These commands are entered in the terminal where you ran `docker run -it --rm -w / carddemo ./mvs` (the mainframe console).

*   **Start FTP Daemon:**
    ```
    /start ftpd,srvport=21
    ```

*   **Display Device Status:**
    ```
    d u
    ```

*   **Display CPU Status:**
    ```
    d c
    ```

*   **Quiesce (prepare for shutdown):**
    ```
    q
    ```

*   **Shutdown MVS (from console):**
    ```
    z net,quick
    ```
    (This is a common way to quickly shut down the network and then the system.)

    ```
    s ipl
    ```
    (To re-IPL the system after shutdown)

## c3270 (3270 Terminal Emulator) Key Mappings

When using `c3270` via `docker exec -it <CONTAINER_ID> c3270 localhost:3270`:

*   **Enter:** `Enter` key
*   **Clear:** `Ctrl+L`
*   **PF Keys (PF1-PF12):** `Escape` followed by the number (e.g., `Esc` then `3` for PF3)
*   **PA Keys (PA1-PA3):** `Ctrl+P` then `1`, `2`, or `3`
*   **Attn:** `Ctrl+A`
*   **SysReq:** `Ctrl+S`
*   **Reset:** `Ctrl+R`
*   **Tab:** `Tab` key
*   **Backtab (Shift+Tab):** `Shift+Tab`

This is a basic set of commands to get you started. The TK4- system is very comprehensive, and you can find more detailed documentation within the emulated MVS environment itself or by searching online for MVS 3.8j and TK4- resources.