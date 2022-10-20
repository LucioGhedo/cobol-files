 IDENTIFICATION DIVISION.
 PROGRAM-ID. STRINGA2.
 AUTHOR. LUCIO
 DATE-WRITTEN. 18/10/2022
* QUESTO E' UN COMMENTO
*
 ENVIRONMENT DIVISION.  
* 
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 INPUT-OUTPUT SECTION.
 FILE-CONTROL.   

*
                                                            
*                       DATA DIVISION                       
 DATA DIVISION.
 FILE SECTION.

                                                            
*                WORKING-STORAGE SECTION                    

 WORKING-STORAGE SECTION.   
*****************************************************      
* DICHIARO TABELLA CHE CONTIENE 6 RECORDS DIVERSI   * 
* E OGNI RECORD E' COMPOSTO DA NOME, COGNOME ANNI E *
*                     CITTA                         *
*****************************************************
 01   STRINGAA           PIC X(15).
 01   TABELLA REDEFINES STRINGAA.
      05 CARATTERE  OCCURS 15 TIMES.
         10 TAB-COD     PIC X.
 01   SORTED-TABELLA.
      05 PERSONA-S OCCURS 15 TIMES.
         10 TAB-COD-S     PIC X.

 01   CONT              PIC 99 VALUE 0.
 01   USER-INPUT        PIC 99.
 01   SORTED            PIC 9 VALUE 0.
 01   SECOND-COUNTER    PIC 99 VALUE 1.
 01   SAVED-LOWEST      PIC 999 VALUE 0.
 01   CHOICE            PIC 9.
 01   IND               PIC 9 VALUE 1.
 01   TROVATA           PIC 9 VALUE 0.
 01   COUNTER           PIC 99 VALUE 1.
 01   COUNTER-PAROLE    PIC 9 VALUE 1.
 01   SAVED-SPAZIO      PIC 99 VALUE 0.
 01   SPAZI             PIC 99 VALUE 0.
 01   PAROLE            PIC 99 VALUE 0.
*                
                           
 01 WS-SCAMBIO           PIC 9.
 01   SEC-CON           PIC 99 VALUE 0.
 01   SAVED             PIC X.

 01 IND1 PIC 99 VALUE 0.
 01 IND2 PIC 99 VALUE 1.

*                PROCEDURE DIVISION                        
 PROCEDURE DIVISION.                         
 
      
 MAIN-LINE.
      PERFORM APERTURA THRU FINE-APERTURA.
      IF TABELLA = '               '
          DISPLAY 'DIGITA ALMENO UNA LETTERA'
      ELSE
          PERFORM SORTING THRU FINE-SORTING
          VARYING COUNTER FROM 1 BY 1 UNTIL COUNTER = 16  
*          DISPLAY 'HAI DIGITATO ' COUNTER-PAROLE ' PAROLE'
          PERFORM ORDINA THRU FINE-ORDINA UNTIL SEC-CON = 16
          DISPLAY SORTED-TABELLA
          DISPLAY PAROLE ' SPAZI'
          DISPLAY SPAZI ' PAROLE'
      END-IF.
      
      STOP RUN.
 
 APERTURA.  
 
     DISPLAY 'INSERISCI UNA STRINGA DI 15 CARATTERI CON DEGLI'
     ' SPAZI'. 
     ACCEPT STRINGAA.
          
 FINE-APERTURA.   
      EXIT.
* 
 SORTING.
      IF CARATTERE(COUNTER) = ' '
        ADD 1 TO COUNTER-PAROLE 
        MOVE 1 TO TAB-COD-S(COUNTER)
      ELSE
        MOVE 0 TO TAB-COD-S(COUNTER)
      END-IF.
 FINE-SORTING.
      EXIT.
 ORDINA.                       
           IF SEC-CON = 0
                 ADD 1 TO SEC-CON
                 MOVE TAB-COD-S(SEC-CON) TO SAVED
                 DISPLAY SAVED
                 IF TAB-COD-S(SEC-CON) = 0
                     ADD 1 TO SPAZI
                 ELSE
                     ADD 1 TO PAROLE
                 END-IF
           END-IF.
           IF TAB-COD-S(SEC-CON) = SAVED
               
               ADD 1 TO SEC-CON
           ELSE
               IF TAB-COD-S(SEC-CON) = 0
                     ADD 1 TO SPAZI
                 ELSE
                     ADD 1 TO PAROLE
                 END-IF
               MOVE TAB-COD-S(SEC-CON) TO SAVED
               ADD 1 TO SEC-CON
           END-IF.
*          COMPUTE IND1 = IND1 + 1.
*          COMPUTE IND2 = IND1 + 1.  
*          PERFORM SCAMBIA THRU FINE-SCAMBIA UNTIL IND2 = 10.
    
 FINE-ORDINA.      
 SCAMBIA.
* **                  IF TAB-COD(IND1) > TAB-COD (IND2)
*           SCAMBIA I VALORI 
*                   THEN
*                      MOVE PERSONA(IND1)  TO WS-SCAMBIO
*                      MOVE PERSONA(IND2) TO PERSONA(IND1)
*                      MOVE WS-SCAMBIO        TO  PERSONA(IND2) 
*                   END-IF.
* *                  ADD 1 TO IND2.
 FINE-SCAMBIA.
     EXIT.

     
     
     EXIT.