#include "BIT_CONFIG.inc" 
#include <xc.inc>
;AUTOR: MAURO ALDAIR GARCIA CORDOVA                                                                                           
;FECHA: 14/01/2023                                                                                                            
;TARJETA: Curiosity Nano PIC18f57q84                                                                                          
;NOMBRE DEL PROYECTO: P2-Display_7SEG                                                                                    
;DESCRIPCION: Este programa permite mostrar los valores alfanuméricos(0-9 y A-F) en un display 
;de 7 segmentos ánodo común, conectados al puerto D. Los valores a mostrar son seleccionados por la siguiente condición:
;Si el botón de la placa no esta presionado, se muestran los valores numéricos del 0 al 9.
;Si el botón de la placa se mantiene presionado, se muestran los valores de A hasta F.
;Cada valor se muestra con un retardo de 1 segundo entre transición. 
PSECT udata_acs   
contador1: DS 1           ;reserva un byte en access ram
contador2: DS 1
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
 
Main:
    CALL Config_OSC,1
    CALL Button
    CALL Display
    CALL Loop
    NOP
Loop:
    BTFSS PORTA,3,1
    goto Letras
 Numeros:
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BSF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BSF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BSF LATD,5,0
    BCF TRISD,6,0
    BSF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BSF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BSF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BSF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BSF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BSF LATD,5,0
    BCF TRISD,6,0
    BSF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BSF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSS PORTA,3,1
    goto Letras
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    goto Loop
 Letras:
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BSF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BCF TRISD,2,0
    BSF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BSF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BSF LATD,0,0
    BCF TRISD,1,0
    BCF LATD,1,0
    BCF TRISD,2,0
    BCF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BSF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BSF TRISD,2,0
    BSF LATD,2,0
    BCF TRISD,3,0
    BCF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,0
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    BCF TRISD,0,0
    BCF LATD,0,0
    BCF TRISD,1,0
    BSF LATD,1,0
    BCF TRISD,2,0
    BSF LATD,2,0
    BCF TRISD,3,0
    BSF LATD,3,0
    BCF TRISD,4,0
    BCF LATD,4,0
    BCF TRISD,5,0
    BCF LATD,5,0
    BCF TRISD,6,0
    BCF LATD,6,0
    BCF TRISD,7,0
    BSF LATD,7,1
    BTFSC PORTA,3,1
    goto Numeros
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    CALL Delay_250ms,1
    goto Loop
    
Button:
    BANKSEL PORTA
    CLRF PORTA,1
    CLRF ANSELA,1
    BSF TRISA,3,1
    BSF LATA,3,1
    BSF WPUA,3,1
    RETURN
     
Config_OSC:
    BANKSEL OSCCON1
    MOVLW 0x60
    MOVWF OSCCON1,1
    MOVLW 0x02
    MOVWF OSCFRQ,1
    RETURN
 
    
Display:
    BANKSEL PORTD
    CLRF PORTD,0
    CLRF ANSELD,0
    RETURN
    
;Delay de 250ms

Delay_250ms:             ; 2Tcy -- Call
    MOVLW 250             ; 1Tcy -- k2
    MOVWF contador2,0     ; 1Tcy
;T = (6+4k)us             1Tcy = 1us
Ext_Loop:                 ; 2Tcy -- Call
    MOVLW   249           ; 1Tcy -- k1
    MOVWF   contador1,0   ; 1Tcy, contador1 en access

Int_Loop:
    NOP                   ; (k1*Tcy)
    DECFSZ  contador1,1,0 ; (k1-1)+ 3Tcy, Decrementa el registro y salta si es cero
    GOTO    Int_Loop      ; (k1-1)*2Tcy
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN                ; 2Tcy        
    END resetVect


