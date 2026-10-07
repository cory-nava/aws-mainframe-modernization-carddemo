//LOADUSR  JOB (ACCT),'LOAD USER DATA',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*********************************************************************
//*  LOAD USER SECURITY DATA FOR CARDDEMO
//*  This creates initial admin and user accounts
//*  Run this AFTER DEFVSAM job completes
//*********************************************************************
//*
//REPRO    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//INFILE   DD  *
ADMIN001PASSWORDA
USER0001PASSWORDU
/*
//SYSIN    DD  *
  REPRO INFILE(INFILE) -
        OUTDATASET(CARDDEMO.USRSEC.VSAM.KSDS)
/*
//
