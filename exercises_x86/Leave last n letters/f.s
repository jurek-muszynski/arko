section .text
global leavelastnletters

leavelastnletters:
    push ebp            ; prologue
    mov ebp, esp

    push edi
    push esi

    mov eax, [ebp + 8]  ; eax = source char pointer
    mov ecx, [ebp + 12] ; ecx = num of chars to remove

    mov edi, eax        ; edi = dst char pointer
    xor esi, esi        ; esi = counter

check_upper:
    mov dl, [eax]       ; dl = current character
    cmp dl, 0
    jz pre_iterate

    cmp dl, 'A'
    jl next_char

    cmp dl, 'Z'
    jg check_lower

    inc esi             ; increment the counter

    jmp next_char

check_lower:
    cmp dl, 'a'
    jl next_char

    cmp dl, 'z'
    jg next_char

    inc esi             ; increment the counter

next_char:
    inc eax             ; increment the source char pointer
    jmp check_upper

pre_iterate:
    mov eax, [ebp + 8]  ; eax = source char pointer
    mov edi, eax

iterate:
    mov dl, [eax]       ; dl = current character
    cmp dl, 0
    jz end

    cmp dl, 'A'
    jl next_char2

    cmp dl, 'Z'
    jg check_lower_2

    dec esi

    cmp esi, ecx        ; if esi == ecx
    jge next_char2

    jmp save_char

check_lower_2:
    cmp dl, 'a'
    jl next_char2

    cmp dl, 'z'
    jg next_char2

    dec esi

    cmp esi, ecx        ; if esi == ecx
    jge next_char2

save_char:
    mov [edi], dl       ; save the character
    inc edi             ; increment the destination char pointer

next_char2:
    inc eax
    jmp iterate

end:
    mov byte [edi], 0

    pop esi
    pop edi

    mov esp, ebp
    pop ebp
    ret