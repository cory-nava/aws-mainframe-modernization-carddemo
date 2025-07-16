       IDENTIFICATION DIVISION.
       PROGRAM-ID. TCSUTLD1.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TEST-RESULTS      PIC X(80).
       01 WS-TEST-CASE-NUM     PIC 9(2) VALUE 1.
       01 WS-TEST-CASE-FAILED  PIC 9(1) VALUE 0.

       01 TEST-CASES.
           05 TEST-CASE-1.
              10 TEST-DATE           PIC X(10) VALUE "2024-03-25".
              10 TEST-FORMAT         PIC X(10) VALUE "YYYY-MM-DD".
              10 EXPECTED-RESULT     PIC X(15) VALUE "Date is valid".
           05 TEST-CASE-2.
              10 TEST-DATE           PIC X(10) VALUE "2024-99-99".
              10 TEST-FORMAT         PIC X(10) VALUE "YYYY-MM-DD".
              10 EXPECTED-RESULT     PIC X(15) VALUE "Datevalue error".
           05 TEST-CASE-3.
              10 TEST-DATE           PIC X(10) VALUE "99/99/9999".
              10 TEST-FORMAT         PIC X(10) VALUE "MM/DD/YYYY".
              10 EXPECTED-RESULT     PIC X(15) VALUE "Datevalue error".
           05 TEST-CASE-4.
              10 TEST-DATE           PIC X(10) VALUE "03-25-2024".
              10 TEST-FORMAT         PIC X(10) VALUE "MM-DD-YYYY".
              10 EXPECTED-RESULT     PIC X(15) VALUE "Date is valid".
           05 TEST-CASE-5.
              10 TEST-DATE           PIC X(10) VALUE "INVALID".
              10 TEST-FORMAT         PIC X(10) VALUE "YYYY-MM-DD".
              10 EXPECTED-RESULT     PIC X(15) VALUE "Nonnumeric data".

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM RUN-TESTS
           IF WS-TEST-CASE-FAILED = 1
               MOVE 1 TO RETURN-CODE
           ELSE
               MOVE 0 TO RETURN-CODE
           END-IF
           GOBACK.

       RUN-TESTS.
           PERFORM RUN-TEST-CASE-1.
           PERFORM RUN-TEST-CASE-2.
           PERFORM RUN-TEST-CASE-3.
           PERFORM RUN-TEST-CASE-4.
           PERFORM RUN-TEST-CASE-5.

       RUN-TEST-CASE-1.
           CALL "CSUTLDTC" USING TEST-DATE OF TEST-CASE-1,
                                 TEST-FORMAT OF TEST-CASE-1,
                                 WS-TEST-RESULTS.
           IF WS-TEST-RESULTS(21:15) NOT = EXPECTED-RESULT OF TEST-CASE-1 OF TEST-CASES
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Failed."
               MOVE 1 TO WS-TEST-CASE-FAILED
           ELSE
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Passed."
           END-IF.
           ADD 1 TO WS-TEST-CASE-NUM.

       RUN-TEST-CASE-2.
           CALL "CSUTLDTC" USING TEST-DATE OF TEST-CASE-2,
                                 TEST-FORMAT OF TEST-CASE-2,
                                 WS-TEST-RESULTS.
           IF WS-TEST-RESULTS(21:15) NOT = EXPECTED-RESULT OF TEST-CASE-2 OF TEST-CASES
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Failed."
               MOVE 1 TO WS-TEST-CASE-FAILED
           ELSE
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Passed."
           END-IF.
           ADD 1 TO WS-TEST-CASE-NUM.

       RUN-TEST-CASE-3.
           CALL "CSUTLDTC" USING TEST-DATE OF TEST-CASE-3,
                                 TEST-FORMAT OF TEST-CASE-3,
                                 WS-TEST-RESULTS.
           IF WS-TEST-RESULTS(21:15) NOT = EXPECTED-RESULT OF TEST-CASE-3 OF TEST-CASES
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Failed."
               MOVE 1 TO WS-TEST-CASE-FAILED
           ELSE
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Passed."
           END-IF.
           ADD 1 TO WS-TEST-CASE-NUM.

       RUN-TEST-CASE-4.
           CALL "CSUTLDTC" USING TEST-DATE OF TEST-CASE-4,
                                 TEST-FORMAT OF TEST-CASE-4,
                                 WS-TEST-RESULTS.
           IF WS-TEST-RESULTS(21:15) NOT = EXPECTED-RESULT OF TEST-CASE-4 OF TEST-CASES
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Failed."
               MOVE 1 TO WS-TEST-CASE-FAILED
           ELSE
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Passed."
           END-IF.
           ADD 1 TO WS-TEST-CASE-NUM.

       RUN-TEST-CASE-5.
           CALL "CSUTLDTC" USING TEST-DATE OF TEST-CASE-5,
                                 TEST-FORMAT OF TEST-CASE-5,
                                 WS-TEST-RESULTS.
           IF WS-TEST-RESULTS(21:15) NOT = EXPECTED-RESULT OF TEST-CASE-5 OF TEST-CASES
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Failed."
               MOVE 1 TO WS-TEST-CASE-FAILED
           ELSE
               DISPLAY "Test Case " WS-TEST-CASE-NUM " Passed."
           END-IF.
           ADD 1 TO WS-TEST-CASE-NUM.
