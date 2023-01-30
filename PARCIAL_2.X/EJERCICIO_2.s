PROCESSOR 18F57Q84
#include"BITS_CONFIG.inc"
#include <xc.inc>
;#include"Retardos_3.inc"
;AUTOR: MAURO ALDAIR GARCIA CORDOVA                                                                                           
;FECHA: 14/01/2023                                                                                                            
;TARJETA: Curiosity Nano PIC18f57q84                                                                                          
;NOMBRE DEL PROYECTO: PARCIAL_2                                                                                    
;DESCRIPCION: En este programa al presionar el botón de placa se ejecuta la siguiente secuencia:
;1. Se inicia el encendido de leds en el Puerto C con la siguiente secuencia:
;a. RB0 y RB7
;b. RB1 y RB6
;c. RB2 y RB5
;d. RB3 y RB4
;e. Se apagan todos
;Terminada la secuencia anterior se inicia el encendido de leds en el Puerto C con la siguiente secuencia:
;f. RB3 y RB4
;g. RB2 y RB5
;h. RB1 y RB6
;i. RB0 y RB7
;j. Se apagan todos
;
;La secuencia se detiene cuando se presione otro pulsador externo conectado en el pin RB4 o hasta que el número de
;repeticiones sea. El retardo entre el encendido y apagado de los leds será de 250 ms.
;Otro pulsador externo conectado al RF2 reinicia toda la secuencia y apaga los leds.
;Mientras no se active ninguna interrupción, el programa principal, realice un toggle del led de la placa cada 500 ms.
;RA3: Interrupción de baja prioridad (INT0)
;RB4: Interrupción de baja prioridad (INT1)
;RF2: Interrupción de alta prioridad (INT2)

PSECT udata_acs
offset:	    DS	1
counter:    DS	1  
contador_5: DS	1
captura:    DS	1
apaga:	    DS	1
contador1:  DS	1
contador2:  DS	1 
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main  
   
    
PSECT int0,class=CODE,reloc=2
int0:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT0?
    GOTO    continue
Leds_Off:
    BCF	    PIR1,0,0	; limpiamos el flag de INT0
    GOTO   Inicio
 
continue:
    BTFSS   PIR6,0,0	; ¿Se ha producido la INT0?
    GOTO    Exit1
CAP:
    BCF	    PIR6,0,0	; limpiamos el flag de INT0
    ;MOVF    captura,0,0
;    MOVWF   LATC,0
    CLRF    LATC,0
    CALL    Delay_250ms,1
Exit1:
    RETFIE         
;PSECT int1,class=CODE,reloc=2
;int1:
;BTFSS   PIR6,0,0	; ¿Se ha producido la INT0?
;GOTO    Exit2
;CAP:
;BCF	    PIR6,0,0	; limpiamos el flag de INT0
;MOVF    captura,0,0
;MOVWF   LATC,0
;GOTO    CAP
;Exit2:
;RETFIE    
    
PSECT ISRVectLowPriority,class=CODE,reloc=2
ISRVectLowPriority:
    BTFSS   PIR10,0,0	; ¿Se ha producido la INT0?
    GOTO    Exit3
Detencion:
    BCF	    PIR10,0,0	; limpiamos el flag de INT0
    SETF    apaga,0
;   CLRF    LATC,0
;   SETF    LATC,0
;   CALL    Delay_250ms,1
Exit3:
    ;GOTO    Exit1   
    RETFIE        
PSECT CODE
 
Main:
    CALL    CONFI_OSC,1
    CALL    CONFI_PORT,1
    CALL    CONFI_PPS,1
    CALL    CONFI_INT,1
Inactivo:
    SETF    LATC,0
    BANKSEL LATF
    BCF	    LATF,3,1	;Led on
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BSF	    LATF,3,1	;Led off
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    goto    Inactivo
Inicio:
    MOVLW   5
    MOVWF   contador_5,0	;carga el contador con el numero de offset
    MOVLW   0
    MOVWF   apaga,0	;carga el contador con el numero de offset
    GOTO    reload
; ----- Pasos para implementar Computed_GOTO -----   
; 1.Escribir el byte superior en PCLATU
; 2.Escribir el byte alto en PCLATH
; 3.Escribir el byte bajo en PCL
; NOTA:El offset debe ser multiplicado por "2" para el alineamiento en memoria.
    
