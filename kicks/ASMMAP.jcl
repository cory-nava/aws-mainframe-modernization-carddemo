//ASMMAP   JOB (ACCT),'COMPILE BMS MAPS',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  COMPILE BMS MAPSETS FOR CARDDEMO USING KICKS
//*  This job compiles all CardDemo BMS maps for use with KICKS
//*  Run this after KICKS is installed
//*********************************************************************
//*
//* NOTE: KICKS uses the KIKTPBMS procedure for BMS compilation
//* Adjust the DSN references to match your installation
//*
//*********************************************************************
//*  SIGNON SCREEN MAPSET - COSGN00
//*********************************************************************
//COSGN00  EXEC PROC=KIKTPBMS,MAPNAME=COSGN00
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COSGN00),DISP=SHR
//*
//*********************************************************************
//*  MAIN MENU MAPSET - COMEN01
//*********************************************************************
//COMEN01  EXEC PROC=KIKTPBMS,MAPNAME=COMEN01
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COMEN01),DISP=SHR
//*
//*********************************************************************
//*  ADMIN MENU MAPSET - COADM01
//*********************************************************************
//COADM01  EXEC PROC=KIKTPBMS,MAPNAME=COADM01
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COADM01),DISP=SHR
//*
//*********************************************************************
//*  ACCOUNT VIEW MAPSET - COACTVW
//*********************************************************************
//COACTVW  EXEC PROC=KIKTPBMS,MAPNAME=COACTVW
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COACTVW),DISP=SHR
//*
//*********************************************************************
//*  ACCOUNT UPDATE MAPSET - COACTUP
//*********************************************************************
//COACTUP  EXEC PROC=KIKTPBMS,MAPNAME=COACTUP
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COACTUP),DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD LIST MAPSET - COCRDLI
//*********************************************************************
//COCRDLI  EXEC PROC=KIKTPBMS,MAPNAME=COCRDLI
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COCRDLI),DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD VIEW/SELECT MAPSET - COCRDSL
//*********************************************************************
//COCRDSL  EXEC PROC=KIKTPBMS,MAPNAME=COCRDSL
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COCRDSL),DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD UPDATE MAPSET - COCRDUP
//*********************************************************************
//COCRDUP  EXEC PROC=KIKTPBMS,MAPNAME=COCRDUP
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COCRDUP),DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION LIST MAPSET - COTRN00
//*********************************************************************
//COTRN00  EXEC PROC=KIKTPBMS,MAPNAME=COTRN00
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COTRN00),DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION VIEW MAPSET - COTRN01
//*********************************************************************
//COTRN01  EXEC PROC=KIKTPBMS,MAPNAME=COTRN01
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COTRN01),DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION ADD MAPSET - COTRN02
//*********************************************************************
//COTRN02  EXEC PROC=KIKTPBMS,MAPNAME=COTRN02
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COTRN02),DISP=SHR
//*
//*********************************************************************
//*  REPORTS MAPSET - CORPT00
//*********************************************************************
//CORPT00  EXEC PROC=KIKTPBMS,MAPNAME=CORPT00
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(CORPT00),DISP=SHR
//*
//*********************************************************************
//*  BILL PAYMENT MAPSET - COBIL00
//*********************************************************************
//COBIL00  EXEC PROC=KIKTPBMS,MAPNAME=COBIL00
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COBIL00),DISP=SHR
//*
//*********************************************************************
//*  USER LIST MAPSET - COUSR00
//*********************************************************************
//COUSR00  EXEC PROC=KIKTPBMS,MAPNAME=COUSR00
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COUSR00),DISP=SHR
//*
//*********************************************************************
//*  USER ADD MAPSET - COUSR01
//*********************************************************************
//COUSR01  EXEC PROC=KIKTPBMS,MAPNAME=COUSR01
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COUSR01),DISP=SHR
//*
//*********************************************************************
//*  USER UPDATE MAPSET - COUSR02
//*********************************************************************
//COUSR02  EXEC PROC=KIKTPBMS,MAPNAME=COUSR02
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COUSR02),DISP=SHR
//*
//*********************************************************************
//*  USER DELETE MAPSET - COUSR03
//*********************************************************************
//COUSR03  EXEC PROC=KIKTPBMS,MAPNAME=COUSR03
//COPY.SYSUT1 DD DSN=CARDDEMO.BMS(COUSR03),DISP=SHR
//*
