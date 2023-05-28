      ******************************************************************
      * Author: Mutao Yin
      * Date: March 27, 2023
      * Purpose: Project 3 Program-2
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TASK2.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INDEXED-STU-FILE
             ASSIGN "../INDEXEDSTUFILE.DAT"
             ORGANIZATION IS INDEXED
             RECORD KEY IS STUDENT-NUMBER
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS STATUS-FIELD.

       DATA DIVISION.
       FILE SECTION.
       FD INDEXED-STU-FILE.
       01 STUDENT-RECORD.
           05 STUDENT-NUMBER    PIC 9(6) .
           05 TUITION-OWED      PIC S9(4)V99.
           05 STUDENT-NAME      PIC X(40).
           05 PROGRAM-NAME      PIC X(5).
           05 COURSE-CODE1      PIC X(7).
           05 COURSE-AVERAGE1   PIC 9(3).
           05 COURSE-CODE2      PIC X(7).
           05 COURSE-AVERAGE2   PIC 9(3).
           05 COURSE-CODE3      PIC X(7).
           05 COURSE-AVERAGE3   PIC 9(3).
           05 COURSE-CODE4      PIC X(7).
           05 COURSE-AVERAGE4   PIC 9(3).
           05 COURSE-CODE5      PIC X(7).
           05 COURSE-AVERAGE5   PIC 9(3).

