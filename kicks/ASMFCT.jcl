//ASMFCT   JOB (ACCT),'ASSEMBLE FCT',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  ASSEMBLE KICKS FILE CONTROL TABLE FOR CARDDEMO
//*  Run this after KICKS is installed
//*********************************************************************
//ASM      EXEC PROC=KIKTPASM,MEMBER=CARDFCT
//SYSIN    DD  DSN=CARDDEMO.KICKS.SOURCE(CARDFCT),DISP=SHR
//*
