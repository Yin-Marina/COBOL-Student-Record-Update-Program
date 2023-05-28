      ******************************************************************
      * Author: Mutao Yin
      * Date: March 27, 2023
      * Purpose: Project 3 Program-1
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJECT3-P1.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT STUDENT-FILE-IN
           ASSIGN TO "C:/STUFILE3.TXT"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT INDEXED-STUDENT-FILE
           ASSIGN TO "../INDEXEDSTUFILE.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS SEQUENTIAL
      * DYNAMIC WORKS FINE. INSTRUCTIONS MENTIONED IT SHOULD BE INDEXED SEQUENTIAL.
           RECORD KEY IS INDEXED-STUDENT-NUMBER
           FILE STATUS IS STATUS-FIELD.

       DATA DIVISION.
       FILE SECTION.

      *Column fields in STUDENT-FILE-IN.
       FD STUDENT-FILE-IN.
       01 STUDENT-RECORD-IN.
           05 STUDENT-NUMBER PIC 9(6).
           05 TUITION-OWED PIC 9(4)V99.
           05 STUDENT-NAME PIC X(40).
           05 PROGRAM-OF-STUDY PIC X(5).
           05 COURSE-CODE-1 PIC X(7).
           05 COURSE-AVERAGE-1 PIC 9(3).
           05 COURSE-CODE-2 PIC X(7).
           05 COURSE-AVERAGE-2 PIC 9(3).
           05 COURSE-CODE-3 PIC X(7).
           05 COURSE-AVERAGE-3 PIC 9(3).
           05 COURSE-CODE-4 PIC X(7).
           05 COURSE-AVERAGE-4 PIC 9(3).
           05 COURSE-CODE-5 PIC X(7).
           05 COURSE-AVERAGE-5 PIC 9(3).

      *Column fields in INDEXED-STUDENT-FILE.
       FD INDEXED-STUDENT-FILE.
       01 INDEXED-STUDENT-RECORD.
           05 INDEXED-STUDENT-NUMBER PIC 9(6).
           05 INDEXED-TUITION-OWED PIC 9(4)V99.
           05 INDEXED-STUDENT-NAME PIC X(40).
           05 INDEXED-PROGRAM-OF-STUDY PIC X(5).
           05 INDEXED-COURSE-CODE-1 PIC X(7).
           05 INDEXED-COURSE-AVERAGE-1 PIC 9(3).
           05 INDEXED-COURSE-CODE-2 PIC X(7).
           05 INDEXED-COURSE-AVERAGE-2 PIC 9(3).
           05 INDEXED-COURSE-CODE-3 PIC X(7).
           05 INDEXED-COURSE-AVERAGE-3 PIC 9(3).
           05 INDEXED-COURSE-CODE-4 PIC X(7).
           05 INDEXED-COURSE-AVERAGE-4 PIC 9(3).
           05 INDEXED-COURSE-CODE-5 PIC X(7).
           05 INDEXED-COURSE-AVERAGE-5 PIC 9(3).

       WORKING-STORAGE SECTION.
       01 CONTROL-FILED.
           05 EOF-FLG   PIC X(1).
           05 STATUS-FIELD   PIC X(2).

       PROCEDURE DIVISION.
      *Main procedures for creating indexed file.
       100-CREATE-STUDENT-INDEXED-FILE.
           PERFORM 201-INITIALIZE-CREATE-IND-FILE.
           PERFORM 202-PROCESS-STUDENT-RECORDS UNTIL EOF-FLG = "Y".
           PERFORM 203-TERMINATE-PROGRAM.
           STOP RUN.

      *Initilize for creating files
           201-INITIALIZE-CREATE-IND-FILE.
           PERFORM 301-OPEN-FILES.
           PERFORM 302-READ-STUDENT-RECORD.

      *Create student records
           202-PROCESS-STUDENT-RECORDS.
           PERFORM 303-WRITE-STUDENT-RECORD.
           PERFORM 302-READ-STUDENT-RECORD.

      *Close input and output files
           203-TERMINATE-PROGRAM.
           CLOSE STUDENT-FILE-IN, INDEXED-STUDENT-FILE.

      *Open input and output files
           301-OPEN-FILES.
           OPEN INPUT STUDENT-FILE-IN.
           OPEN OUTPUT INDEXED-STUDENT-FILE.

      *Read students' records from STUDENT-FILE-IN
           302-READ-STUDENT-RECORD.
           READ STUDENT-FILE-IN
               AT END MOVE "Y" TO EOF-FLG.

      *Write students' records to INDEXED-STUDENT-FILE
           303-WRITE-STUDENT-RECORD.
           WRITE INDEXED-STUDENT-RECORD FROM STUDENT-RECORD-IN
           INVALID KEY
               DISPLAY "The record is INVALID."
               DISPLAY "STATUS-FIELD IS ", STATUS-FIELD
               DISPLAY INDEXED-STUDENT-RECORD

           NOT INVALID KEY
               DISPLAY "STATUS-FIELD IS ", STATUS-FIELD.

       END PROGRAM PROJECT3-P1.
