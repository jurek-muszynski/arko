section .text
global leavelastndigt

leavelastndigt:
    push ebp            ; prologue
    mov ebp, esp

    push edi
    push esi

    mov eax, [ebp + 8]  ; eax = source char pointer
    mov ecx, [ebp + 12] ; ecx = num of chars to remove

    mov edi, eax        ; edi = dst char pointer
    xor esi, esi        ; esi = counter

find_dgts:
    mov dl, [eax]       ; dl = current character
    cmp dl, 0
    jz pre_iterate

    cmp dl, 48          ; if dl < '0'
    jl next_char

    cmp dl, 57          ; if dl > '9'
    jg next_char

    inc esi             ; increment the counter

next_char:
    inc eax             ; increment the source char pointer
    jmp find_dgts

pre_iterate:
    mov eax, [ebp + 8]  ; eax = source char pointer
    mov edi, eax

iterate:
    mov dl, [eax]       ; dl = current character
    cmp dl, 0
    jz end

    cmp dl, 48          ; if dl < '0'
    jl next_char2

    cmp dl, 57          ; if dl > '9'
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