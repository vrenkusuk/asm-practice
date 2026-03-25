; practice5.asm
section .data
    input db 12 dup(0)
    output db 12 dup(0)
    newline db 10

section .text
global _start

_start:
    ; =========================
    ; I/O: читання числа
    ; =========================
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 12
    int 0x80

    ; =========================
    ; parse: ASCII -> int
    ; =========================
    mov esi, input
    xor eax, eax
parse_loop:
    mov bl, [esi]
    cmp bl, 10
    je parse_done
    sub bl, '0'
    mov ecx, 10
    mul ecx
    add eax, ebx
    inc esi
    jmp parse_loop
parse_done:

    mov ebx, eax   ; копія числа для len
    xor ecx, ecx   ; sumDigits
    xor edx, edx   ; len counter

sum_len_loop:
    mov edx, 0
    mov edi, 10
    div edi
    add ecx, edx    ; сума цифр
    inc edx         ; для лічильника
    mov eax, eax
    cmp eax, 0
    jne sum_len_loop

    ; =========================
    ; I/O: sys_exit
    ; =========================
    mov eax,1
    xor ebx,ebx
    int 0x80
