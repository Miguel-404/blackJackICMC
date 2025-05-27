jmp main

telainicial1:
string "                BLACKJACK               "


string "                 I C M C                "




string "         W###  X###  Z###  Y###         "
string "         wx##  []##  @^##  <>##         "
string "         yz##  {}##  `~##  {}##         "
string "         ##wx  ##[]  ##@^  ##<>         "
string "         ##yz  ##{}  ##`~  ##{}         "
string "         ###W  ###X  ###Z  ###Y         "


string "       PRESSIONE ESPACO PARA JOGAR     "



telabet1:
string  "MOEDAS:                                 "
string  "               SUA APOSTA:              "
string  "             ______________             "
string  "            |              *            "
string  "            |      ---     *            "
string  "            |______________*            "







coins:
var #1
static coins + #0, #100
main:
call telainicial
    main_input:
        call input_     ;inchar r2
        loadn r1, #' '  ;tecla para mudar a tela
        cmp r2, r1
        ceq apagatela
        jne main_input
    loop:
        call aposta
       
        ;jmp loop
        load r0, coins
        loadn r1, #1000
        loadn r2, #0
        cmp r0, r1
        ;ceq tela_ganhou
        cmp r0, r2
        ;ceq tela_perdeu
        halt

input_:     ;retorna r2
push r1
push fr
    loadn r1, #255
    input_esperaTecla:
        inchar r2
        cmp r2, r1
        jeq input_esperaTecla
    input_esperaSoltar:
        inchar r1
        cmp r1, r2
        jeq input_esperaSoltar
pop fr
pop r1
rts

aposta: ;retorna r1
push fr
push r0 ;posicao do numero
push r2 
push r3 
push r4
    aposta_reset:
    call telabet
    loadn r0, #7
    load r1, coins
    call printnum
    loadn r4, #100    ; casa decimal
    loadn r1, #0
    loadn r0, #379    ;posicao na tela
    aposta_input:
        loadn r3, #1
        cmp r4, r3
        jle aposta_confirma
        call input_;=inchar r2
        loadn r3, #27   ;27=esc
        cmp r2, r3
        jeq aposta_reset
        loadn r3, #'9'
        cmp r2, r3
        jgr aposta_input
        loadn r3, #'0'
        cmp r2, r3
        jle aposta_input
    outchar r2, r0
    
    sub r2, r2, r3  ;r2=r2-'0'  ; converte o caracter para numero
    mul r2, r4, r2  ;r2=r2*casa decimal atual
    add r1, r1, r2  ;aposta=aposta+r2
    
    loadn r3, #10   ;
    div r4, r4, r3  ;proxima casa decimal
    
    inc r0

    loadn r3, #1
    cmp r4, r3
    jmp aposta_input
    
    aposta_confirma:
        inchar r2
        loadn r3, #27   ;27=esc
        cmp r2, r3
        jeq aposta_reset
        inchar r2
        loadn r3, #13   ;13=enter
        cmp r2, r3
        jne aposta_confirma
    load r0, coins
    cmp r1, r0
    jgr aposta_reset
    sub r1, r0, r1
    store coins, r1

    loadn r0, #7
    load r1, coins
    call printnum
call apagatela

loadn r0, #5
loadn r1, #0
call imprimecarta
loadn r0, #10
loadn r1, #0
call imprimecarta
loadn r0, #5
loadn r1, #20
call imprimecarta
loadn r0, #10
loadn r1, #20
call imprimecarta




pop r4
pop r3
pop r2
pop r0
pop fr
rts


printnum:
push r0 ; posição na tela
push r1 ; valor a ser imprisso
push r2 ; 
push r3
push r4
push r5
push r6
    loadn r2, #1000
    loadn r3, #10       ; para diminuir de 10 em 10
    loadn r4, #'0'
    loadn r6, #1        ; criterio de parada: unidades
    printnum_loop:
        mod r5, r1, r2  ; elimina casas decimais acima da atual
        div r2, r2, r3  ; reduz para a proxima casa decimal
        div r5, r5, r2  ; elimina casas de cimais abaixo da atual
        add r5, r5, r4  ; adiciona o codigo do caracter 0 para printar
        outchar r5, r0
        inc r0
        cmp r2,r6       ; se a casa decimal atual for a das unidades, para o loop
        jne printnum_loop
pop r6
pop r5
pop r4
pop r3
pop r2
pop r1
pop r0
rts

apagatela:
push r0
push r1
push r2
    loadn r0, #0
    loadn r1, #'\0'
    loadn r2, #1200
    apagatela_loop:
            outchar r1, r0
            inc r0
            cmp r0, r2
            jne apagatela_loop
pop r2
pop r1
pop r0
rts

imprimecarta:
push r0 ;coluna
push r1 ;linha
push r2
push r4
push r5
push r6
push r7
    loadn r2, #4 ;largstring
    loadn r5, #40
    mul r5, r1, r5
    add r6, r0, r5
    mov r7, r1
    imprimecarta_loop:
        loadn r5, #'#'
        outchar r5, r6
        inc r6

        loadn r5, #40
        mul r5, r7, r5
        add r5, r5, r2
        add r5, r5, r0
        cmp r6, r5
        jle imprimecarta_loop
        loadn r5, #4
        sub r6, r6, r5     ;pos-=4

        inc r7              ;linha++
        loadn r5, #40
        mul r5, r7, r5      ;r5=linha*40
        add r6, r0, r5      ;pos+=r5

        loadn r5, #6
        add r5, r1, r5
        cmp r7, r5
        jle imprimecarta_loop
pop r7
pop r6
pop r5
pop r4
pop r2
pop r1
pop r0
rts

telainicial:
push r0
push r1
push r2
    loadn r2, #40
    loadn r0, #4    ;numero da linha
    mul r0, r0, r2
    loadn r1, #telainicial1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #8    ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #16   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #17   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #18   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #19   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #20   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #21   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #25   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
pop r0
pop r1
pop r2
rts

telabet:
push r0
push r1
push r2
    loadn r2, #40
    loadn r0, #0    ;numero da linha
    mul r0, r0, r2
    loadn r1, #telabet1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #1    ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #7    ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #8    ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #9    ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r2, #40
    loadn r0, #10   ;numero da linha
    mul r0, r0, r2
    add r1, r1, r2
    inc r1
    loadn r2, #0    ;cor
    call ImprimeStr
pop r2
pop r1
pop r0
rts

ImprimeStr:
	push r0	; posição na tela
	push r1	; endereço da mensagem
	push r2	; cor da mensagem
	push r3
	push r4
	
	loadn r3, #'\0'	; Criterio de parada

    ImprimestrLoop:	
	    loadi r4, r1
	    cmp r4, r3
	    jeq ImprimestrSai
	    add r4, r2, r4
	    outchar r4, r0
	    inc r0
	    inc r1
	    jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
