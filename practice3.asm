; practice3.asm
; Мова: Assembler i386 (NASM)
; ОС: Debian Linux
; Ввід/вивід: тільки int 0x80 (sys_read/sys_write/sys_exit)

section .data
    buffer db '      ', 0   ; Буфер для рядка числа (6 символів + 0)

section .text
global _start

_start:
    ; =========================
    ; I/O: взяти число з регістру AX
    ; =========================
    mov ax, 123456       ; приклад числа (заміни на реальний ввід)
    mov bx, 10           ; база для ділення (decimal)
    lea di, [buffer+5]   ; починаємо з кінця буфера
    mov cx, 0            ; лічильник цифр

parse_loop:
    xor dx, dx
    div bx               ; ax / 10 -> ax=quotient, dx=remainder
    add dl, '0'          ; перетворюємо цифру на ASCII
    mov [di], dl
    dec di
    inc cx
    cmp ax, 0
    jne parse_loop

    inc di                ; перейти на першу цифру
    ; =========================
    ; I/O: sys_write
    ; =========================
    mov eax, 4           ; sys_write
    mov ebx, 1           ; stdout
    mov edx, cx          ; кількість байт
    mov ecx, di          ; адреса рядка
    int 0x80

    ; =========================
    ; I/O: sys_exit
    ; =========================
    mov eax, 1           ; sys_exit
    xor ebx, ebx
    int 0x80
