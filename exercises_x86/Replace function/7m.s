section .text
global replace

replace:
    push ebp                
    push ebx                
    mov ebp, esp            
    mov ecx, DWORD[ebp+12]  
    mov DWORD[ebp-4], 0
    mov DWORD[ebp-12], 0      

search_small_letter_loop:
    mov al, BYTE[ecx]
    cmp al, 0
    je main
    cmp al, 'a'
    jge small_letter
    inc ecx
    inc DWORD[ebp-12]
    jmp search_small_letter_loop

small_letter:
    inc DWORD[ebp-12]
    inc DWORD[ebp-4]
    inc ecx
    jmp search_small_letter_loop

main:
    mov ecx, DWORD[ebp+12]
    mov DWORD[ebp-8], 0

main_loop:
    mov al, BYTE[ecx]
    cmp al, 0
    je final
    inc DWORD[ebp-8]
    mov bl, BYTE[ebp-8]
    cmp bl, 5
    je fifth
    inc ecx
    jmp main_loop

fifth:
    mov bl, BYTE[ebp-4]
    mov DWORD[ebp-8], 0
    test bl, BYTE[ebp-12]
    jz asterix
    jmp increment_by_2

increment_by_2:
    add BYTE[ecx], 2
    inc ecx
    jmp main_loop

asterix:
    mov BYTE[ecx], '*'
    inc ecx
    jmp main_loop

final:
    mov BYTE[ecx], 0
    mov eax, [ebp-4]
    pop ebx
    pop ebp
    ret