section .text
global replace
replace:
    push ebp
    push ebx
    mov ebp, esp
    mov ecx, DWORD[ebp+12]
    mov DWORD[ebp-4], 0
    mov DWORD[ebp-12], 0
c_loop:
    mov al, BYTE[ecx]
    cmp al, 0
    je main
    cmp al, '+'
    je plus
    inc ecx
    inc DWORD[ebp-12]
    jmp c_loop

plus:
    inc DWORD[ebp-12]
    inc DWORD[ebp-4]
    inc ecx
    jmp c_loop

main:
    mov ecx, DWORD[ebp+12]
    mov DWORD[ebp-8], 0
main_loop:
    mov al, BYTE[ecx]
    cmp al, 0
    je fin
    inc DWORD[ebp-8]
    mov bl, BYTE[ebp-8]
    cmp bl, 4
    je fourth
    inc ecx
    jmp main_loop


fourth:
    mov bl, BYTE[ebp-4]
    mov BYTE[ebp-8], 0
    test bl, 1
    jz ast
    jmp upper

ast:
    mov BYTE[ecx], '*'
    inc ecx
    jmp main_loop

upper:
    cmp al, 97
    jge greater
    inc ecx
    jmp main_loop

greater:
    cmp al, 122
    jle less
    inc ecx
    jmp main_loop

less:
    sub al, 32
    mov BYTE[ecx], al
    inc ecx
    jmp main_loop

fin:
    mov BYTE[ecx], 0
    mov eax, [ebp-12]
    pop ebx
    pop ebp
    ret

