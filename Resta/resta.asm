section .data
    valor1 dw 45
    valor2 dw 18
    valor3 dw 7
    resultado dw 0

    texto db "Resultado de la resta 45 - 18 - 7: ", 0
    texto_len equ $ - texto

    salto_linea db 10

section .bss
    numero_ascii resb 4   ; Espacio para convertir número a ASCII

section .text
    global _start

_start:
    ; --- Realizar la resta ---
    mov ax, [valor1]      ; AX = 45
    sub ax, [valor2]      ; AX = 45 - 18 = 27
    sub ax, [valor3]      ; AX = 27 - 7 = 20
    mov [resultado], ax   ; Guardar el resultado

    ; --- Convertir a cadena ASCII ---
    mov ax, [resultado]
    mov edi, numero_ascii + 3
    mov byte [edi], 10    ; Salto de línea
    dec edi

    mov cx, 10            ; Para división decimal
convertir:
    xor dx, dx
    div cx                ; AX / 10 → AX=cociente, DX=resto
    add dl, '0'           ; Convertir a ASCII
    mov [edi], dl
    dec edi
    test ax, ax
    jnz convertir

    ; --- Mostrar mensaje en pantalla ---
    mov eax, 4            ; syscall write
    mov ebx, 1            ; stdout
    mov ecx, texto        ; mensaje descriptivo
    mov edx, texto_len
    int 0x80

    ; --- Mostrar número convertido ---
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1]    ; Puntero al número en ASCII
    mov edx, 2            ; Longitud esperada (ajústala si cambia el número)
    int 0x80

    ; --- Imprimir salto de línea ---
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    ; --- Terminar programa ---
    mov eax, 1
    xor ebx, ebx          ; Código de salida 0
    int 0x80

