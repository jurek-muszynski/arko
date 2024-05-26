section .text
global gethex

gethex:
    push ebp            ; prologue
    mov ebp, esp

    mov ecx, [ebp + 8]  ; eax = source char pointer

    xor eax, eax

iterate:
    mov dl, [ecx]       ; dl = current character
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl iterate

    cmp dl, '9'
    jg check_upper

    add al, dl
    add al, -48

    jmp next_char


check_upper:
    cmp dl, 'A'
    jl iterate

    cmp dl, 'F'
    jg check_lower

    add al, dl
    add al, -55

    jmp next_char

check_lower:
    cmp dl, 'a'
    jl iterate

    cmp dl, 'f'
    jg iterate

    add al, dl
    add al, -87

next_char:
    inc ecx

    mov dl, [ecx]

    cmp dl, '0'
    jl end

    cmp dl, '9'
    jg next_char_upper

    imul eax, 16
    add al, dl
    add al, -48

    jmp next_char

next_char_upper:
    cmp dl, 'A'
    jl end

    cmp dl, 'F'
    jg next_char_lower

    imul eax, 16
    add al, dl
    add al, -55

    jmp next_char

next_char_lower:
    cmp dl, 'a'
    jl end

    cmp dl, 'f'
    jg end

    imul eax, 16
    add al, dl
    add al, -55

    jmp next_char

end:
    mov esp, ebp
    pop ebp
    ret