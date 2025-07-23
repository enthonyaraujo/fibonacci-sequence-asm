
section .data
    n dd 10             ; Define o valor máximo de n. Aqui queremos calcular os n primeiros números da sequência de Fibonacci.
                         ; 'dd' significa 'define doubleword' (define 4 bytes).
    newline db 10        ; Define o caractere de nova linha (\n, código ASCII 10). 'db' significa 'define byte' (1 byte).

section .bss
    num resb 4           ; Reserva 4 bytes na memória para armazenar um número convertido em string (ex: "233\0").

section .text
    global _start        ; Define o ponto de entrada do programa.

_start:
    mov ecx, 1           ; Inicializa o contador ECX com 1. Vamos começar do primeiro termo da sequência de Fibonacci.

print_loop:
    cmp ecx, [n]         ; Compara ECX (o contador atual) com o valor armazenado na variável n.
    ja  sair             ; Se ECX > n, sai do loop e termina o programa.

    mov eax, ecx         ; Coloca o índice atual (i) em EAX. Essa será a entrada da função Fibonacci.
    call fibonacci       ; Chama a função fibonacci. O resultado será armazenado de volta em EAX.

    ; A partir daqui, vamos converter o valor numérico de EAX em uma string (ASCII) para poder imprimir.

    push ecx             ; Salva o contador ECX na pilha (será recuperado depois da impressão).
    mov edi, num + 3     ; EDI aponta para o final do buffer reservado para o número (posição mais à direita).
    mov byte [edi], 0    ; Coloca o caractere NULL (0) no final da string para terminar corretamente.

converter_digito:
    xor edx, edx         ; Zera EDX. Isso é obrigatório antes de uma divisão de 32 bits para evitar lixo no resto.
    mov ebx, 10          ; EBX = 10. Queremos dividir por 10 para extrair os dígitos decimais.
    div ebx              ; Divide EAX por 10. O quociente fica em EAX e o resto (dígito atual) em EDX.
    add dl, '0'          ; Converte o valor numérico do dígito (0-9) para seu equivalente ASCII ('0'-'9').
    dec edi              ; Move o ponteiro EDI uma posição para trás no buffer.
    mov [edi], dl        ; Armazena o caractere convertido no buffer.

    test eax, eax        ; Verifica se EAX ainda tem algum dígito a ser processado.
    jnz converter_digito ; Se ainda houver, continua convertendo o próximo dígito.

    ; agora temos o número em formato de string, e podemos imprimi-lo.

    mov eax, 4           ; syscall número 4 = sys_write (escrita)
    mov ebx, 1           ; descritor de arquivo 1 = saída padrão (stdout)
    mov ecx, edi         ; ECX aponta para o início da string a ser impressa

    mov edx, num
    add edx, 4
    sub edx, edi         ; Calcula o comprimento da string: (fim do buffer) - (início real)

    int 0x80             ; Executa a chamada do sistema: imprime o número

    ; Agora imprimimos uma quebra de linha

    mov eax, 4
    mov ebx, 1
    mov ecx, newline     ; endereço do caractere de nova linha
    mov edx, 1           ; tamanho = 1 byte
    int 0x80

    pop ecx              ; Recupera o valor anterior de ECX (contador)
    inc ecx              ; Incrementa ECX para calcular o próximo Fibonacci
    jmp print_loop       ; Volta para o início do loop

sair:
    mov eax, 1           ; syscall número 1 = sys_exit (finaliza o programa)
    xor ebx, ebx         ; Código de saída = 0 (sucesso)
    int 0x80             ; Executa a saída do programa

; ------------------------ Função Fibonacci --------------------------
; Entrada: EAX = n
; Saída: EAX = Fibonacci(n)
; Essa função implementa a sequência iterativamente.

fibonacci:
    push ebx             ; Salva EBX na pilha
    push ecx             ; Salva ECX na pilha
    push edx             ; Salva EDX na pilha

    cmp eax, 1
    je .fib_um           ; Se n == 1, retorna 1
    cmp eax, 2
    je .fib_um           ; Se n == 2, retorna 1

    ; Caso geral: vamos calcular F(n) iterativamente

    mov ebx, 1           ; EBX = F(1) = 1
    mov ecx, 1           ; ECX = F(2) = 1
    mov edx, 3           ; Começa a partir do 3º termo

.inicio_loop:
    cmp edx, eax
    jg .fim_calculo      ; Se já chegamos no termo desejado, sai do loop

    mov esi, ecx         ; Salva F(n-1) em ESI temporariamente
    add ecx, ebx         ; F(n) = F(n-1) + F(n-2)
    mov ebx, esi         ; Atualiza F(n-2) para o próximo ciclo

    inc edx              ; Avança para o próximo termo (n++)
    jmp .inicio_loop     ; Repete o loop

.fim_calculo:
    mov eax, ecx         ; Resultado final em EAX
    jmp .fim

.fib_um:
    mov eax, 1           ; F(1) ou F(2) = 1
    jmp .fim

.fim:
    pop edx              ; Restaura EDX
    pop ecx              ; Restaura ECX
    pop ebx              ; Restaura EBX
    ret                  ; Retorna para quem chamou a função