.      WORKING-STORAGE SECTION.
       01 STUDENT-RECORD-WS.
           05 STUDENT-NUMBER-WS    PIC 9(6) .
           05 TUITION-OWED-WS      PIC S9(4)V99.
           05 STUDENT-NAME-WS      PIC X(40).
           05 PROGRAM-NAME-WS  PIC X(5).
           05 COURSE-CODE1-WS      PIC X(7).
           05 COURSE-AVERAGE1-WS   PIC 9(3).
           05 COURSE-CODE2-WS      PIC X(7).
           05 COURSE-AVERAGE2-WS   PIC 9(3).
           05 COURSE-CODE3-WS      PIC X(7).
           05 COURSE-AVERAGE3-WS   PIC 9(3).
           05 COURSE-CODE4-WS      PIC X(7).
           05 COURSE-AVERAGE4-WS   PIC 9(3).
           05 COURSE-CODE5-WS      PIC X(7).
           05 COURSE-AVERAGE5-WS   PIC 9(3).

       01 STUDENT-RECORD-UPDATE.
           05 TUITION-PAYMENT-WS PIC 9(4)V99.

       01 STATUS-FIELD PIC X(2).
       01 WS-EOF       PIC X VALUE 'N'.
       01 WAIT-FLAG PIC 9(1).



       SCREEN SECTION.
       01  INPUT-SCREEN.
           05 VALUE "ENTER STUDENT NUMBER" BLANK SCREEN LINE 1 COL 35.
           05 VALUE "STUDENT NUMBER" LINE 3 COL 10.
           05 STUDENT-NUMBER-IN LINE 3 COL 28
                   PIC  9(6) TO STUDENT-NUMBER.

       01  UPDATE-SCREEN.
           05 VALUE "UPDATE TUITION" BLANK SCREEN LINE 1 COL 35.
           05 VALUE "STUDENT NUMBER" LINE 3 COL 10.
           05 STUDENT-NUMBER-OUT LINE 3 COL 28
                   PIC  9(6) FROM STUDENT-NUMBER.

           05 VALUE "STUDENT NAME" LINE 5 COL 10.
           05 STUDENT-NAME-OUT LINE 5 COL 28
                   PIC X(40) FROM STUDENT-NAME.

           05 VALUE "PROGRAM NAME" LINE 7 COL 10.
           05 PROGRAM-NAME-OUT LINE 7 COL 28
                   PIC X(20) FROM PROGRAM-NAME.

           05 VALUE "TUITION OWNED" LINE 9 COL 10.
           05 TUITION-OWNED-OUT LINE 9 COL 28
                   PIC $ZZZ9.99CR FROM TUITION-OWED.

           05 VALUE "TUITION PAYMENT" LINE 11 COL 10.
           05 TUITION-PAYMENT LINE 11 COL 28
                   PIC $ZZZ9.99CR USING TUITION-PAYMENT-WS.



       01  PRINT-REC-SCREEN.
           05 VALUE "OUTPUT" BLANK SCREEN LINE 1 COL 35.
           05 VALUE "STUDENT NUMBER" LINE 3 COL 10.
           05 STUDENT-NUMBER-OUT LINE 3 COL 32
                   PIC  X(6) FROM STUDENT-NUMBER-WS.

           05 VALUE "STUDENT NAME" LINE 5 COL 10.
           05 STUDENT-NAME LINE 5 COL 32
                   PIC X(40) FROM STUDENT-NAME-OUT.

           05 VALUE "PROGRAM NAME" LINE 7 COL 10.
           05 PROGRAM-NAME LINE 7 COL 32
                   PIC X(20) FROM PROGRAM-NAME-OUT.

           05 VALUE "TUITION OWNED(UPDATED)" LINE 9 COL 10.
           05 TUITION-OWNED LINE 9 COL 32
                   PIC $ZZZ9.99CR FROM TUITION-OWED-WS.



       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM 201-INITIAL-FILE.
           PERFORM 202-UPDATED-STUDENT-FILE.
           PERFORM 206-CLOSE-FILE.
            STOP RUN.

       201-INITIAL-FILE.
           OPEN I-O INDEXED-STU-FILE.
           PERFORM 301-ACCEPT-STUDENT-NUMBER.
           PERFORM 302-READ-STUDENT-FILE.

       301-ACCEPT-STUDENT-NUMBER.
           DISPLAY INPUT-SCREEN.
           ACCEPT INPUT-SCREEN.

       302-READ-STUDENT-FILE.
           READ INDEXED-STU-FILE
               INVALID KEY
                   DISPLAY "INVALID KEY" LINE 5 COL 10
      *>              DISPLAY "FILE-STATUS IS " LINE 5 COL 30 STATUS-FIELD
                   ACCEPT WAIT-FLAG LINE 5 COL 40
                   MOVE 1 TO WAIT-FLAG
                   PERFORM 206-CLOSE-FILE
               NOT INVALID KEY
                   DISPLAY "VALID KEY" LINE 5 COL 10
      *>              DISPLAY "FILE-STATUS IS " LINE 5 COL 30 STATUS-FIELD
                   ACCEPT WAIT-FLAG LINE 5 COL 40
                   MOVE 0 TO WAIT-FLAG.
      *wait flag controls if proceed to update files

       202-UPDATED-STUDENT-FILE.
           PERFORM 303-ACCEPT-TUITION-PAYMENT.
           MOVE STUDENT-RECORD TO STUDENT-RECORD-WS.
           IF WAIT-FLAG = 1
               THEN MOVE 0 TO TUITION-OWED-WS.
           SUBTRACT TUITION-PAYMENT-WS FROM TUITION-OWED-WS
               GIVING TUITION-OWED-WS.
           PERFORM 304-REWRITE-STUDENT-FILE.

       303-ACCEPT-TUITION-PAYMENT.
           DISPLAY UPDATE-SCREEN.
           ACCEPT UPDATE-SCREEN.

       304-REWRITE-STUDENT-FILE.
           REWRITE STUDENT-RECORD FROM STUDENT-RECORD-WS
               INVALID KEY
                   DISPLAY "INVALID KEY"
                   DISPLAY "FILE-STATUS IS " STATUS-FIELD
               NOT INVALID KEY
                   DISPLAY "FILE-STATUS IS " STATUS-FIELD
           END-REWRITE.
           DISPLAY PRINT-REC-SCREEN.
           ACCEPT PRINT-REC-SCREEN.

       206-CLOSE-FILE.
           CLOSE INDEXED-STU-FILE.

       END PROGRAM TASK2.
