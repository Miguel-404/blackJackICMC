jmp main

telajogo:
string "                  MESA:                 "
string "    ---$$$$$$$$(BLACKJACK)$$$$$$$$---   "
string "                 PLAYER:                "

Msn1:
string "       QUER MAIS UMA CARTA? (s/n)       "


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

loadn r2, #40
loadn r0, #1
mul r0, r0, r2
loadn r1, #telajogo
loadn r2, #0
call ImprimeStr
loadn r2, #40
loadn r0, #15
mul r0, r0, r2
add r1, r1, r2
inc r1
loadn r2, #0
call ImprimeStr
loadn r2, #40
loadn r0, #28
mul r0, r0, r2
add r1, r1, r2
inc r1
loadn r2, #0
call ImprimeStr

loadn r0, #5
loadn r1, #4
call imprimecarta
loadn r0, #10
loadn r1, #4
call imprimecarta
loadn r0, #5
loadn r1, #20
call imprimecarta
loadn r0, #10
loadn r1, #20
call imprimecarta

loadn r2, #40
loadn r0, #17
mul r0, r0, r2
loadn r1, #Msn1
loadn r2, #0
call ImprimeStr
maiscarta3:
    inchar r3
    loadn r4, #'n'
    cmp r3, r4
    ;jeq end
    cmp r3, r5
    loadn r5, #'s'
    loadn r0, #15
    loadn r1, #20
    ceq imprimecarta
    jne maiscarta3
maiscarta4:    
    call delay
    maiscarta4_loop:
        inchar r3
        loadn r4, #'n'
        cmp r3, r4
        ;jeq end
        loadn r5, #'s'
        loadn r0, #20
        loadn r1, #20
        cmp r3, r5
        ceq imprimecarta
        jne maiscarta4_loop
maiscarta5:
    call delay
        maiscarta5_loop:
        inchar r3
        loadn r4, #'n'
        cmp r3, r4
        ;jeq end
        loadn r5, #'s'
        loadn r0, #25
        loadn r1, #20
        cmp r3, r5
        ceq imprimecarta
        jne maiscarta5_loop

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
carta:
string "####"
string "####"
string "####"
string "####"
string "####"
string "####"
imprimecarta:
push r0 ;coluna
push r1 ;linha
push r2
    loadn r2, #40
    mul r2, r1, r2    ; comeco da linha
    add r0, r0, r2    ; comeco da linha+coluna
    loadn r1, #carta
    loadn r2, #0
    call ImprimeStr
    loadn r2, #40
    add r0, r0, r2
    loadn r2, #5
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r2, #40
    add r0, r0, r2
    loadn r2, #5
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r2, #40
    add r0, r0, r2
    loadn r2, #5
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r2, #40
    add r0, r0, r2
    loadn r2, #5
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
    loadn r2, #40
    add r0, r0, r2
    loadn r2, #5
    add r1, r1, r2
    loadn r2, #0
    call ImprimeStr
pop r2
pop r1
pop r0
rts
valore: string "A23456789:JQK"
imprimeval:
push r0
push r1
push r2
    loadn r2, #4
    add r0, r0, r2
    loadn r2, #'#'
    outchar r2, r0
    dec r0
    outchar r2, r0
    dec r0
    dec r0
    loadn r1, #valores
    dec r1
    add r1, r1, r2
    loadi r1, r1
    outchar r1, r0
    loadn r2, #':'
    cmp r1, r2
    jne imprimeval_
    call printnum
    imprimeval_
    inc r0
    print #
pop r2
pop r1
pop r0

delay:
    push r0
    push r1
    loadn r0, #64000
    loadn r1, #0
        delay_loop:
        inc r1
        cmp r1, r0
        jne delay_loop
    pop r1
    pop r0
    rts




telainicial1:
string "                BLACKJACK               "
;SPLASH:
string "         CASSINO 100% LEGALIZADO        "

string "         A###  J###  Q###  K###         "
string "         wx##  []##  @^##  <>##         "
string "         yz##  {}##  `~##  {}##         "
string "         ##wx  ##[]  ##@^  ##<>         "
string "         ##yz  ##{}  ##`~  ##{}         "
string "         ###A  ###J  ###Q  ###K         "

string "       PRESSIONE ESPACO PARA JOGAR      "
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
telabet1:
string  "MOEDAS:                                 "
string  "               SUA APOSTA:              "
string  "             ______________             "
string  "            |              *            "
string  "            |      ---     *            "
string  "            |______________*            "
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
