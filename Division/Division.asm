section .data
    dividendo dd 100
    divisor dd 20
    mensaje db "Resultado de dividir 100 / 20 es: ", 0
    mensaje_len equ $ - mensaje
    salto_linea db 10

section .bss
    cadena_res resb 15    ; buffer para resultado en ASCII

section .text
    global _start

_start:
    ; --- División ---
    mov eax, [dividendo]    ; eax = 100
    xor edx, edx            ; limpiar edx para división
    div dword [divisor]     ; eax = cociente, edx = residuo

    ; --- Convertir resultado a ASCII ---
    mov edi, cadena_res + 13    ; apuntar al final del buffer
    mov byte [edi], 0           ; terminador nulo para seguridad
    dec edi
    mov byte [edi], 10          ; salto de línea

    test eax, eax
    jz resultado_cero

    mov ecx, 10
convertir_loop:
    dec edi
    xor edx, edx
    div ecx                    ; eax = eax / 10, edx = residuo
    add dl, '0'                ; convertir a ASCII
    mov [edi], dl
    test eax, eax
    jnz convertir_loop
    jmp resultado_listo

resultado_cero:
    dec edi
    mov byte [edi], '0'

resultado_listo:
    ; --- Imprimir mensaje ---
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; --- Imprimir resultado ---
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi]
    mov edx, cadena_res + 14
    sub edx, ecx
    int 0x80

    ; --- Imprimir salto de línea ---
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    ; --- Salir ---
    mov eax, 1
    xor ebx, ebx
    int 0x80
