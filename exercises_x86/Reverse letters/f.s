section .text
global reverseletters

reverseletters:
    push ebp            ; prologue
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]  ; ebx = source char pointer
    mov esi, ebx        ; esi = dst char pointer

    mov edi, ebx        ; edi = pointer to the last letter
    xor eax, eax        ; eax = nums counter

find_last_letter_uppercase:
    mov dl, [ebx]       ; dl = current character
    cmp dl, 0
    jz left_loop_intro

    cmp dl, 'A'
    jl next

    cmp dl, 'Z'
    jg find_last_letter_lowercase

    jmp save_pointer

find_last_letter_lowercase:
    cmp dl, 'a'
    jl next

    cmp dl, 'z'
    jg next

save_pointer:
    mov edi, ebx         ; edi = pointer to the last letter
    inc eax

next:
    inc ebx
    jmp find_last_letter_uppercase

left_loop_intro:
    mov ebx, [ebp+8]

left_loop_uppercase:
    mov dl, [ebx]
    cmp dl, 0
    jz end

    cmp dl, 'A'
    jl left_loop_next

    cmp dl, 'Z'
    jg left_loop_lowercase

    jmp right_loop_uppercase

left_loop_lowercase:
    cmp dl, 'a'
    jl left_loop_next

    cmp dl, 'z'
    jg left_loop_next

    jmp right_loop_uppercase

left_loop_next:
    inc ebx
    jmp left_loop_uppercase

right_loop_uppercase:
    mov cl, [edi]
    cmp ebx, edi
    jge end

    cmp cl, 'A'
    jl right_loop_next

    cmp cl, 'Z'
    jg right_loop_lowercase

    jmp swap

right_loop_lowercase:
    cmp cl, 'a'
    jl right_loop_next

    cmp cl, 'z'
    jg right_loop_next

    jmp swap

right_loop_next:
    dec edi
    jmp right_loop_uppercase

swap:
    mov [ebx], cl
    mov [edi], dl
    inc ebx
    dec edi
    jmp left_loop_uppercase

end:
    add ebx, eax
    mov byte [ebx], 0  ; add the null terminator

    pop esi
    pop edi
    pop ebx

    mov esp, ebp
    pop ebp
    ret