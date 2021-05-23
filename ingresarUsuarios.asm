;
;
;        Objective:
;            Input:
;           Output:
%include "io.mac"

Players       EQU   4

.DATA
msgGetUser    db 'Ingrese el nombre de los jugadores, ingresa 0 para dejar de ingresar jugadores, ',0
msgGetUser2   db ' jugadores ingresados, maximo cuatro caracteres para el nombre: ',0
errorVar      db 'ERROR--ERROR--ERROR',0
name          db 'GARMF',0
lf            dw 0Ah
numPlayers    db 0
numVar        db 0


.UDATA
arrayPNam     resd Players
arrayPPoints  resb Players


.CODE
%macro ingresarUsuario 1
  %%pedirDatos:
    xor     EAX,EAX
    PutStr	msgGetUser
  	mov     [numVar], BX
  	PutInt	[numVar]
  	PutStr	msgGetUser2
    GetStr  name,5
    PutStr  lf
    mov     EAX,[name]
    cmp     EAX,'****'
  	je			%%continuar
    mov     [arrayPNam+ESI*4],EAX
    inc     ESI
    dec     BX
  	cmp			BX,0
  	je			%%continuar
    jmp     %%pedirDatos

  %%continuar:
  	mov		[numPlayers],ESI
%endmacro

  .STARTUP
		xor     ESI,ESI
		xor			EAX,EAX
    xor     BX,BX
    mov     BX,4
    ingresarUsuario ESI

    xor ESI,ESI

    imprimir:
      cmp			ESI,[numPlayers]
      je      fin
      mov    	EAX,[arrayPNam+ESI*4]
      mov			[name],EAX
      PutStr	name
      PutStr	lf
      inc     ESI
      jmp			imprimir


    fin:
      .EXIT
; -----------------------------------------------------