Loop: 
    BANKSEL PCLATU
    MOVLW   low highword(TABLE)
    MOVWF   PCLATU,1
    MOVLW   high(TABLE)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
    CALL    TABLE 
    MOVWF   LATC,0
    MOVWF   captura,0
    CALL    Delay_250ms
    BTFSC   apaga,1,0   
    GOTO    Exit1
    DECFSZ  counter,1,0
    GOTO    Next_seq
    GOTO    Apagado    
Next_seq:
    INCF    offset,1,0
    BTFSS   apaga,1,0   
    GOTO    Loop
    GOTO    Exit1
    
    
Apagado:
    DECFSZ  contador_5,1,0
    GOTO    reload
    GOTO    Exit1
reload: 
    BSF	    LATF,3,1	;Led on
    MOVLW   10
    MOVWF   counter,0	;carga el contador con el numero de offset
    MOVLW   0x00
    MOVWF   offset,0	;definimos el valor del offset inicial
    GOTO    Loop
    
TABLE:
    ADDWF   PCL,1,0
    RETLW   01111110B	; offset: 0
    RETLW   10111101B	; offset: 1
    RETLW   11011011B	; offset: 2
    RETLW   11100111B	; offset: 3
    RETLW   11111111B	; offset: 4
    RETLW   11100111B	; offset: 5
    RETLW   11011011B	; offset: 6
    RETLW   10111101B	; offset: 7
    RETLW   01111110B	; offset: 8
    RETLW   11111111B	; offset: 9
;reinicio:
;MOVLW   0
;    SETF    apaga,0	;carga el contador con el numero de offset
;    GOTO    Exit3
CONFI_OSC:  
    BANKSEL OSCCON1
    MOVLW   0x60	;selecccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT:
    ;Configuracion del led
    BANKSEL PORTF   
    CLRF    PORTF,1	;PORTF = 0
    BSF     LATF,3,1	;LATF = 0 -- Leds apagado
    CLRF    ANSELF,1	;ANSELF = 0 -- Digital
    BCF     TRISF,3,1
    
    ;Configuracion de butom
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	;ANSELA = 0 -- Digital
    BSF	    TRISA,3,1	;TRISA = 1 --> entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    
    ;Configuracion de PORTC
    BANKSEL PORTC   
    CLRF    PORTC,1	;PORTC = 0
    CLRF    LATC,1	;LATC = 0 -- Leds apagado
    CLRF    ANSELC,1	;ANSELC = 0 -- Digital
    CLRF    TRISC,1
    
    BANKSEL PORTB
;    BANKSEL ANSELB
;    BANKSEL TRISB
;    BANKSEL WPUB
    CLRF    PORTB,1
    CLRF    ANSELB,1
    CLRF    TRISB,1
    CLRF    WPUB,1
    BCF     ANSELB,4,1    ; Puerto digital
    BSF     TRISB,4,1     ; Puerto Entrada 
    BSF     WPUB,4,1      ; Activamos la resistencia
    RETURN 
    
CONFI_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	; INT0 --> RA3  
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x0C 
    MOVWF   INT1PPS,1
    ;Config INT2
    BANKSEL INT2PPS
    MOVLW   0x2A
    MOVWF   INT2PPS,1
    RETURN
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
CONFI_INT:
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 0 -- Deshabilitar prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de alta prioridad
    BCF	IPR6,0,1    ; IPR6<INT1IP> = 0 -- INT1 de baja prioridad
    BSF	IPR10,0,1    ;IPR10<INT2IP> = 1 -- INT2 de ALTA prioridad
     ;Config INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext
   
    ;Config INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de bajada
    BCF	PIR6,0,0    ; PIR6<INT1IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT1IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Config INT2
    BCF	INTCON0,2,0 ; INTCON0<INT2EDG> = 0 -- INT2 por flanco de bajada
    BCF	PIR10,0,0    ; PIR10<INT2IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE10,0,0    ; PIE10<INT2IE> = 1 -- habilitamos la interrupcion ext1
    
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN
Delay_250ms: 
    MOVLW 250
    MOVWF contador2,0
loop_exter7:
    MOVLW 249
    MOVWF contador1,0
loop_inter7:
    NOP
    DECFSZ contador1,1,0
    GOTO loop_inter7
    DECFSZ contador2,1,0
    GOTO loop_exter7
    RETURN 
    
END resetVect
