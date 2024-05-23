section .text
global func

func:
    push ebp            ; prologue
    mov ebp, esp

    push edi
    push esi

    mov eax, [ebp + 8]  ; eax = source char pointer
    mov ecx, [ebp + 12] ; ecx = frequency counter

    mov edi, eax        ; edi = dst char pointer
    mov esi, ecx        ; esi = copied frequency counter

iterate:
    mov dl, [eax]       ; dl = current character
    cmp dl, 0
    jz end

    dec esi
    jnz save

    inc eax             ; increment the source char pointer
    mov esi, ecx        ; reset the counter
    jmp iterate

save:
    mov [edi], dl       ; save the character
    inc edi             ; increment the dst char pointer
    inc eax             ; increment the source char pointer
    jmp iterate

end:
    mov byte [edi], 0  ; add the null terminator

    pop esi
    pop edi

    mov esp, ebp
    pop ebp
    ret