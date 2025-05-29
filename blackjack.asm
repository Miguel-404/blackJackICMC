jmp main

Msn1:
string "       QUER MAIS UMA CARTA? (S/N)       "

telajogo:
string "                 MESA:                  "
string "    ---$$$$$$$$(BLACKJACK)$$$$$$$$---   "
string "               PLAYER:                  "
steve:
string "                STEVE:                  "

strapaga:
string "                                        "

coins:
var #1
static coins +#0, #100

soma: var#1
soma_mesa: var#1
seed: var#1

main:
call telainicial
    loadn r1, #' '  ;tecla para mudar a tela
    loadn r3, #senha
    main_input:
        loadi r4, r3
        loadn r5, #'\n'
        cmp r5, r4
        ceq chickenJockey
        call input_
        cmp r2, r4
        inc r3
        jeq main_input
        loadn r3, #senha
        cmp r2, r1
        jne main_input
        call apagatela

    loop:
        call jogo
        
        ;jmp loop
        load r0, coins
        loadn r1, #1000
        cmp r0, r1
        ;ceq tela_ganhou
        loadn r1, #0
        cmp r0, r1
        ;ceq tela_perdeu
        halt


input_:     ;retorna r2
push r1
push r7
push fr
    loadn r1, #255
    loadn r7, #1
    input_esperaTecla:
        inchar r2
        inc r7
        store seed, r7
        cmp r2, r1
        jeq input_esperaTecla
    input_esperaSoltar:
        inchar r1
        cmp r1, r2
        jeq input_esperaSoltar
pop fr
pop r7
pop r1
rts

valoraposta: var #1
jogo:
 push fr
 push r0 ;posicao do numero
 push r1
 push r2 
 push r3 
 push r4
 aposta:
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
        jeq aposta
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
    store valoraposta, r1
    
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
        jeq aposta
        inchar r2
        loadn r3, #13   ;13=enter
        cmp r2, r3
        jne aposta_confirma
    load r0, coins
    cmp r1, r0
    jgr aposta
    sub r1, r0, r1
    store coins, r1

 ;tela
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

 ;cartas iniciais
    load r1, soma_mesa
    call random_num         ;retorna r3
    add r1, r3, r1
    store soma_mesa, r1
    loadn r0, #63
    call printnum
    loadn r0, #5
    loadn r1, #4
    call imprimecarta

    loadn r4, #0
    load r1, soma
    call random_num         ;retorna r3
    add r1, r3, r1
    store soma, r1
    loadn r0, #1143
    call printnum
    loadn r0, #5
    loadn r1, #20
    call imprimecarta
    inc r4

    load r1, soma
    call random_num         ;retorna r3
    add r1, r3, r1
    store soma, r1
    loadn r0, #1143
    call printnum
    loadn r0, #10
    loadn r1, #20
    call imprimecarta
    inc r4


 loadn r2, #40
 loadn r0, #17
 mul r0, r0, r2
 loadn r1, #Msn1
 loadn r2, #0
 call ImprimeStr

 loadn r0, #10
 jmp maisCarta_pergunta

 maiscarta:
    load r1, soma
    call random_num   ;retorna r3
    add r1, r3, r1
    store soma, r1
    push r0 ;preserva a posicao da carta
    loadn r0, #1143
    call printnum
    pop r0  ;volta com a posicao da carta

    loadn r2, #5
    add r0, r0, r2
    loadn r1, #20
    call imprimecarta
    inc r4

    loadn r2, #5    ;maximo de cartas
    cmp r4, r2
    jeg maiscarta_end
    loadn r2, #21
    load r1, soma
    cmp r1, r2
    jeg maiscarta_end

    maisCarta_pergunta:
        call input_;retorna r2
        loadn r1, #'s'
        cmp r2, r1
        jeq maiscarta
        loadn r1, #'n'
        cmp r2, r1
        jne maisCarta_pergunta

    maiscarta_end:
        loadn r2, #40
        loadn r0, #17
        mul r0, r0, r2
        loadn r1, #strapaga
        loadn r2, #0
        call ImprimeStr
           
        loadn r2, #21
        load r1, soma
        cmp r1, r2
        jeg round_fim

 loadn r0, #5
 loadn r4, #1
 gameplay_mesa:
        call delay

        load r1, soma_mesa
        call random_num
        add r1, r1, r3
        store soma_mesa, r1
        push r0
        loadn r0, #63
        call printnum
        pop r0
        loadn r2, #5
        loadn r1, #4
        add r0, r0, r2
        call imprimecarta
        inc r4

        load r1, soma_mesa
        loadn r2, #15
        cmp r1, r2
        jle gameplay_mesa
        round_fim:
