IDENTIFICATION DIVISION.
       PROGRAM-ID. CEEDAYS.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01  INPUT-DATE.
           02  Vstring-length      PIC S9(4) BINARY.
           02  Vstring-text        PIC X(256).
       01  DATE-FORMAT.
           02  Vstring-length      PIC S9(4) BINARY.
           02  Vstring-text        PIC X(256).
       01  OUTPUT-LILLIAN          PIC S9(9) BINARY.
       01  FEEDBACK-CODE.
           02 FEEDBACK-TOKEN-VALUE PIC X(8).
           02 I-S-INFO             PIC S9(9) BINARY.

       PROCEDURE DIVISION USING INPUT-DATE, DATE-FORMAT, OUTPUT-LILLIAN, FEEDBACK-CODE.
           EVALUATE Vstring-text OF INPUT-DATE(1:Vstring-length OF INPUT-DATE)
               WHEN "2024-03-25"
               WHEN "03-25-2024"
                   MOVE X'0000000000000000' TO FEEDBACK-TOKEN-VALUE
               WHEN "INVALID"
                   MOVE X'000309D859C3C5C5' TO FEEDBACK-TOKEN-VALUE
               WHEN OTHER
                   MOVE X'000309CC59C3C5C5' TO FEEDBACK-TOKEN-VALUE
           END-EVALUATE
           GOBACK.