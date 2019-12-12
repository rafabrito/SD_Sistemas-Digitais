run_position1: .word 0x0c, 0x0c, 0x0, 0x0e, 0x1c, 0x0c, 0x1a, 0x13 # o vetor1[12,12,0,14,28,12,26,19]

run_position2: .word 0x0c, 0x0c, 0x0, 0x0c, 0x0c, 0x0c, 0x0c, 0x0e # o vetor2[12,12,0,12,12,12,12,14]

jump1: .word 0x0c, 0x0c, 0x0, 0x1e, 0x0d, 0x1f, 0x10, 0x0 # o vetor3[12,12,0,30,13,31,16,0]

jump2: .word 0x1e, 0x0d, 0x1f, 0x10, 0x0, 0x0, 0x0, 0x0 # o vetor4[30,13,31,16,0,0,0,0]

ground: .word 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f # o vetor5[31,31,31,31,31,31,31]

ground_right: .word 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3 # o vetor6[3,3,3,3,3,3,3,3]

ground_left: .word 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18 # o vetor7[24,24,24,24,24,24,24,24]

.equ indice, 8

.equ button, 0x2010

.text

.global main

.macro inst db
	custom 0, r0, r0, \db
.endm

.macro dado db	
	movi r1, 1
	custom 0, r0, r1, \db
.endm

.macro read db # macro para definir a leitura direta na CGRAM
	movi r1, 1
	custom 0, r1, r1, \db
.endm


#Inicializa o LCD
main:

    movia r3, button
    movia r5, 1

# Rotina de inicialização do display LCD
	movi r2, 0x38
	inst r2
	
	movi r2, 0x0c
	inst r2
	
	movi r2, 0x6
	inst r2
	
	movi r2, 0x1
	inst r2

#-----------------------------------------


	movia r2, 1

switch:
 	movia r8, indice
 	
 	addi r6, zero, 1
 	beq r2, r6, char1
	
 	addi r6, r6, 1
 	beq r2, r6, char2
	
	addi r6, r6, 1
 	beq r2, r6, char3
	
	addi r6, r6, 1
 	beq r2, r6, char4
	
	addi r6, r6, 1
 	beq r2, r6, char5
	
	addi r6, r6, 1
 	beq r2, r6, char6
	
	addi r6, r6, 1
 	beq r2, r6, char7
	
 	movi r8, 2

 	movi r2, 0x1 # Limpar display
	inst r2

 	br loop_jogo


loop:
 	beq zero, r8, switch
 	ldw r9, 0(r7)   #lê o valor do vetor
 	dado r9        #envia elemento do vetor que representa o char
 	addi r7, r7, 4  #modifica  posição do vetor
 	subi r8, r8, 1  #incrementa o indice
 	br loop

char1:
 	addi r2, r2, 1
 	movia r7, run_position1 # r7 recebe o endereço do vetor
 	movi r10, 0x40   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM 
 	br loop

char2:
 	addi r2, r2, 1
 	movia r7, run_position2 # r7 recebe o endereço do vetor
 	movi r10, 0x48   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM 
 	br loop

char3:
 	addi r2, r2, 1
 	movia r7, jump1 # r7 recebe o endereço do vetor
 	movi r10, 0x50   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM
 	br loop
	
char4:
 	addi r2, r2, 1
 	movia r7, jump2
 	movi r10, 0x58   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM
 	br loop

char5:
 	addi r2, r2, 1
 	movia r7, ground
 	movi r10, 0x60   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM
 	br loop

char6:
 	addi r2, r2, 1
 	movia r7, ground_right
 	movi r10, 0x68   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM
 	br loop

char7:
 	addi r2, r2, 1
 	movia r7, ground_left
 	movi r10, 0x70   # endereço inicial da CGRAM
 	inst r10        # irá habilitar a gravação na CGRAM
 	br loop


antibouncing:
    ldbio r10, 0(r3)
    addi r6, r0, 15
    call mensagem
    bne r10, r6, antibouncing

movi r8, 2
movi r9, 0
movia r9, 9999

loop_jogo: beq zero ,r9, end

exibir_char:

	movi r5, 1

switch_personagem:
	movi r2, 0x1 # Limpar display
	inst r2

	movi r2, 0x1c #desloca cursor para direita
	inst, r2

	movi r2, 0xc0 #desloca cursor para segunda linha
	inst, r2

	
	addi r6, zero, 1
	beq r5, r6, run1
	
	addi r6, r6, 1
	beq r5, r6, run2
	
	br loop_jogo
	
run1:
	movia r7, 0
	dado r7		#caso não dê certo mudar para macro de dado
	read r5, r5, 1
	call delay
	br switch_personagem
run2:
	movia r7, 1
	read r7		#caso não dê certo mudar para macro de dado
	addi r5, r5, 1
	call delay
	br switch_personagem

jump:
	movi r7, 2
	read r7		#caso não dê certo mudar para macro de dado
	addi r5, r5, 1
	br switch_personagem


mensagem:
	movi r2, 0x1 # Limpar display
	inst r2
    movi r2, 0x50 #P
 	dado r2
    movi r2, 0x72 #r
 	dado r2
   	movi r2, 0x65 #e
 	dado r2
	movi r2, 0x73 #s
 	dado r2
   	movi r2, 0x73 #s
 	dado r2
    movi r2, 0x20 ##[SPACE]
 	dado r2
    movi r2, 0x53 #S
 	dado r2
	movi r2, 0x74 #t
 	dado r2
    movi r2, 0x61 #a
 	dado r2
 	movi r2, 0x72 #r
 	dado r2
 	movi r2, 0x74 #t
 	dado r2
 	ret

br loop_jogo


	 
# delay:      movia r10, 25000000 #delay de (2 + 2 x 25000000 + 1) x 20ns = 1s (tempo de cada instrução =  1/frequencia => 20ns) 
# wasteTime:  subi  r10,r10, 1
#             bne   r10, r0, wasteTime
#             ret

end: