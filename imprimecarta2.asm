imprimecarta2:
push r0 ;coluna
push r1 ;linha
push r2
push r4
push r5
push r6
push r7
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
pop r7
pop r6
pop r5
pop r4
pop r2
pop r1
pop r0
rts
