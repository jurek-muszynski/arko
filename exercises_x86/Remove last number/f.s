section .text
global removelastn

removelastn:
    push ebp            ; prologue
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]  ; ebx = source char pointer

    xor edi, edi        ; edi = pointer to the last digit
    xor eax, eax        ; eax = current length
    xor esi, esi        ; esi = length of the last number

find_last_number:
    mov dl, [ebx]       ; dl = current character
    cmp dl, 0
    jz save_to_dst_intro

    cmp dl, '0'
    jl next

    cmp dl, '9'
    jg next

save_pointer:
    mov edi, ebx         ; edi = pointer to the last digit
    inc eax
    inc ebx
    mov esi, eax
    jmp find_last_number

next:
    xor eax, eax
    inc ebx
    jmp find_last_number

save_to_dst_intro:
    mov eax, esi
    sub edi, eax          ; edi = pointer to the first digit of the last number
    inc edi
    mov ebx, [ebp+8]
    mov esi, ebx

save_to_dst_loop:
    mov dl, [ebx]
    cmp dl, 0
    jz end

    cmp ebx, edi
    jne save_to_dst

skip_number:
    inc ebx
    dec eax

    cmp eax, 0
    jg skip_number

    jmp save_to_dst_loop

save_to_dst:
    inc ebx
    mov [esi], dl
    inc esi
    jmp save_to_dst_loop

end:
    mov byte [esi], 0  ; add the null terminator

    pop esi
    pop edi
    pop ebx

    mov esp, ebp
    pop ebp
    ret