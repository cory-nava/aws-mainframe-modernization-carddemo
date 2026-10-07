//ASMPPT   JOB (ACCT),'ASSEMBLE PPT',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  ASSEMBLE KICKS PROCESSING PROGRAM TABLE FOR CARDDEMO
//*  Run this after KICKS is installed
//*********************************************************************
//ASM      EXEC PROC=KIKTPASM,MEMBER=CARDPPT
//SYSIN    DD  DSN=CARDDEMO.KICKS.SOURCE(CARDPPT),DISP=SHR
//*
