; pierwsza duza, druga mala, trzecia odwrót

section .text
global func


func:
    push ebp
    mov ebp, esp

    push ebx
    push esi

    mov ebx, [ebp + 8]      ; ebx = source ptr

    mov esi, ebx            ; esi = destination ptr

start:
    mov cl, [ebx]           ; cl = first char

first_intro:
    cmp cl, 0
    jz end

first:
    cmp cl, 'D'
    jle second_intro

    add cl, -32

second_intro:
    mov [esi], cl
    inc esi
    inc ebx
    mov cl, [ebx]

    cmp cl, 0
    jz end

second:
    cmp cl, 'a'
    jge store_second

    add cl, 32

store_second:
    mov [esi], cl
    inc esi
    inc ebx

third_fourth_intro_1:
    mov cl, [ebx]

    cmp cl, 0
    jz end

third_fourth:
    cmp cl, 'a'
    jl to_lower

    add cl, -32
    jmp store_third_fourth_1

to_lower:
    add cl, 32

store_third_fourth_1:
    mov [esi], cl
    inc esi
    inc ebx

third_fourth_intro_2:
    mov cl, [ebx]

    cmp cl, 0
    jz end

third_fourth_2:
    cmp cl, 'a'
    jl to_lower_2

    add cl, -32
    jmp store_third_fourth_2

to_lower_2:
    add cl, 32

store_third_fourth_2:
    mov [esi], cl
    inc esi
    inc ebx
    jmp start

end:
    mov byte [esi], 0

    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret