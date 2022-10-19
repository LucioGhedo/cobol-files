 IDENTIFICATION DIVISION.
 PROGRAM-ID. COPYING.
 AUTHOR. LUCIO
 DATE-WRITTEN. 13/3/2017
* QUESTO E' UN COMMENTO
*
 ENVIRONMENT DIVISION.  
* 
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 INPUT-OUTPUT SECTION.
 FILE-CONTROL.   
* INPUT FILE 
***************************************************
* DICHIARO I FILE DI INPUT E OUTPUT CHE ANDRO AD  *
* USARE E GLI ASSEGNO UN NOME ALL INTERNO DEL PROG*
***************************************************

     SELECT PRIMOF   ASSIGN TO 'ANAGRA.TXT'
     ORGANIZATION IS SEQUENTIAL
     ACCESS MODE IS SEQUENTIAL.
* OUTPUT FILE 

     SELECT VERONA ASSIGN TO 'VERONA.TXT'
     ORGANIZATION IS SEQUENTIAL
     ACCESS MODE IS SEQUENTIAL.
     
     SELECT ROMA ASSIGN TO 'ROMA.TXT'
     ORGANIZATION IS SEQUENTIAL
     ACCESS MODE IS SEQUENTIAL.
     
     SELECT ALTRI ASSIGN TO 'ALTRI.TXT'
     ORGANIZATION IS SEQUENTIAL
     ACCESS MODE IS SEQUENTIAL.
*
  
************************************************************
*                       DATA DIVISION                       
************************************************************
 DATA DIVISION.
 FILE SECTION.
 FD   PRIMOF
*      LABEL RECORD IS OMITTED
      DATA RECORD IS REC-PRIMOF.
 01 REC-PRIMOF  PIC X(33).
 FD   ROMA
*      LABEL RECORD IS OMITTED
      DATA RECORD IS REC-ROMA.
 01 REC-ROMA  PIC X(33).
 FD   VERONA
*      LABEL RECORD IS OMITTED
      DATA RECORD IS REC-VERONA.
 01 REC-VERONA  PIC X(33).
 FD   ALTRI
*      LABEL RECORD IS OMITTED
      DATA RECORD IS REC-ALTRI.
 01 REC-ALTRI  PIC X(33).
************************************************************
*                WORKING-STORAGE SECTION                     
************************************************************

 WORKING-STORAGE SECTION.   
 01   WS-PRIMOF.
      05 NOME           PIC X(10).
      05 COGNOME        PIC X(10). 
      05 ETA            PIC 999.
      05 CITTA          PIC X(10).
      
 01   WS-OUTF.     
      05 OUT-COGNOME    PIC X(10). 
      05 OUT-NOME       PIC X(10).
      05 OUT-ETA        PIC 999.
      05 OUT-CITTA      PIC X(10).
*                
    
 01 FINE-FILE PIC X VALUE SPACES.
************************************************************
*                PROCEDURE DIVISION                    
************************************************************
 PROCEDURE DIVISION.    
      
 MAIN-LINE.
      PERFORM APERTURA THRU FINE-APERTURA.
      PERFORM ELABORA THRU FINE-ELABORA UNTIL FINE-FILE = 'S'.
      PERFORM CHIUSURA THRU FINE-CHIUSURA.
      
      STOP RUN.
 
 APERTURA.  
 
     OPEN INPUT PRIMOF.
     OPEN OUTPUT ROMA.   
     OPEN OUTPUT VERONA.
     OPEN OUTPUT ALTRI.
     READ PRIMOF INTO WS-PRIMOF AT END 
          MOVE 'S' TO FINE-FILE
          DISPLAY 'FILE PRIMOF VUOTO'. 
          
 FINE-APERTURA.   
      EXIT.
* 
 ELABORA.    
    
     MOVE WS-PRIMOF TO WS-OUTF.
     
**********************************************     
* CONTROLLO A CHE CITTA CORRISPONDE E FACCIO *
* WRITE NEL FILE CORRISPONDENTE              *
**********************************************
     IF CITTA = 'ROMA      '         
          WRITE REC-ROMA FROM WS-OUTF     
     END-IF
     IF CITTA = 'VERONA    '
          WRITE REC-VERONA FROM WS-OUTF
     END-IF
     IF CITTA NOT EQUAL TO 'ROMA      ' 
     AND NOT EQUAL TO 'VERONA    '
          WRITE REC-ALTRI FROM WS-OUTF
     END-IF
     
     
     
      READ PRIMOF INTO WS-PRIMOF AT END MOVE 'S' TO FINE-FILE.   
      
 FINE-ELABORA.    
      EXIT.
* 
 CHIUSURA. 
******************************************** 
*   CHIUDO TUTTI I FILE                    *
********************************************
     CLOSE PRIMOF
           ROMA
           VERONA
           ALTRI. 
           
 FINE-CHIUSURA.    
      EXIT.