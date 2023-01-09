PSECT udata_acs
Contador1: DS 1 ;reserva 1 byte
Contador2: DS 1
; @date: 09/01/23
; @author: Garcia Cordova Mauro Aldair     
; IDE: MPLAB X IDE v6.00
;Codigo implementado para una frecuencia del oscilador de 4MHz
;Este código va a implementar retardos en us y ms
PSECT CODE

delay_25us:
    MOVLW   6		    ; 1Tcy --- M
    MOVWF   Contador1,0 
Int1_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    Int1_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
delay_10us:
    MOVLW   1		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int2_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int2_LOOP	    ; (k-1)*2Tcy
    RETURN	
delay_50us:
    MOVLW   15		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int3_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int3_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
delay_100us:
    MOVLW   31		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int4_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int4_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
delay_200us:
    MOVLW   65		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int5_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int5_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
delay_250us:
    MOVLW   81		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int6_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int6_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
delay_500us:
    MOVLW   165		    ; 1Tcy --- M
    MOVWF   Contador1,0 
int7_LOOP:			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int7_LOOP	    ; (k-1)*2Tcy
    RETURN		    ; 2Tcy
;PARA MS
delay_5ms:
    MOVLW   5
    MOVWF   Contador2,0 
ext9a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int9b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int9b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext9a_LOOP
    RETURN		    ; 2Tcy
delay_1ms:
    MOVLW   1		    ; 1Tcy --- M
    MOVWF   Contador2,0 
ext8a_LOOP:		    ; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250		    ; 1Tcy --- N
    MOVWF   Contador1,0	    ; 1Tcy
int8b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int8b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext8a_LOOP
    RETURN		    ; 2Tcy

delay_25ms:  
    MOVLW   25
    MOVWF   Contador2,0 
ext11a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int11b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int11b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext11a_LOOP
    RETURN		    ; 2Tcy
delay_10ms:
    MOVLW   10
    MOVWF   Contador2,0 
ext10a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int10b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int10b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext10a_LOOP
    RETURN		    ; 2Tcy
    
delay_100ms:  
    MOVLW   25
    MOVWF   Contador2,0 
ext13a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int13b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int13b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext13a_LOOP
    RETURN		    ; 2Tcy
delay_50ms:  
    MOVLW   50
    MOVWF   Contador2,0 
ext12a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int12b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int12b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext12a_LOOP
    RETURN		    ; 2Tcy
delay_250ms:  
    MOVLW   25
    MOVWF   Contador2,0 
ext15a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int15b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int15b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext15a_LOOP
    RETURN		    ; 2Tcy
delay_200ms:  
    MOVLW   25
    MOVWF   Contador2,0 
ext14a_LOOP:		; 2Tcy -- Call (el call utiliza 2tcy)
    MOVLW   250	; 1Tcy
    MOVWF   Contador1,0	; 1Tcy
int14b_LOOP:
    NOP			    ;k*Tcy
    DECFSZ  Contador1,1,0   ;(k-1)+ 3Tcy
    GOTO    int14b_LOOP	    ; (k-1)*2Tcy
    DECFSZ  Contador2,1,0
    GOTO    ext14a_LOOP
    RETURN		    ; 2Tcy


