section .text
global func

func:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    xor ecx, ecx

loop1:
    mov cl, [eax]
    cmp ecx, 0
    jz end
    add cl, 2
    mov [eax], cl
    inc eax
    jmp loop1

end:
    mov esp, ebp
    pop ebp
    ret