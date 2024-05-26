section .text
global reversepairs

reversepairs:
    push ebp            ; prologue
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]  ; ebx = source char pointer
    mov esi, ebx        ; esi = dst char pointer

iterate:
    mov dl, [ebx]       ; dl = current character
    cmp dl, 0
    jz end

    inc ebx

    mov cl, [ebx]       ; cl = next character
    cmp cl, 0
    jz store_second

store_first:            ; store the "i" char first
    mov [esi], cl
    inc esi

store_second:           ; store the "i+1" char next
    inc ebx
    mov [esi], dl
    inc esi

    cmp cl, 0
    jz end

    jmp iterate

end:
    mov byte [esi], 0  ; add the null terminator

    pop esi
    pop edi
    pop ebx

    mov esp, ebp
    pop ebp
    ret