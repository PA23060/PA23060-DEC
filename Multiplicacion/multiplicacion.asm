section .data
    valorA db 7
    valorB db 5
    texto db "Multiplicacion de 7 * 5 = ", 0
    texto_len equ $ - texto
    salto db 10

section .bss
    ascii_num resb 5   ; Espacio para convertir el número a ASCII

section .text
    global _start

_start:
    ; --- Multiplicación ---
    mov al, [valorA]       ; AL = 7
    mul byte [valorB]      ; AX = AL * valorB = 35
    mov [ascii_num], al    ; Guardar resultado temporal

    ; --- Convertir resultado a ASCII ---
    movzx eax, byte [ascii_num]  ; EAX = 35
    mov edi, ascii_num + 4       ; Posición final del buffer
    mov byte [edi], 10           ; Agregar salto de línea
    dec edi

    mov ecx, 10                  ; Base decimal
convertir:
    xor edx, edx
    div ecx                      ; EAX / 10 → EAX=cociente, EDX=resto
    add dl, '0'                  ; Convertir a carácter ASCII
    mov [edi], dl
    dec edi
    test eax, eax
    jnz convertir

    ; --- Imprimir texto ---
    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, texto_len
    int 0x80

    ; --- Imprimir número convertido ---
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1]     ; Inicio del número convertido
    mov edx, 2             ; Longitud esperada (ajusta si cambia el número)
    int 0x80

    ; --- Imprimir salto de línea ---
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; --- Terminar programa ---
    mov eax, 1
    xor ebx, ebx
    int 0x80
