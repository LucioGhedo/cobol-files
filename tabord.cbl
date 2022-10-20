 IDENTIFICATION DIVISION.
 PROGRAM-ID. TABORD.
 AUTHOR. SIMONE
 DATE-WRITTEN. 18/10/2022
* QUESTO E' UN COMMENTO
*
 ENVIRONMENT DIVISION.  
* 
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 INPUT-OUTPUT SECTION.
 FILE-CONTROL.   
* INPUT FILE 
**************************************************
*  SELEZIONO IL FILE ANAGR.TXT E GLI ASSEGNO IL  *
*                  NOME PRIMOF                   *
**************************************************
     SELECT PRIMOF   ASSIGN TO 'ANAGR.TXT'
     ORGANIZATION IS SEQUENTIAL
     ACCESS MODE IS SEQUENTIAL.
* OUTPUT FILE 


*
                                                            
*                       DATA DIVISION                       
 DATA DIVISION.
 FILE SECTION.
****************************************************
* IL FILE PRIMOF VIENE DICHIARATO CON UNA LUNGHEZZA*
* DI 33 BYTE (FILE DESCRIPTION)                    *  
****************************************************
 FD   PRIMOF
*      LABEL RECORD IS OMITTED
      DATA RECORD IS REC-PRIMOF.
 01 REC-PRIMOF  PIC X(36).
                                                            
*                WORKING-STORAGE SECTION                    

 WORKING-STORAGE SECTION.   
 01   WS-PRIMOF.
      05 NOME           PIC X(10).
      05 COGNOME        PIC X(10). 
      05 ANNI           PIC 999.
      05 CITTA          PIC X(10).
      
 01   WS-OUTF.     
      05 OUT-NOME       PIC X(10). 
      05 OUT-COGNOME    PIC X(10).
      05 OUT-ANNI       PIC 999.
      05 OUT-CITTA      PIC X(10).
*****************************************************      
* DICHIARO TABELLA CHE CONTIENE 6 RECORDS DIVERSI   * 
* E OGNI RECORD E' COMPOSTO DA NOME, COGNOME ANNI E *
*                     CITTA                         *
*****************************************************
 01   TABELLA.
      05 PERSONA OCCURS 6 TIMES INDEXED BY INDICE.
         10 TAB-COD     PIC 999.
         10 TAB-NOME    PIC X(10).
         10 TAB-COGNOME PIC X(10).
         10 TAB-ANNI    PIC 999.
         10 TAB-CITTA   PIC X(10).
 01   SORTED-TABELLA.
      05 PERSONA-S OCCURS 6 TIMES.
         10 TAB-COD-S     PIC 999.
         10 TAB-NOME-S    PIC X(10).
         10 TAB-COGNOME-S PIC X(10).
         10 TAB-ANNI-S    PIC 999.
         10 TAB-CITTA-S   PIC X(10).
 01   CONT              PIC 99 VALUE 0.
 01   USER-INPUT        PIC 99.
 01   SORTED            PIC 9 VALUE 0.
 01   SECOND-COUNTER    PIC 99 VALUE 1.
 01   SAVED-LOWEST      PIC 999 VALUE 0.
 01   CHOICE            PIC 9.
 01   NOME-CITTA        PIC X(10).
 01   IND               PIC 9 VALUE 1.
 01   TROVATA           PIC 9 VALUE 0.
*                
    
 01 FINE-FILE PIC X VALUE SPACES.                           
*                PROCEDURE DIVISION                        
 PROCEDURE DIVISION.    
      
 MAIN-LINE.
      PERFORM APERTURA THRU FINE-APERTURA.
      PERFORM ELABORA  THRU FINE-ELABORA UNTIL FINE-FILE = 'S'.
*      PERFORM SORTING THRU FINE-SORTING UNTIL SORTED = 1.
      PERFORM RICERCA THRU FINE-RICERCA UNTIL CHOICE = '0' OR
      '000'.
      PERFORM CHIUSURA THRU FINE-CHIUSURA.
      
      STOP RUN.
 
 APERTURA.  
 
     OPEN INPUT PRIMOF.
     
     READ PRIMOF INTO WS-PRIMOF AT END 
          MOVE 'S' TO FINE-FILE
          DISPLAY 'FILE PRIMOF VUOTO'. 
          
 FINE-APERTURA.   
      EXIT.
* 
 ELABORA.    
    
     MOVE WS-PRIMOF TO WS-OUTF.
     
     ADD 1 TO CONT.          
     MOVE WS-OUTF TO PERSONA(CONT).
     
*     DISPLAY 'RIGA  ' PERSONA(CONT).


     
     
     READ PRIMOF INTO WS-PRIMOF AT END MOVE 'S' TO FINE-FILE.   
      
 FINE-ELABORA.
      EXIT.
* 
 CHIUSURA.
 
     CLOSE PRIMOF.

                                
 FINE-CHIUSURA.    
     
     
     
     EXIT.
 RICERCA.
     DISPLAY 'RICERCA PER ID O CITTA? 1 PER ID 2 PER CITTA E 0'
     'PER FERMARE'.
     ACCEPT CHOICE.
     IF CHOICE = 1
     MOVE 0 TO TROVATA
     DISPLAY 'DAMMI UN INDICE O PREMI 0 PER FERMARE'
     ACCEPT USER-INPUT
     IF USER-INPUT IS NOT EQUAL TO 0
          SET INDICE TO USER-INPUT
          SEARCH PERSONA AT END DISPLAY 'PERSONA NON TROVATA' 
          WHEN PERSONA(INDICE) = PERSONA(INDICE) 
          DISPLAY 'TROVATA PERSONA'
          DISPLAY PERSONA(INDICE)     
     END-IF
     END-IF.
     IF CHOICE = 000
          MOVE 0 TO USER-INPUT
     END-IF.
     IF CHOICE = 2
     
          DISPLAY 'INSERISCI NOME CITTA'
          ACCEPT NOME-CITTA 
          SEARCH  
          PERSONA 
           AT END DISPLAY 'CITTA NON TROVATA'
          WHEN TAB-CITTA(INDICE) = NOME-CITTA
*          MOVE 1 TO TROVATA
          DISPLAY PERSONA(INDICE)
*          PERFORM CITTA-SEARCH THRU FINE-CITTA-SEARCH 6 TIMES
     END-IF.
 
 FINE-RICERCA.
     EXIT.
 CITTA-SEARCH. 
     IF TROVATA = 0
     SEARCH PERSONA AT END DISPLAY 'CITTA NON TROVATA'
          WHEN TAB-CITTA(INDICE) = NOME-CITTA
*          MOVE 1 TO TROVATA
          DISPLAY PERSONA(INDICE)

          DISPLAY 'TROVATA' 
     END-IF.     
 FINE-CITTA-SEARCH.           
     EXIT.