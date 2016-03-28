      ******************************************************************
      * Author: DENNIS NG
      * Date: 28 MARCH 2016
      * Purpose: JOINT THE PROGRAMMING FOR ABCDEFGHPPP
      * Technical Info:
      * Editor use OpenCobolIDE which recommend use brew
      * if use brew (some issues may be file directory blank)
      *    export PATH=$PATH:/usr/local/Cellar/gcc/5.2.0/bin/
      * if use Macport as recommended here
      *  https://coderwall.com/p/q-fhya/
      *   install-opencobol-with-macports
      * still need to set
      *   export PATH=/opt/local/bin:/opt/local/sbin:$PATH
      * details see
      *   https://guide.macports.org

      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. ABCDEFGHPPP.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       01  A PIC 99 VALUE 1.
       01  B PIC 99 VALUE 0.
       01  C PIC 99 VALUE 1.
       01  D PIC 99 VALUE 0.
       01  E PIC 99 VALUE 1.
       01  F PIC 99 VALUE 0.
       01  EFT1 PIC 999 VALUE 0.
       01  EFT2 PIC 999 VALUE 0.
       01  G PIC 99 VALUE 1.
       01  H PIC 99 VALUE 0.
       01  P PIC 99 VALUE 1.
       01  PPPT1 PIC 999 VALUE 0.
       01  PPPT2 PIC 999 VALUE 0.
       01  EDIT-A PIC Z9.
       01  EDIT-B PIC Z9.
       01  EDIT-C PIC Z9.
       01  EDIT-D PIC Z9.
       01  EDIT-E PIC Z9.
       01  EDIT-F PIC Z9.
       01  EDIT-G PIC Z9.
       01  EDIT-H PIC Z9.
       01  EDIT-P PIC Z9.

      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
            DISPLAY "----------------------------------------"
            DISPLAY "( ",
                   " A", " ",
                   " B", " ",
                   " C", " ",
                   " D", " ",
                   " E", " ",
                   " F", " ",
                   " G", " ",
                   " H", " ",
                   " P", " )"
            move 1 to A
            perform until A > 9
            move 0 to B
            perform until B > 9
            move 1 to C
            perform until C > 9
            move 0 to D
            perform until D > 9
            move 1 to E
            perform until E > 9
            move 0 to F
            perform until F > 9
            move 1 to G
            perform until G > 9
            move 0 to H
            perform until H > 9
            move 1 to P
            perform until P > 9
      *
      *     This if loop come from the fortrain except delete
      *        delete 1 .AND. (a \=b)
      *     The loop above is similar except I do not want to
      *        indent as the pattern is clear
      *
               if ( ((a*10+b) - (c*10+d) = (e*10+f))
                AND ((e*10+f) + (g*10+h) = p*111)
                        AND (a NOT= b)
                        AND (a NOT= c)
                        AND (a NOT= d)
                        AND (a NOT= e)
                        AND (a NOT= f)
                        AND (a NOT= g)
                        AND (a NOT= h)
                        AND (a NOT= p)
                        AND (b NOT= c)
                        AND (b NOT= d)
                        AND (b NOT= e)
                        AND (b NOT= f)
                        AND (b NOT= g)
                        AND (b NOT= h)
                        AND (b NOT= p)
                        AND (c NOT= d)
                        AND (c NOT= e)
                        AND (c NOT= f)
                        AND (c NOT= g)
                        AND (c NOT= h)
                        AND (c NOT= p)
                        AND (d NOT= e)
                        AND (d NOT= f)
                        AND (d NOT= g)
                        AND (d NOT= h)
                        AND (d NOT= p)
                        AND (e NOT= f)
                        AND (e NOT= g)
                        AND (e NOT= h)
                        AND (e NOT= p)
                        AND (f NOT= g)
                        AND (f NOT= h)
                        AND (f NOT= p)
                        AND (g NOT= h)
                        AND (g NOT= p)
                        AND (h NOT= p)
                    ) then
               move a to edit-a
               move b to edit-b
               move c to edit-c
               move d to edit-d
               move e to edit-e
               move f to edit-f
               move g to edit-g
               move h to edit-h
               move p to edit-p
               DISPLAY "( ",
                   edit-a, " ",
                   edit-b, " ",
                   edit-c, " ",
                   edit-d, " ",
                   edit-e, " ",
                   edit-f, " ",
                   edit-g, " ",
                   edit-h, " ",
                   edit-p, " )"
               end-if
            Add 1 to P
            end-perform
            Add 1 to H
            end-perform
            Add 1 to G
            end-perform
            Add 1 to F
            end-perform
            Add 1 to E
            end-perform
            Add 1 to D
            end-perform
            Add 1 to C
            end-perform
            Add 1 to B
            end-perform
            Add 1 to A
            end-perform.


           display "========================================"

            STOP RUN.
      ** add other procedures here
       END PROGRAM ABCDEFGHPPP.
      *
      * To execute
      * $ cobc -x /cob-test/abcdefghppp.COB
      * $ ./abcdefghppp
      *
      * result as
      *
      * ----------------------------------------
      *(  A  B  C  D  E  F  G  H  P )
      *(  8  5  4  6  3  9  7  2  1 )
      *(  8  6  5  4  3  2  7  9  1 )
      *(  9  0  2  7  6  3  4  8  1 )
      *(  9  0  6  3  2  7  8  4  1 )
      *(  9  5  2  7  6  8  4  3  1 )
      *========================================
      *$
