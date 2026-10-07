***********************************************************************
*    KICKS FILE CONTROL TABLE (FCT) FOR CARDDEMO APPLICATION
*
*    This defines all VSAM files used by CardDemo for KICKS
*    Adapted from CICS CSD definitions
***********************************************************************
         PRINT NOGEN
*
CARDFCT  CSECT
*
***********************************************************************
*    ACCOUNT DATA FILE - ACCTDAT
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=ACCTDAT,                                           X
               DSNAME=CARDDEMO.ACCTDATA.VSAM.KSDS,                     X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=11,                                              X
               LRECL=300
*
***********************************************************************
*    CARD DATA FILE - CARDDAT
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=CARDDAT,                                           X
               DSNAME=CARDDEMO.CARDDATA.VSAM.KSDS,                     X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=16,                                              X
               LRECL=150
*
***********************************************************************
*    CUSTOMER DATA FILE - CUSTDAT
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=CUSTDAT,                                           X
               DSNAME=CARDDEMO.CUSTDATA.VSAM.KSDS,                     X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=9,                                               X
               LRECL=500
*
***********************************************************************
*    CARD CROSS REFERENCE FILE - CCXREF
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=CCXREF,                                            X
               DSNAME=CARDDEMO.CARDXREF.VSAM.KSDS,                     X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=16,                                              X
               LRECL=50
*
***********************************************************************
*    TRANSACTION FILE - TRANSACT
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=TRANSACT,                                          X
               DSNAME=CARDDEMO.TRANSACT.VSAM.KSDS,                     X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=16,                                              X
               LRECL=350
*
***********************************************************************
*    USER SECURITY FILE - USRSEC
***********************************************************************
         KITEFCT TYPE=FILE,                                            X
               FILE=USRSEC,                                            X
               DSNAME=CARDDEMO.USRSEC.VSAM.KSDS,                       X
               SERVREQ=(READ,BROWSE,UPDATE,DELETE,ADD),                X
               ACCMETH=VSAM,                                           X
               FILSTAT=ENABLED,                                        X
               RECFORM=VARIABLE,                                       X
               KEYLEN=8,                                               X
               LRECL=80
*
***********************************************************************
*    END OF FCT
***********************************************************************
         KITEFCT TYPE=FINAL
*
         END
