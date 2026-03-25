; practice4.asm

section .data
    input_buffer db 10        ; буфер для вводу (до 10 символів)
    output_buffer db '      ', 0

section .bss
    bytes_read resb 1

section .text
global _start

_start:

    ; =========================
    ; I/O: читання з клавіатури
    ; =========================
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, input_buffer
    mov edx, 10
    int 0x80

    mov [bytes_read], al

    ; =========================
    ; parse: рядок -> число
    ; =========================
    mov esi, input_buffer
    xor ax, ax          ; результат = 0

parse_loop:
    mov bl, [esi]
    cmp bl, 10          ; Enter (\n)
    je parse_done

    sub bl, '0'         ; ASCII -> число

    ; =========================
    ; math: result = result * 10 + digit
    ; =========================
    mov dx, 0
    mov cx, 10
    mul cx              ; AX = AX * 10
    add ax, bx

    inc esi
    jmp parse_loop

parse_done:

    ; =========================
    ; convert: число -> рядок
    ; =========================
    mov bx, 10

convert_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov [di], dl
    dec di
    inc cx
    cmp ax, 0
    jne convert_loop

    inc di

    ; =========================
    ; I/O: вивід
    ; =========================
    mov eax, 4
    mov ebx, 1
    mov edx, cx
    mov ecx, di
    int 0x80

    ; =========================
    ; I/O: вихід
    ; =========================
    mov eax, 1
    xor ebx, ebx
    int 0x80
