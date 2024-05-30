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
    xor eax, eax

start:
    mov cl, [ebx]           ; cl = first char
    inc ebx
    mov al, [ebx]
    inc ebx
    mov dl, [ebx]
    inc ebx
    mov bl, [ebx]

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

    cmp al, 0
    jz end

second:
    cmp al, 'a'
    jge store_second

    add al, 32

store_second:
    mov [esi], al
    inc esi

third_fourth_intro_1:
    cmp dl, 0
    jz end

third_fourth:
    cmp dl, 'a'
    jl to_lower

    add dl, -32
    jmp store_third_fourth_1

to_lower:
    add dl, 32

store_third_fourth_1:
    mov [esi], dl
    inc esi

    inc eax

third_fourth_intro_2:
    cmp bl, 0
    jz end

third_fourth_2:
    cmp bl, 'a'
    jl to_lower_2

    add bl, -32
    jmp store_third_fourth_2

to_lower_2:
    add bl, 32

store_third_fourth_2:
    mov [esi], bl
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