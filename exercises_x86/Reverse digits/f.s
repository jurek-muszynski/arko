section .text
global reversedigits

reversedigits:
    push ebp            ; prologue
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]  ; ebx = source char pointer
    mov esi, ebx        ; esi = dst char pointer

    mov edi, ebx        ; edi = pointer to the last digit
    xor eax, eax        ; eax = nums counter

find_last_digit:
    mov dl, [ebx]       ; dl = current character
    cmp dl, 0
    jz left_loop_intro

    cmp dl, '0'
    jl next

    cmp dl, '9'
    jg next

save_pointer:
    mov edi, ebx         ; edi = pointer to the last digit
    inc eax

next:
    inc ebx
    jmp find_last_digit

left_loop_intro:
    mov ebx, [ebp+8]

left_loop:
    mov dl, [ebx]
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl left_loop_next

    cmp dl, '9'
    jg left_loop_next

    jmp right_loop

left_loop_next:
    inc ebx
    jmp left_loop

right_loop:
    mov cl, [edi]
    cmp ebx, edi
    jge end

    cmp cl, '0'
    jl right_loop_next

    cmp cl, '9'
    jg right_loop_next

    jmp swap

right_loop_next:
    dec edi
    jmp right_loop

swap:
    mov [ebx], cl
    mov [edi], dl
    inc ebx
    dec edi
    jmp left_loop

end:
    add ebx, eax
    mov byte [ebx], 0  ; add the null terminator

    pop esi
    pop edi
    pop ebx

    mov esp, ebp
    pop ebp
    ret