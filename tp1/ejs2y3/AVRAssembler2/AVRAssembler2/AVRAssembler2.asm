/*
 * AVRAssembler2.asm
 *
 *  Created: 11/05/2021 01:09:14 p.m.
 *   Author: Verónica
 */ 


  /*flipflop.asm
 *
 *  Created: 09/05/2021 09:19:57 p.m.
 *   Author: Verónica
 */

.equ LEDPIN=2
.equ SETPIN=7
.equ RESETPIN=6
.equ USE_PULLUP=1 ;1 es para usar resistores internos

;Configuro el puerto donde esta el led como salida
LDI R21, (1<<LEDPIN)
OUT DDRD, R21 

.if USE_PULLUP==1
	;Configuro los puertos de entrada (set y reset) con R-pullup
	LDI R21, (1<<SETPIN) | (1<<RESETPIN)
	OUT PORTD, R21 
.endif

RST: CBI PORTD, LEDPIN

WAIT: ;Espera a que aprete SET para arrancar
	IN R23,PIND
	ANDI R23,(1<<SETPIN) ; Z=1 si se pulsa set
	BRNE WAIT ;Loop infinito hasta apretar SET
	;Aprete SET, sigo...

INIT:
	LDI R18, 42 ; Seteo contador
	LDI R19, 255
	LDI R20, 255
	; Conmuto el estado del LED
	IN R16, PORTD
	LDI R21, (1<<LEDPIN) ;Mascara para invertir el led
	EOR R16, R21
	OUT PORTD, R16

LOOP: IN R23,PIND
	ANDI R23,(1<<RESETPIN) ; Z=1 si se pulsa reset
	BREQ RST
	dec R20
	brne LOOP
	dec R19
	brne LOOP
	dec R18
	brne LOOP
	RJMP INIT