pop r4
pop r3
pop r2
pop r1
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


random_num:
 push r1
 push r2
 push r0
 push r4  
 push r6
    load r3, seed
    loadn r1, #17
    loadn r0, #43
    loadn r4, #256
    loadn r6, #11
    mov r2, r3
    mul r2, r2, r1
    add r2, r2, r0
    mod r2, r2, r4
    store seed, r2
    mod r2, r2, r6
    inc r2
    mov r3, r2
pop r6
pop r4
pop r0
pop r2
pop r1
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
 push r3
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
pop r3
pop r2
pop r1
pop r0
rts

valores: string "A234567891JQK"
naipes:  string "<>{}@^`~[]{}wxyz"
viracarta:
 push r0    ;pos
 push r1
 push r2    ;naipe
 push r3    ;val
 push r4
    loadn r1, #valores
    dec r1
    add r1, r1, r3
    loadi r1, r1
    outchar r1, r0
    loadn r4, #'1'
    cmp r1, r4
    jne viracarta_naipe
    inc r0
    loadn r4, #'0'
    outchar r4, r0
    dec r0

    viracarta_naipe:
    ;naipe 1
    loadn r4, #40
    add r0, r0, r4 ;pula linha
    load r1, naipes
    dec r1
    add r1, r1, r2
    loadi r1, r1
    
    outchar r1, r0

    inc r0
    inc r1
    outchar r1, r0

    loadn r4, #40
    add r0, r0, r4  ;pula linha

    dec r0
    inc r1
    outchar r1, r0

    inc r0
    inc r1
    outchar r1, r0

    ;naipe 2
    inc r0
    loadn r4, #40
    add r0, r0, r4  ;pula linha
    load r1, naipes
    dec r1
    add r1, r1, r2
    loadi r1, r1

    outchar r1, r0

    inc r0
    inc r1
    outchar r1, r0

    loadn r4, #40
    add r0, r0, r4  ;pula linha

    dec r0
    inc r1
    outchar r1, r0

    inc r0
    inc r1
    outchar r1, r0

    viracarta_fundo:
    loadn r4, #40
    add r0, r0, r4  ;pula linha

    loadn r1, #valores
    dec r1
    add r1, r1, r3
    loadi r1, r1

    outchar r1, r0

    loadn r4, #'1'
    cmp r1, r4
    jne viracarta_fim
    dec r0

    loadn r4, #'1'
    outchar r4, r0
    inc r0
    loadn r4, #'0'
    outchar r4, r0
    viracarta_fim:
pop r4
pop r3
pop r2
pop r1
pop r0
rts

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


senha: string "iamsteve"
chickenJockey:
 push r0
 push r1
 push r2
 push r3
 push r4
    loadn r2, #40
    loadn r0, #4    ;numero da linha
    mul r0, r0, r2
    loadn r2, #16
    add r0, r0, r2
    loadn r1, #jackblack
    loadn r2, #0    ;cor
    call ImprimeStr
    loadn r1, #telajogo
    loadn r2, #82
    add r1, r1, r2
    loadn r2, #steve
    loadn r4, #'\0'
    chickenJockey_loop:
        loadi r3, r2
        storei r1, r3
        inc r1
        inc r2
        cmp r3, r4
        jne chickenJockey_loop
pop r4
pop r3
pop r2
pop r1
pop r0
rts
craftmine:
string "        ================                "
string "        ================                "
string "        ==##  ====  ##==                "
string "        ==##  ====  ##==                "
string "        ======@@@@======                "
string "        ======@@@@======                "
string "        ====  &&&&  ====                "
string "        ====  &&&&  ====                "
string "        ====        ====                "
string "        ====        ====                "
string "        ================                "
string "        ================                "
jackblack: string      "JACKBLACK "
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
