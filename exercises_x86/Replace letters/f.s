section .text
global repllet

repllet:
    push ebp
    mov ebp, esp

    push esi

    mov eax, [ebp + 8]  ; source string
    mov cl, [ebp + 12]  ; replacing char

    mov esi, eax        ; dst char pointer

check_upper:            ; check if is upper
    mov dl, [eax]
    cmp dl, 0
    jz end

    cmp dl, 'A'
    jl save             ; < 'A' => not a letter

    cmp dl, 'Z'
    jg check_lower      ; if > 'Z', check if is lower

    mov [esi], cl       ; otherwise, save the chosen char to the dst buff
    inc esi
    jmp check_next_upper

check_lower:
    cmp dl, 'a'
    jl save             ; < 'a' => not a letter

    cmp dl, 'z'         ; > 'z' => not a letter
    jg save

    mov [esi], cl       ; otherwise, save the chosen char to the dst buff
    inc esi
    jmp check_next_upper

check_next_upper:       ; check if next chars form a sequence of letters
    inc eax

    mov dl, [eax]
    cmp dl, 0
    jz end

    cmp dl, 'A'
    jl save

    cmp dl, 'Z'
    jg check_next_lower

    mov [esi], cl
    inc esi
    jmp check_next_upper

check_next_lower:
    cmp dl, 'a'
    jl save

    cmp dl, 'z'
    jg save

    mov [esi], cl
    inc esi
    jmp check_next_upper

save:                   ; save the current char to the result buff
    mov [esi], dl

next:
    inc esi
    inc eax
    jmp check_upper

end:
    mov byte [esi], 0

    pop esi

    mov esp, ebp
    pop ebp
    ret