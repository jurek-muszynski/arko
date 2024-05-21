section .text
global func

func:
    push ebp
    mov ebp, esp

    push ebx
    push esi

    mov edx, [ebp + 8]
    mov eax, [ebp + 12]
    mov ebx, [ebp + 16]

    mov esi, edx

start:
    mov cl, [edx]
    cmp cl, 0
    jz end

    cmp cl, al
    jl save

    cmp cl, bl
    jle next

save:
    mov [esi], cl
    inc esi

next:
    inc edx
    jmp start

end:
    mov byte [esi], 0

    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret