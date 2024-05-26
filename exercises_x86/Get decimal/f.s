section .text
global getdec

getdec:
    push ebp            ; prologue
    mov ebp, esp

    mov ecx, [ebp + 8]  ; eax = source char pointer

    xor eax, eax

iterate:
    mov dl, [ecx]       ; dl = current character
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl not_digit

    cmp dl, '9'
    jg not_digit

    add al, dl
    add al, -48

next_digit:
    inc ecx

    mov dl, [ecx]

    cmp dl, '0'
    jl end

    cmp dl, '9'
    jg end

    imul eax, 10
    add al, dl
    add al, -48

    jmp next_digit

not_digit:
    inc ecx
    jmp iterate

end:
    mov esp, ebp
    pop ebp
    ret