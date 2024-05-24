section .text
global replnum

replnum:
    push ebp
    mov ebp, esp

    push esi

    mov eax, [ebp + 8]  ; source string
    mov cl, [ebp + 12]

    mov esi, eax

iterate:
    mov dl, [eax]
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl save

    cmp dl, '9'
    jg save

    mov [esi], cl
    inc esi

check_next:
    inc eax

    mov dl, [eax]
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl save

    cmp dl, '9'
    jg save

    jmp check_next

save:
    mov [esi], dl

next:
    inc esi
    inc eax
    jmp iterate

end:
    mov byte [esi], 0

    pop esi

    mov esp, ebp
    pop ebp
    ret