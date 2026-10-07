//COMPCOB  JOB (ACCT),'COMPILE COBOL',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  COMPILE CARDDEMO COBOL PROGRAMS FOR KICKS
//*  This job compiles all CardDemo COBOL programs with KICKS translator
//*  Run this after KICKS is installed and BMS maps are compiled
//*********************************************************************
//*
//* NOTE: KICKS uses KIKTPCOB procedure for COBOL compilation
//* This translates EXEC CICS commands to KICKS equivalents
//*
//*********************************************************************
//*  SIGNON PROGRAM - COSGN00C
//*********************************************************************
//COSGN00C EXEC PROC=KIKTPCOB,MEMBER=COSGN00C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COSGN00C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  MAIN MENU PROGRAM - COMEN01C
//*********************************************************************
//COMEN01C EXEC PROC=KIKTPCOB,MEMBER=COMEN01C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COMEN01C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  ADMIN MENU PROGRAM - COADM01C
//*********************************************************************
//COADM01C EXEC PROC=KIKTPCOB,MEMBER=COADM01C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COADM01C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  ACCOUNT VIEW PROGRAM - COACTVWC
//*********************************************************************
//COACTVWC EXEC PROC=KIKTPCOB,MEMBER=COACTVWC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COACTVWC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  ACCOUNT UPDATE PROGRAM - COACTUPC
//*********************************************************************
//COACTUPC EXEC PROC=KIKTPCOB,MEMBER=COACTUPC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COACTUPC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD LIST PROGRAM - COCRDLIC
//*********************************************************************
//COCRDLIC EXEC PROC=KIKTPCOB,MEMBER=COCRDLIC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COCRDLIC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD SEARCH PROGRAM - COCRDSEC
//*********************************************************************
//COCRDSEC EXEC PROC=KIKTPCOB,MEMBER=COCRDSEC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COCRDSEC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD VIEW/SELECT PROGRAM - COCRDSLC
//*********************************************************************
//COCRDSLC EXEC PROC=KIKTPCOB,MEMBER=COCRDSLC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COCRDSLC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  CREDIT CARD UPDATE PROGRAM - COCRDUPC
//*********************************************************************
//COCRDUPC EXEC PROC=KIKTPCOB,MEMBER=COCRDUPC
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COCRDUPC),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION LIST PROGRAM - COTRN00C
//*********************************************************************
//COTRN00C EXEC PROC=KIKTPCOB,MEMBER=COTRN00C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COTRN00C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION VIEW PROGRAM - COTRN01C
//*********************************************************************
//COTRN01C EXEC PROC=KIKTPCOB,MEMBER=COTRN01C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COTRN01C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  TRANSACTION ADD PROGRAM - COTRN02C
//*********************************************************************
//COTRN02C EXEC PROC=KIKTPCOB,MEMBER=COTRN02C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COTRN02C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  REPORTS PROGRAM - CORPT00C
//*********************************************************************
//CORPT00C EXEC PROC=KIKTPCOB,MEMBER=CORPT00C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(CORPT00C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  BILL PAYMENT PROGRAM - COBIL00C
//*********************************************************************
//COBIL00C EXEC PROC=KIKTPCOB,MEMBER=COBIL00C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COBIL00C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  USER LIST PROGRAM - COUSR00C
//*********************************************************************
//COUSR00C EXEC PROC=KIKTPCOB,MEMBER=COUSR00C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COUSR00C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  USER ADD PROGRAM - COUSR01C
//*********************************************************************
//COUSR01C EXEC PROC=KIKTPCOB,MEMBER=COUSR01C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COUSR01C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  USER UPDATE PROGRAM - COUSR02C
//*********************************************************************
//COUSR02C EXEC PROC=KIKTPCOB,MEMBER=COUSR02C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COUSR02C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
//*********************************************************************
//*  USER DELETE PROGRAM - COUSR03C
//*********************************************************************
//COUSR03C EXEC PROC=KIKTPCOB,MEMBER=COUSR03C
//COB.SYSIN  DD DSN=CARDDEMO.COBOL(COUSR03C),DISP=SHR
//COB.SYSLIB DD DSN=CARDDEMO.COPY,DISP=SHR
//           DD DSN=KICKS.KICKSSYS.V1R5M0.COBCOPY,DISP=SHR
//*
