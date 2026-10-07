***********************************************************************
*    KICKS PROCESSING PROGRAM TABLE (PPT) FOR CARDDEMO APPLICATION
*
*    This defines all programs and mapsets used by CardDemo
*    Adapted from CICS CSD definitions
***********************************************************************
         PRINT NOGEN
*
CARDPPT  CSECT
*
***********************************************************************
*    ONLINE COBOL PROGRAMS
***********************************************************************
*
*    SIGNON PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COSGN00C,                                       X
               LANG=COBOL
*
*    MAIN MENU PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COMEN01C,                                       X
               LANG=COBOL
*
*    ADMIN MENU PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COADM01C,                                       X
               LANG=COBOL
*
*    ACCOUNT VIEW PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COACTVWC,                                       X
               LANG=COBOL
*
*    ACCOUNT UPDATE PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COACTUPC,                                       X
               LANG=COBOL
*
*    CREDIT CARD LIST PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDLIC,                                       X
               LANG=COBOL
*
*    CREDIT CARD SEARCH PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDSEC,                                       X
               LANG=COBOL
*
*    CREDIT CARD VIEW/SELECT PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDSLC,                                       X
               LANG=COBOL
*
*    CREDIT CARD UPDATE PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDUPC,                                       X
               LANG=COBOL
*
*    TRANSACTION LIST PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN00C,                                       X
               LANG=COBOL
*
*    TRANSACTION VIEW PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN01C,                                       X
               LANG=COBOL
*
*    TRANSACTION ADD PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN02C,                                       X
               LANG=COBOL
*
*    REPORTS PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=CORPT00C,                                       X
               LANG=COBOL
*
*    BILL PAYMENT PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COBIL00C,                                       X
               LANG=COBOL
*
*    USER LIST PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR00C,                                       X
               LANG=COBOL
*
*    USER ADD PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR01C,                                       X
               LANG=COBOL
*
*    USER UPDATE PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR02C,                                       X
               LANG=COBOL
*
*    USER DELETE PROGRAM
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR03C,                                       X
               LANG=COBOL
*
***********************************************************************
*    BMS MAPSETS
***********************************************************************
*
*    SIGNON MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COSGN00,                                        X
               MAPSET=YES
*
*    MAIN MENU MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COMEN01,                                        X
               MAPSET=YES
*
*    ADMIN MENU MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COADM01,                                        X
               MAPSET=YES
*
*    ACCOUNT VIEW MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COACTVW,                                        X
               MAPSET=YES
*
*    ACCOUNT UPDATE MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COACTUP,                                        X
               MAPSET=YES
*
*    CREDIT CARD LIST MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDLI,                                        X
               MAPSET=YES
*
*    CREDIT CARD VIEW/SELECT MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDSL,                                        X
               MAPSET=YES
*
*    CREDIT CARD UPDATE MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COCRDUP,                                        X
               MAPSET=YES
*
*    TRANSACTION LIST MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN00,                                        X
               MAPSET=YES
*
*    TRANSACTION VIEW MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN01,                                        X
               MAPSET=YES
*
*    TRANSACTION ADD MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COTRN02,                                        X
               MAPSET=YES
*
*    REPORTS MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=CORPT00,                                        X
               MAPSET=YES
*
*    BILL PAYMENT MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COBIL00,                                        X
               MAPSET=YES
*
*    USER LIST MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR00,                                        X
               MAPSET=YES
*
*    USER ADD MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR01,                                        X
               MAPSET=YES
*
*    USER UPDATE MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR02,                                        X
               MAPSET=YES
*
*    USER DELETE MAPSET
         KITEPPT TYPE=ENTRY,                                           X
               PROGRAM=COUSR03,                                        X
               MAPSET=YES
*
***********************************************************************
*    END OF PPT
***********************************************************************
         KITEPPT TYPE=FINAL
*
         END
