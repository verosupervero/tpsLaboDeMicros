/*
 * titilarled.asm
 *
 *  Created: 09/05/2021 08:24:17 p.m.
 *   Author: Verónica
 */ 
;.INCLUDE "M32DEF.INC"

.equ BITOUT=2

;Configuro PD0 como salida
LDI R21, 0xFF
OUT DDRD, R21 


;Titilar
MAIN: SBI PORTD,BITOUT ;set bit PD0
	CALL DELAY
	CBI PORTD,BITOUT
	CALL DELAY
	CALL MAIN


;Delay de 1s (modificado)

DELAY:
	LDI R18, 42
	LDI R19, 255
	LDI R20, 255
LOOP:	dec R20
	brne LOOP
	dec R19
	brne LOOP
	dec R18
	brne LOOP
	RET