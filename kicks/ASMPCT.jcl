//ASMPCT   JOB (ACCT),'ASSEMBLE PCT',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  ASSEMBLE KICKS PROGRAM CONTROL TABLE FOR CARDDEMO
//*  Run this after KICKS is installed
//*********************************************************************
//ASM      EXEC PROC=KIKTPASM,MEMBER=CARDPCT
//SYSIN    DD  DSN=CARDDEMO.KICKS.SOURCE(CARDPCT),DISP=SHR
//*
