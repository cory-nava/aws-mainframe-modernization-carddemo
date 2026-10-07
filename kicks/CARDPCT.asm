***********************************************************************
*    KICKS PROGRAM CONTROL TABLE (PCT) FOR CARDDEMO APPLICATION
*
*    This defines all transactions and their associated programs
*    Adapted from CICS CSD definitions
***********************************************************************
         PRINT NOGEN
*
CARDPCT  CSECT
*
***********************************************************************
*    SIGNON TRANSACTION - CC00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CC00,                                             X
               PROGRAM=COSGN00C,                                       X
               TWASIZE=0
*
***********************************************************************
*    MAIN MENU TRANSACTION - CM00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CM00,                                             X
               PROGRAM=COMEN01C,                                       X
               TWASIZE=0
*
***********************************************************************
*    ADMIN MENU TRANSACTION - CA00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CA00,                                             X
               PROGRAM=COADM01C,                                       X
               TWASIZE=0
*
***********************************************************************
*    ACCOUNT VIEW TRANSACTION - CAVW
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CAVW,                                             X
               PROGRAM=COACTVWC,                                       X
               TWASIZE=0
*
***********************************************************************
*    ACCOUNT UPDATE TRANSACTION - CAUP
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CAUP,                                             X
               PROGRAM=COACTUPC,                                       X
               TWASIZE=0
*
***********************************************************************
*    CREDIT CARD LIST TRANSACTION - CCLI
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CCLI,                                             X
               PROGRAM=COCRDLIC,                                       X
               TWASIZE=0
*
***********************************************************************
*    CREDIT CARD VIEW/SELECT TRANSACTION - CCDL
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CCDL,                                             X
               PROGRAM=COCRDSLC,                                       X
               TWASIZE=0
*
***********************************************************************
*    CREDIT CARD UPDATE TRANSACTION - CCUP
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CCUP,                                             X
               PROGRAM=COCRDUPC,                                       X
               TWASIZE=0
*
***********************************************************************
*    TRANSACTION LIST TRANSACTION - CT00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CT00,                                             X
               PROGRAM=COTRN00C,                                       X
               TWASIZE=0
*
***********************************************************************
*    TRANSACTION VIEW TRANSACTION - CT01
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CT01,                                             X
               PROGRAM=COTRN01C,                                       X
               TWASIZE=0
*
***********************************************************************
*    TRANSACTION ADD TRANSACTION - CT02
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CT02,                                             X
               PROGRAM=COTRN02C,                                       X
               TWASIZE=0
*
***********************************************************************
*    REPORTS TRANSACTION - CR00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CR00,                                             X
               PROGRAM=CORPT00C,                                       X
               TWASIZE=0
*
***********************************************************************
*    BILL PAYMENT TRANSACTION - CB00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CB00,                                             X
               PROGRAM=COBIL00C,                                       X
               TWASIZE=0
*
***********************************************************************
*    USER LIST TRANSACTION - CU00
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CU00,                                             X
               PROGRAM=COUSR00C,                                       X
               TWASIZE=0
*
***********************************************************************
*    USER ADD TRANSACTION - CU01
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CU01,                                             X
               PROGRAM=COUSR01C,                                       X
               TWASIZE=0
*
***********************************************************************
*    USER UPDATE TRANSACTION - CU02
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CU02,                                             X
               PROGRAM=COUSR02C,                                       X
               TWASIZE=0
*
***********************************************************************
*    USER DELETE TRANSACTION - CU03
***********************************************************************
         KITEPCT TYPE=ENTRY,                                           X
               TRANS=CU03,                                             X
               PROGRAM=COUSR03C,                                       X
               TWASIZE=0
*
***********************************************************************
*    END OF PCT
***********************************************************************
         KITEPCT TYPE=FINAL
*
         END
