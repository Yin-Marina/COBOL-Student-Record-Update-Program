      ******************************************************************
      * Author: Mutao Yin
      * Date: 2023-04-07
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATE-AVG.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01 STUDENT-AVERAGE-REPORT   PIC 9(3).
       01 COURSE-AVERAGE1          PIC 9(3).
       01 COURSE-AVERAGE2          PIC 9(3).
       01 COURSE-AVERAGE3          PIC 9(3).
       01 COURSE-AVERAGE4          PIC 9(3).
       01 COURSE-AVERAGE5          PIC 9(3).

       PROCEDURE DIVISION
           USING STUDENT-AVERAGE-REPORT, COURSE-AVERAGE1,
                         COURSE-AVERAGE2,COURSE-AVERAGE3,
                         COURSE-AVERAGE4,COURSE-AVERAGE5.

           COMPUTE STUDENT-AVERAGE-REPORT ROUNDED =
                (COURSE-AVERAGE1 + COURSE-AVERAGE2 + COURSE-AVERAGE3
               + COURSE-AVERAGE4 + COURSE-AVERAGE5) / 5.

       END PROGRAM CALCULATE-AVG.
