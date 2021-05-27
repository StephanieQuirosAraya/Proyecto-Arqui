;
;
;        Objective:
;            Input:
;           Output:
%include "io.mac"

.DATA
preguntas       db 'En Jurassic Park confunden Puntarenas con San Jose|Cual de las siguientes personas fue un dictador en Costa Rica?|En que año se finalizo el estadio nacional?|',0
impCaracter     db ' ',0
pruebas         db 'Puta    |   ',0
preguntasUsadas db 0,0,0,0
pregCorrecta    dw 0
numPreg         db 0


.UDATA

.CODE
  .STARTUP
  call RecorrerPreguntas

  fin:
    .EXIT

RecorrerPreguntas:
  pregRandom:
    sub CL, CL
    mov CL, [numPreg]
    inc CL
    mov [numPreg], CL
    sub CL, CL
    sub ESI,ESI
    mov CL, 1
    mov ESI,[preguntasUsadas]

  loopVerificaP:
    mov AL, [preguntasUsadas+ESI]
    cmp AL,0
    je  BuscarPreg
    cmp AL,CL
    je  pregRandom
    inc ESI
    jmp loopVerificaP

  BuscarPreg:
    mov [preguntasUsadas+ESI],CL
    sub ESI,ESI
    sub BL,BL
    mov BL,1


  loopPreguntas:
    cmp CL,0
    je imprimirPreg
    mov AL, [preguntas+ESI]
    cmp AL,'|'
    je  verificarPreg
    inc ESI
    jmp loopPreguntas

  verificarPreg:
    inc ESI
    cmp BL,CL
    je  imprimirPreg
    inc BL
    jmp loopPreguntas

  imprimirPreg:
    mov AL, [preguntas+ESI]
    cmp AL,'|'
    je  final
    mov [impCaracter],AL
    PutCh AL
    inc  ESI
    jmp imprimirPreg

  final:
    nwln
    ret
