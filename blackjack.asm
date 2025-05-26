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
string  "            |              |            "
string  "            |      ---     |            "
string  "            |______________|            "

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
        call telabet
        loadn r0, #7
        load r1, coins
        call printnum

        loadn r0, #379
        call aposta
        load r0, coins
        sub r1, r0, r1
        store coins, r1

        loadn r0, #7
        ;load r1, coins
        call printnum

        jmp loop
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
    loadn r4, #100    ; casa decimal
    loadn r1, #0      ; valor da aposta
    aposta_input:
        loadn r3, #1
        cmp r4, r3
        jle aposta_confirma
        call input_;=inchar r2
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
        loadn r3, #13   ;13=enter
        cmp r2, r3
        jne aposta_confirma
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

telainicial:
push r0
push r1
push r2
    loadn r0, #160
    loadn r1, #telainicial1
    loadn r2, #0
    call ImprimeStr
    loadn r0, #320
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #640
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #680
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #720
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #760
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #800
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #840
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #1000
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
pop r0
pop r1
pop r2
rts

telabet:
push r0
push r1
push r2
    loadn r0, #0
    loadn r1, #telabet1
    loadn r2, #0
    call ImprimeStr
    loadn r0, #160
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #280
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #320
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #360
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r0, #400
    loadn r2, #41
    add r1, r1, r2
    loadn r2, #0
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
