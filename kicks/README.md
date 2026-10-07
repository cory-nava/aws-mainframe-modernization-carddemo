# CardDemo KICKS Configuration

This directory contains all the configuration files and JCL needed to run CardDemo on KICKS (a CICS-compatible transaction processor for MVS 3.8j/TK4-).

## Overview

KICKS provides source-level compatibility with CICS, allowing CardDemo's COBOL programs to run on MVS 3.8j with minimal modifications.

## Files in This Directory

### Configuration Tables (Assembler Source)

| File | Description |
|------|-------------|
| `CARDFCT.asm` | File Control Table - defines all VSAM files |
| `CARDPCT.asm` | Program Control Table - maps transactions to programs |
| `CARDPPT.asm` | Processing Program Table - defines programs and mapsets |

### JCL Jobs

| File | Description | Run Order |
|------|-------------|-----------|
| `DEFVSAM.jcl` | Create VSAM file definitions | 1 |
| `LOADUSR.jcl` | Load initial user security data | 2 |
| `ASMFCT.jcl` | Assemble File Control Table | 3 |
| `ASMPCT.jcl` | Assemble Program Control Table | 4 |
| `ASMPPT.jcl` | Assemble Processing Program Table | 5 |
| `ASMMAP.jcl` | Compile all BMS mapsets | 6 |
| `COMPCOB.jcl` | Compile all COBOL programs | 7 |

## Installation Steps

### Prerequisites

1. TK4- MVS 3.8j running in Docker (or native Hercules)
2. KICKS installed on MVS (see main README for installation guide)
3. FTP or IND$FILE access to upload files to MVS

### Step 1: Upload CardDemo Source to MVS

Upload the following directories to MVS datasets:

```
app/cbl/*.cbl    -> CARDDEMO.COBOL
app/cpy/*.cpy    -> CARDDEMO.COPY
app/bms/*.bms    -> CARDDEMO.BMS
kicks/*.asm      -> CARDDEMO.KICKS.SOURCE
kicks/*.jcl      -> CARDDEMO.KICKS.JCL
```

### Step 2: Define VSAM Files

```
SUBMIT 'CARDDEMO.KICKS.JCL(DEFVSAM)'
```

**Important:** Edit `DEFVSAM.jcl` first to change `VOLUMES(PUB001)` to match your available DASD volume.

### Step 3: Load Initial Data

```
SUBMIT 'CARDDEMO.KICKS.JCL(LOADUSR)'
```

This creates two users:
- `ADMIN001` / `PASSWORD` - Administrator access
- `USER0001` / `PASSWORD` - Regular user access

### Step 4: Assemble KICKS Tables

```
SUBMIT 'CARDDEMO.KICKS.JCL(ASMFCT)'
SUBMIT 'CARDDEMO.KICKS.JCL(ASMPCT)'
SUBMIT 'CARDDEMO.KICKS.JCL(ASMPPT)'
```

### Step 5: Compile BMS Maps

```
SUBMIT 'CARDDEMO.KICKS.JCL(ASMMAP)'
```

### Step 6: Compile COBOL Programs

```
SUBMIT 'CARDDEMO.KICKS.JCL(COMPCOB)'
```

### Step 7: Start KICKS and Test

1. Start KICKS from TSO:
   ```
   EXEC 'KICKS.KICKSSYS.V1R5M0.CLIST(KICKS)'
   ```

2. At the KICKS prompt, enter transaction `CC00` to display the CardDemo signon screen.

3. Log in with:
   - User ID: `ADMIN001` or `USER0001`
   - Password: `PASSWORD`

## Transactions

| Transaction | Description | Program |
|-------------|-------------|---------|
| CC00 | Signon Screen | COSGN00C |
| CM00 | Main Menu | COMEN01C |
| CA00 | Admin Menu | COADM01C |
| CAVW | Account View | COACTVWC |
| CAUP | Account Update | COACTUPC |
| CCLI | Credit Card List | COCRDLIC |
| CCDL | Credit Card View | COCRDSLC |
| CCUP | Credit Card Update | COCRDUPC |
| CT00 | Transaction List | COTRN00C |
| CT01 | Transaction View | COTRN01C |
| CT02 | Transaction Add | COTRN02C |
| CR00 | Reports | CORPT00C |
| CB00 | Bill Payment | COBIL00C |
| CU00 | User List | COUSR00C |
| CU01 | User Add | COUSR01C |
| CU02 | User Update | COUSR02C |
| CU03 | User Delete | COUSR03C |

## VSAM Files

| File ID | Dataset Name | Description | Key Length | Record Size |
|---------|--------------|-------------|------------|-------------|
| USRSEC | CARDDEMO.USRSEC.VSAM.KSDS | User Security | 8 | 80 |
| ACCTDAT | CARDDEMO.ACCTDATA.VSAM.KSDS | Account Data | 11 | 300 |
| CARDDAT | CARDDEMO.CARDDATA.VSAM.KSDS | Card Data | 16 | 150 |
| CUSTDAT | CARDDEMO.CUSTDATA.VSAM.KSDS | Customer Data | 9 | 500 |
| CCXREF | CARDDEMO.CARDXREF.VSAM.KSDS | Card Cross Reference | 16 | 50 |
| TRANSACT | CARDDEMO.TRANSACT.VSAM.KSDS | Transactions | 16 | 350 |

## Troubleshooting

### Common Issues

1. **VSAM file not found**: Ensure DEFVSAM job completed successfully and volume name is correct.

2. **Program not found**: Check that COBOL compilation completed and load modules are in the correct library.

3. **Map not found**: Verify BMS compilation completed and mapsets are defined in PPT.

4. **Transaction not defined**: Check that PCT assembly completed successfully.

### Debugging

KICKS provides the KEDF (KICKS Execution Diagnostic Facility) for debugging:
- Enter `KEDF` at the transaction prompt to enable tracing
- Use `DFXX` to display transaction dumps

## Known Limitations

1. **CICS vs KICKS differences**: Some advanced CICS features may not be supported in KICKS.

2. **Color support**: Requires TK4- with updated terminal driver (included in recent versions).

3. **Performance**: KICKS runs in TSO address space, so performance differs from production CICS.

## References

- [KICKS Official Site](https://www.kicksfortso.com/)
- [KICKS GitHub Repository](https://github.com/moshix/kicks)
- [Jay Moseley's KICKS Guide](https://www.jaymoseley.com/hercules/kicks/index.htm)
