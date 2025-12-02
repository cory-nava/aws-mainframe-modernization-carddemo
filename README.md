## CardDemo -- Mainframe CardDemo Application

- [CardDemo -- Mainframe CardDemo Application](#carddemo----mainframe-card-demo-application)
- [Description](#description)
- [Technologies used](#technologies-used)
- [Installation on the mainframe](#installation-on-the-mainframe)
- [Local Testing with GnuCOBOL (macOS)](#local-testing-with-gnucobol-macos)
- [Application Details](#application-details)
  - [User Functions](#user-functions)
  - [Admin Functions](#admin-functions)
  - [Application Inventory](#application-inventory)
    - [**Online**](#online)
    - [**Batch**](#batch)
  - [Application Screens](#application-screens)
    - [**Signon Screen**](#signon-screen)
    - [**Main Menu**](#main-menu)
    - [**Admin Menu**](#admin-menu)
- [Support](#support)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Project status](#project-status)

<br/>

## Description
CardDemo is a Mainframe application designed and developed to test and showcase AWS and partner technology for mainframe migration and modernization use-cases such as discovery, migration, modernization, performance test, augmentation, service enablement, service extraction, test creation, test harness, etc.

Note that the intent of this application is to provide mainframe coding scenarios to excercise analysis, transformation and migration tooling. So, the coding style is not uniform across the application

<br/>

## Technologies used
1. COBOL
2. CICS
3. VSAM
4. JCL
5. RACF

<br/>

## Installation on the mainframe 

To install this repository on the mainframe please follow the following steps

1. Clone this repository to your local development environment

2. Create datasets on the mainframe  hold the code
   * It is recommended to group them under a High Level Qualifier (HLQ)for all your datasets. 
   * Upload the following application source folders from the main branch of git repository on to your mainframe
      using $INDFILE or your preferred upload tool.
   * If you have used AWS.M2 as your HLQ, you should end up with the below code structure on the mainframe
   
      | HLQ    | Name          | Format | Length |
      | :----- | :------------ | :----- | -----: |
      | AWS.M2 | CARDDEMO.JCL  | FB     |     80 |
      | AWS.M2 | CARDDEMO.PROC | FB     |     80 |
      | AWS.M2 | CARDDEMO.CBL  | FB     |     80 |
      | AWS.M2 | CARDDEMO.CPY  | FB     |     80 |
      | AWS.M2 | CARDDEMO.BMS  | FB     |     80 |
      
3. Use data for testing using either of the below approaches

   ** Use the supplied sample data**
   
      * Upload the sample data provided in the main/-/data/EBCDIC/ folder to the mainframe. Ensure that you use transfer mode binary

         | Dataset name                      | Name                                             | Copybook (Layout) | Format | Length | Name of equivalent ascii file |
         | :---------------------------------| :----------------------------------------------- | :-----            | :----- | -----: | :---------------------------- |
         | AWS.M2.CARDDEMO.USRSEC.PS         | User Security file                               | CSUSR01Y          | FB     |     80 | See DEFUSR01.jcl (inline)     |
         | AWS.M2.CARDDEMO.ACCTDATA.PS       | Account Data                                     | CVACT01Y          | FB     |    300 | acctdata.txt                  |
         | AWS.M2.CARDDEMO.CARDDATA.PS       | Card Data                                        | CVACT02Y          | FB     |    150 | carddata.txt                  |
         | AWS.M2.CARDDEMO.CUSTDATA.PS       | Customer Data                                    | CVCUS01Y          | FB     |    500 | custdata.txt                  |
         | AWS.M2.CARDDEMO.CARDXREF.PS       | Customer Account Card Cross reference            | CVACT03Y          | FB     |     50 | cardxref.txt                  |
         | AWS.M2.CARDDEMO.DALYTRAN.PS.INIT  | Transaction database initialization record       | CVTRA06Y          | FB     |    350 | 1 record (low-values ending with 00000100)|
         | AWS.M2.CARDDEMO.DALYTRAN.PS       | Transaction data which has to go through posting | CVTRA06Y          | FB     |    350 | dailytran.txt                 |
         | AWS.M2.CARDDEMO.TRANSACT.VSAM.KSDS| Transaction data entered online                  | CVTRA05Y          | FB     |    350 | not applicable                |
         | AWS.M2.CARDDEMO.DISCGRP.PS        | Disclosure Groups                                | CVTRA02Y          | FB     |     50 | discgrp.txt                   |
         | AWS.M2.CARDDEMO.TRANCATG.PS       | Transaction Category Types                       | CVTRA04Y          | FB     |     60 | trancatg.txt                  |
         | AWS.M2.CARDDEMO.TRANTYPE.PS       | Transaction Types                                | CVTRA03Y          | FB     |     60 | trantype.txt                  |
         | AWS.M2.CARDDEMO.TCATBALF.PS       | Transaction Category Balance                     | CVTRA01Y          | FB     |     50 | tcatbal.txt                   |

      * Execute the following JCLs in order

         | Jobname  | What it does                                        |
         | :------- | :-------------------------------------------------- |
         | DUSRSECJ | Sets up user security vsam file                     |
         | CLOSEFIL | Closes files opened by CICS                         |
         | ACCTFILE | Loads Account database using sample data            |
         | CARDFILE | Loads Card database with credit card sample data    |
         | CUSTFILE | Creates customer database                           |
         | XREFFILE | Loads Customer Card account cross reference to VSAM |
         | TRANFILE | Copies initial Trasaction file  to VSAM             |
         | DISCGRP  | Copies initial Disclosure Group file  to VSAM       |
         | TCATBALF | Copies initial TCATBALF file  to VSAM               |
         | TRANCATG | Copies initial transaction category file  to VSAM   |
         | TRANTYPE | Copies initial transaction type file                |
         | OPENFIL  | Makes files available to CICS                       |
         | DEFGDGB  | Defines GDG Base                                    |


4. Compile the Programs. 
   
   You should use the compile process followed by your mainframe shopfloor
   
   We have however provided some sample JCLs in the samples folder in git to help you craft the JCL   

5. Create resources in the CARDDEMO group in CICS
   
   You have 2 options
   
   Be sure to edit the HLQs in the below documents as required before you do the definition
   
   * (Preferred) . Use the DFHCSDUP JCL that the resources required by the application

      The resources required are in the CSD file provided in the CSD folder
       
      * Group CARDDEMO
      * Mapsets
      * Transactions
      * Maps
      * Files
      
   * Use the CEDA transaction to execute the commands in the above listing
   
      * Define group 
         ```shell
         DEFINE LIBRARY(COM2DOLL) GROUP(CARDDEMO) DSNAME01(&HLQ..LOADLIB)
         ```
      * Define Mapsets, Maps , Programs and Files
      
         Sample CEDA commands
         
         ```shell
         DEF PROGRAM(COCRDLIC) GROUP(CARDDEMO)
         DEF MAPSET(COCRDLI) GROUP(CARDDEMO)
         DEFINE PROGRAM(COSGN00C) GROUP(CARDDEMO) DA(ANY) TRANSID(CC00) DESCRIPTION(LOGIN)
         DEFINE TRANSACTION(CC00) GROUP(CARDDEMO) PROGRAM(COSGN00C) TASKDATAL(ANY)
         ```

   * Install /Load the online resources to your CICS region

      ```shell
      CEDA INSTALL TRANS(CCLI) GROUP(CARDDEMO)
      CEDA INSTALL FILE(CARDDAT) GROUP(CARDDEMO)
      CECI LOAD PROG(COCRDUP)
      CECI LOAD PROG(COCRDUPC)
      ```

   * Execute a NEWCOPY of mapsets and maps
      ```shell
      CEMT SET PROG(COCRDUP) NEWCOPY
      CEMT SET PROG(COCRDUPC) NEWCOPY  
      ```
6. Enjoy the demo

   * For online functions : Start the CardDemo application using the CC00 transaction
     - Enter userid ADMIN001 and the initially configured password PASSWORD to manage users
     - Enter userid USER0001 and the initially configured password PASSWORD to access back office functions
   * For batch            : See the instructions for running full batch below.

## Local Testing with GnuCOBOL (macOS)

While this application is designed for a mainframe environment, it is possible to run unit tests on a local machine, such as a MacBook Pro with Apple Silicon (M1/M2/M3/M4). This allows for rapid, isolated testing of individual programs without needing access to a mainframe.

This testing approach was inspired by Dave Guarino's blog post, ["A legacy systems moonshot: AI for characterization test generation,"](https://buttondown.email/daveguarino/archive/a-legacy-systems-moonshot-ai-for/) which explores using modern tools to create a safety net for legacy systems.

For a detailed explanation of the testing strategy, see the [TESTING.md](TESTING.md) file.

### Prerequisites

You will need to install the following tools using [Homebrew](https://brew.sh/):

-   **GnuCOBOL:** A free, open-source COBOL compiler.
-   **Java:** Required by some of the build and testing tools.

```sh
brew install gnucobol
brew install java
```

### Running the Tests

Once the prerequisites are installed, you can run the unit tests with the following command:

```sh
make test
```

This will compile the necessary COBOL programs and run the test suite. You should see output indicating that the test cases have passed.

## Docker Environment Setup

This project includes a Dockerfile that sets up a Linux environment with GnuCOBOL, Hercules (for mainframe emulation), and the TK4- MVS distribution. This allows you to run the mainframe application in a containerized environment.

### Building the Docker Image

To build the Docker image, navigate to the root of this project and run:

```bash
docker build -t carddemo .
```

This command will build the image and tag it as `carddemo`. This process may take some time as it downloads and configures the mainframe emulation environment.

### Running the Mainframe Emulator

Once the Docker image is built, you can run the mainframe emulator. This will start the Hercules emulator and boot the MVS operating system.

Open your terminal and run:

```bash
docker run -it --rm -w /opt/tk4-mvs carddemo ./mvs
```

This command will:
*   `docker run`: Start a new container.
*   `-it`: Open an interactive terminal session.
*   `--rm`: Automatically remove the container when you exit.
*   `-w /opt/tk4-mvs`: Set the working directory inside the container to the TK4- MVS installation directory.
*   `carddemo`: Use the Docker image you just built.
*   `./mvs`: Execute the MVS startup script.

This terminal will become the mainframe's system console. You will see a lot of output as MVS boots up.

### Connecting a 3270 Terminal

While the mainframe is booting in the first terminal, you need to connect a 3270 terminal to interact with it.

1.  **Open a NEW, separate terminal window** on your local machine.
2.  **Find the Container ID:** In this new terminal, run `docker ps` to get the `CONTAINER ID` of your running `carddemo` container.
    ```bash
    docker ps
    ```
3.  **Connect the 3270 Terminal:** Use the `docker exec` command with the `CONTAINER ID` you found to launch `c3270` and connect to the mainframe.
    ```bash
    docker exec -it <CONTAINER_ID> c3270 localhost:3270
    ```
    Replace `<CONTAINER_ID>` with the actual ID.

This will open a 3270 terminal window, and after MVS has finished booting, you should see the MVS logon screen.

### Stopping the Mainframe Container

To stop the running mainframe container, you can either:

*   **Press `Ctrl+C`** in the terminal where you ran the `docker run` command (the mainframe console).
*   **Use `docker stop`:** In a separate terminal, find the `CONTAINER ID` using `docker ps` and then run `docker stop <CONTAINER_ID>`.

## Running full batch 
   
  * Execute the following JCLs in order

    | Jobname  | What it does                                        |
    | :------- | :-------------------------------------------------- |
    | CLOSEFIL | Closes files opened by CICS                         |
    | ACCTFILE | Loads Account database using sample data            |
    | CARDFILE | Loads Card database with credit card sample data    |
    | XREFFILE | Loads Customer Card account cross reference to VSAM |
    | CUSTFILE | Creates customer database                           |
    | TRANBKP  | Creates Transaction database                        |
    | DISCGRP  | Copies initial disclosure Group file  to VSAM       |
    | TCATBALF | Copies initial TCATBALF file  to VSAM               |
    | TRANTYPE | Copies initial transaction type file                |
    | DUSRSECJ | Sets up user security vsam file                     |
    | POSTTRAN | Core processing job                                 |
    | INTCALC  | Run interest calculations                           |
    | TRANBKP  | Backup Transaction database                         |
    | COMBTRAN | Combine system transactions with daily ones         |
    | CREASTMT | Produce transaction statement                       | 	
    | TRANIDX  | Define alternate index on transaction file          |
    | OPENFIL  | Makes files available to CICS                       |
<br/>

## Application Details 
The CardDemo is a Credit Card management application, built primarily using COBOL programming language. The application has various functions that allows users to manage Account, Credit card, Transaction and Bill payment. 

There are 2 types of users:
* Regular User
* Admin User

The Regular user can perform the user functions and the Admin users can only perform Admin functions.

<br/>

### User Functions

![Alt text](./diagrams/Application-Flow-User.png?raw=true "User Flow")

<br/>

### Admin Functions

![Alt text](./diagrams/Application-Flow-Admin.png?raw=true "Admin Flow")

<br/>

### Application Inventory

#### **Online**

| Transaction |      | BMS Map | Program  | Function            |
| :---------- | :--- | :------ | :------- | :------------------ |
| CC00        |      | COSGN00 | COSGN00C | Signon Screen       |
| CM00        |      | COMEN01 | COMEN01C | Main Menu           |
|             | CAVW | COACTVW | COACTVWC | Account View        |
|             | CAUP | COACTUP | COACTUPC | Account Update      |
|             | CCLI | COCRDLI | COCRDLIC | Credit Card List    |
|             | CCDL | COCRDSL | COCRDSLC | Credit Card View    |
|             | CCUP | COCRDUP | COCRDUPC | Credit Card Update  |
|             | CT00 | COTRN00 | COTRN00C | Transaction List    |
|             | CT01 | COTRN01 | COTRN01C | Transaction View    |
|             | CT02 | COTRN02 | COTRN02C | Transaction Add     |
|             | CR00 | CORPT00 | CORPT00C | Transaction Reports |
|             | CB00 | COBIL00 | COBIL00C | Bill Payment        |
| CA00        |      | COADM01 | COADM01C | Admin Menu          |
|             | CU00 | COUSR00 | COUSR00C | List Users          |
|             | CU01 | COUSR01 | COUSR01C | Add User            |
|             | CU02 | COUSR02 | COUSR02C | Update User         |
|             | CU03 | COUSR03 | COUSR03C | Delete User         |

#### **Batch**

| Job      | Program  | Function                                   |
| :------- | :------- | :----------------------------------------- |
| DUSRSECJ | IEBGENER | Initial Load of User security file         |
| DEFGDGB  | IDCAMS   | Setup GDG Bases                            | 
| ACCTFILE | IDCAMS   | Refresh Account Master                     |
| CARDFILE | IDCAMS   | Refresh Card Master                        |
| CUSTFILE | IDCAMS   | Refresh Customer Master                    |
| DISCGRP  | IDCAMS   | Load Disclosure Group File                 |
| TRANFILE | IDCAMS   | Load Transaction Master file               |
| TRANCATG | IDCAMS   | Load Transaction category types            |
| TRANTYPE | IDCAMS   | Load Transaction type file                 |
| XREFFILE | IDCAMS   | Account, Card and Customer cross reference |
| CLOSEFIL | IEFBR14  | Close VSAM files in CICS                   |
| TCATBALF | IDCAMS   | Refresh Transaction Category Balance       |
| TRANBKP  | IDCAMS   | Refresh Transaction Master                 |
| POSTTRAN | CBTRN02C | Transaction processing job                 |
| TRANIDX  | IDCAMS   | Define AIX for transaction file            |
| OPENFIL  | IEFBR14  | Open files in CICS                         |
| INTCALC  | CBACT04C | Run interest calculations                  |
| COMBTRAN | SORT     | Combine transaction files                  |
| CREASTMT | CBSTM03A | Produce transaction statement              |

<br/>

### Application Screens

#### **Signon Screen**

![Alt text](./diagrams/Signon-Screen.png?raw=true "Signon Screen")


#### **Main Menu**

![Alt text](./diagrams/Main-Menu.png?raw=true "Main Menu")

#### **Admin Menu**

![Alt text](./diagrams/Admin-Menu.png?raw=true "Admin Menu")

<br/>

## Support

If you have questions or requests for improvement please raise an issue in the repository.

<br/>

## Roadmap

The following features are planned for upcoming releases

1. More database types

   1. Relational Database usage : Db2 
   
   2. Hierachical database calls : IMS

2. Integration

   * ftp, sftp
   
   * Message queue integration
   
   * Exposure of transactions for distributed application integration

<br/>

## Contributing

We are looking forward to receiving contributions and enhancements to this initial codebase from the mainframe code base

Feel free to raise issues, create code and raise merge requests for enhancements so that we can build out this application as a resource for programmers wanting to understand and modernize their mainframes.

<br/>

## License

This is intended to be a community resource and it is released under the Apache 2.0 license.

<br/>

## Project status

We are planning a v2 of this application in Q1 2023.

Watch this space for updates

<br/>