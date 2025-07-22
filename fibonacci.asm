section .data
    n dd 15          ; valor máximo de n
    newline db 10       ; caractere de nova linha '\n'

section .bss
    num resb 4          ; reserva 4 bytes para armazenar um número convertido em string

section .text
    global _start

_start:
    mov ecx, 1          ; contador i = 1

print_loop:
    cmp ecx, [n]
    ja  sair     ; se i > n, termina o loop

    mov eax, ecx        ; calcula Fibonacci(i)
    call fibonacci      ; resultado em EAX

    ; converte EAX para string (decimal) em num
    push ecx            ; salva contador
    mov edi, num + 3     ; aponta para o final do buffer
    mov byte [edi], 0    ; null terminator

converter_digito:
    xor edx, edx
    mov ebx, 10
    div ebx             ; EAX / 10, resto em EDX
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz converter_digito

    ; imprime número
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; fd: stdout
    mov ecx, edi        ; ponteiro para número convertido

    mov edx, num
    add edx, 4
    sub edx, edi        ; comprimento = (num + 4) - edi

    int 0x80

    ; imprime nova linha
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    pop ecx             ; recupera contador
    inc ecx             ; i++
    jmp print_loop

sair:
    ; sair do programa
    mov eax, 1          ; syscall: sys_exit
    xor ebx, ebx
    int 0x80

; Função fibonacci 
; Entrada: EAX = n
; Saída:   EAX = Fibonacci(n)

fibonacci:
    push    ebx
    push    ecx
    push    edx

    cmp     eax, 1
    je      .fib_um
    cmp     eax, 2
    je      .fib_um

    mov     ebx, 1      ; Fib(1)
    mov     ecx, 1      ; Fib(2)
    mov     edx, 3      ; começa do 3º termo

.inicio_loop:
    cmp     edx, eax
    jg      .fim_calculo

    mov     esi, ecx    ; salva Fib(n-1)
    add     ecx, ebx    ; Fib(n) = Fib(n-1) + Fib(n-2)
    mov     ebx, esi    ; Fib(n-2) = Fib(n-1)

    inc     edx
    jmp     .inicio_loop

.fim_calculo:
    mov     eax, ecx
    jmp     .fim

.fib_um:
    mov     eax, 1
    jmp     .fim

.fim:
    pop     edx
    pop     ecx
    pop     ebx
    ret
