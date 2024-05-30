section .text
global removedigits

removedigits:
    push ebp            ; prologue
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]  ; ebx = pointer to the first string
    mov edx, [ebp + 12] ; edx = pointer do the second string

    mov esi, ebx        ; esi = pointer to the destination string

outer_loop:
    mov ch, [ebx]       ; ch = current character
    cmp ch, 0
    jz end

    cmp ch, '0'
    jl save_to_dst

    cmp ch, '9'
    jg save_to_dst

compare_loop_intro:
    mov edx, [ebp + 12]

compare_loop:
    mov cl, [edx]
    cmp cl, 0
    jz save_to_dst

    cmp cl, ch
    jne compare_loop_next

next:
    inc ebx
    jmp outer_loop

compare_loop_next:
    inc edx
    jmp compare_loop

save_to_dst:
    mov [esi], ch
    inc esi
    inc ebx

    jmp outer_loop

end:
    mov byte [esi], 0  ; add the null terminator

    pop esi
    pop edi
    pop ebx

    mov esp, ebp
    pop ebp
    ret