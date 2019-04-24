;8001 CONTROL PORT
;8000 DATA PORT
CODE SEGMENT
ASSUME	CS:CODE
	ORG 3000H
K DB ?
V DB ?
index db 0
disindex db 85h
START:
      ;CONTROL WORD
      MOV DX,8001H
      MOV AL,0
      OUT DX,AL

      ;SCALE FACTOR
      MOV AL,32H
      OUT DX,AL

      ;CLEAR
      MOV AL,0DFH
      OUT DX,AL
      CALL DELAY

;CHECK IF BUTTON IS PRESSED
LP:
   MOV DX,8001H
   IN AL,DX
   AND AL,07H
   CMP AL,0
   JE LP

 START1:
 MOV DX,8000H
  IN AL,DX
  AND AL,03FH
  MOV K,AL
 
call  findindex
  MOV AL,index
  MOV BX,OFFSET DISPLAYY
  XLAT
  MOV V,AL
  MOV DX,8001H
  MOV AL,disindex
mov cl,disindex
dec cl
cmp cl,80h
je equal80
notequal80: jmp endxxx
equal80:mov cl,85h
endxxx:mov disindex,cl
  OUT DX,AL
  MOV DX,8000H
  MOV AL,V
  OUT DX,AL
  CALL DELAY
JMP LP

findindex:
MOV BX,OFFSET KEYV
mov al,index
xlat
cmp al,k
je xx
mov al,index
inc al
cmp al,10
je equal10
notequal10: jmp endxx
equal10:mov al,0
endxx:mov index,al
jmp findindex
xx:ret

DELAY:
PUSH CX
MOV CX,0ffh

X1:NOP
LOOP X1
POP CX
RET

KEYV: DB 09H,01H,11H,21H,08H,18H,28H,00H,10H,20H
DISPLAYY: DB 0CH,9FH,4AH,0BH,99H,29H,28H,8FH,08H,09H
END START
CODE ENDS