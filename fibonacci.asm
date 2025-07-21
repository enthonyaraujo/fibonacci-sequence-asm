section .data
    n dd 10          ; valor máximo de n
    newline db 10       ; caractere de nova linha '\n'

section .bss
    num resb 4          ; buffer para armazenar número convertido em string (até 3 dígitos + null)

section .text
    global _start

_start:
    mov ecx, 1          ; contador i = 1

print_loop:
    cmp ecx, [n]
    ja  end_program     ; se i > n, termina

    mov eax, ecx        ; calcula Fibonacci(i)
    call fibonacci      ; resultado em EAX

    ; converte EAX para string (decimal) em num
    push ecx            ; salva contador
    mov edi, num + 3     ; aponta para o final do buffer
    mov byte [edi], 0    ; null terminator

convert_digit:
    xor edx, edx
    mov ebx, 10
    div ebx             ; EAX / 10, resto em EDX
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz convert_digit

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

end_program:
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

    cmp     eax, 0
    je      .fib_zero
    cmp     eax, 1
    je      .fib_one

    mov     ebx, 0      ; Rf1
    mov     ecx, 1      ; Rf2
    mov     edx, eax    ; Rn

.loop:
    sub     edx, 2
    js      .finish

    add     ebx, ecx
    add     ecx, ebx
    jmp     .loop

.finish:
    test    edx, 1
    jz      .even
    mov     eax, ecx
    jmp     .done

.even:
    mov     eax, ebx
    jmp     .done

.fib_zero:
    xor eax, eax
    jmp .done

.fib_one:
    mov eax, 1

.done:
    pop     edx
    pop     ecx
    pop     ebx
    ret
