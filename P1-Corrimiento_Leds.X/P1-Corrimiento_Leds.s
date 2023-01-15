PROCESSOR 18F57Q84
#include "BIT_CONFIGS.inc"
#include <xc.inc>
;AUTOR: MAURO ALDAIR GARCIA CORDOVA                                                                                           
;FECHA: 14/01/2023                                                                                                            
;TARJETA: Curiosity Nano PIC18f57q84                                                                                          
;NOMBRE DEL PROYECTO: P1-Corrimiento_Leds                                                                                     
;DESCRIPCION: Este Programa que permite realizar un corrimiento de leds conectados al puerto C, con un retardo de 500 ms      
;en un numero de corrimientos pares y un retardo de 250ms en un numero de corrimientos impares. El corrimiento inicia cuando  
;se presiona el pulsador de la placa una vez y se detiene cuando se vuelve a presionar.             
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT udata_acs
contador1: DS 1   
contador2: DS 1            ; reserva 1 byte en access ram
contador3: DS 1    
    
PSECT CODE
 
Main:
     CALL Config_OSC,1
     CALL Config_Port,1

BUTTON:
    BANKSEL   LATA
    CLRF      LATC,b
    BCF       LATE,1,b
    BCF       LATE,0,b
    BTFSC     PORTA,3,b
    goto      BUTTON
    goto      PAR
     
PAR:
    CLRF  LATC,b
    BCF   LATE,0,b
    BSF   LATE,1,b
    MOVLW 00000010B
    MOVWF LATC,1
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON1
    
    BSF   LATE,1,b
    BCF   LATE,0,b
    MOVLW 00001000B
    MOVWF LATC,1
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON1
    
    BSF   LATE,1,b
    BCF   LATE,0,b
    MOVLW 00100000B
    MOVWF LATC,1
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON1
    
    BSF   LATE,1,b
    BCF   LATE,0,b
    MOVLW 10000000B
    MOVWF LATC,1
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON1
    
 IMPAR:
    CLRF  LATC,b
    BCF   LATE,1,b
    BSF   LATE,0,b
    MOVLW 00000001B
    MOVWF LATC,1
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON2
    
    BCF   LATE,1,b
    BSF   LATE,0,b
    MOVLW 00000100B
    MOVWF LATC,1
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON2
    
    BCF   LATE,1,b
    BSF   LATE,0,b
    MOVLW 00010000B
    MOVWF LATC,1
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON2
    
    
    BCF   LATE,1,b
    BSF   LATE,0,b
    MOVLW 01000000B
    MOVWF LATC,1
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0
    GOTO  BOTON2

    GOTO  PAR
    
BOTON1:
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0
    GOTO    BOTON1
    GOTO    PAR
    
BOTON2:
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0
    GOTO    BOTON1
    GOTO    IMPAR    

    
Config_OSC:
        ;Configuracion del Oscilador interno a una frecuencia interna de 4Mhz 
         BANKSEL OSCCON1
	 MOVLW 0X60     ;Seleccionamos el bloque del osc con un Div:1
	 MOVWF OSCCON1,1
	 MOVLW 0X02     ;Seleccionamos una Frecuencia de 4Mhz
	 MOVWF OSCFRQ ,1
         RETURN

Config_Port:   ;PORT-LAT-ANSEL-TRIS  LED:RF3,  BUTTON:RA3
    ;Config Led
    BANKSEL  PORTF

    CLRF     TRISC,b    ;TRISC = 0 Como salida
    CLRF     ANSELC,b   ;ANSELC<7:0> = 0 - Port C digital
    BCF      TRISE,1,b  ;TRISF<1> = 0  RE1 como SALIDA
    BCF      TRISE,0,b  ;TRISF<0> = 0  RF0 como SALIDA
    BCF      ANSELE,1,b  ;TRISF<1> = 0  RE1 como Digital
    BCF      ANSELE,0,b  ;TRISF<0> = 0  RE0 como Digital
    
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,b     ;PortA<7:0> = 0 
    CLRF    ANSELA,b    ;PortA Digital
    BSF     TRISA,3,b   ;RA3 como entrada
    BSF     WPUA,3,b    ;Activamos la resistencia Pull-up del pin RA3
    RETURN   

;T= (6 + 4k1)(k2)(k3)us            1Tcy=1us   
Delay_500ms:
    MOVLW   2               ;1Tcy--k3
    MOVWF   contador3,0     ;1Tcy
D_500ms:                ;2Tcy--call
    MOVLW   250             ;1Tcy--k2
    MOVWF   contador2,0     ;1Tcy
    
Ext500ms_Loop:                  
    MOVLW   249             ;1Tcy--k1
    MOVWF   contador1,0     ;1Tcy
Int500ms_Loop:
    NOP                     ;K1*Tcy
    DECFSZ  contador1,1,0   ;(k1-1)+ 3Tcy           
    GOTO    Int500ms_Loop   ;2Tcy
    DECFSZ  contador2,1,0   ;2Tcy
    GOTO    Ext500ms_Loop   ;2Tcy 
    DECFSZ  contador3,1,0
    GOTO    D_500ms
    RETURN                  ;2Tcy   
 ;--------------------------
;T= (6 + 4k1)k2us            1Tcy=1us   
Delay_250ms:                ;2Tcy--call
    MOVLW   250             ;1Tcy--k2
    MOVWF   contador2,0     ;1Tcy
    
Ext250ms_Loop:                  
    MOVLW   249             ;1Tcy--k1
    MOVWF   contador1,0     ;1Tcy
Int250ms_Loop:
    NOP                     ;K1*Tcy
    DECFSZ  contador1,1,0   ;(k1-1)+ 3Tcy           
    GOTO    Int250ms_Loop   ;2Tcy
    DECFSZ  contador2,1,0   ;2Tcy
    GOTO    Ext250ms_Loop   ;2Tcy   
    RETURN                  ;2Tcy     
    
END resetVect
