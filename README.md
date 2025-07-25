
# Sequência de Fibonacci

## Este Trabalho implementa o Tema 3 de uma atividade prática de Arquitetura e Organização de Computadores. O programa, desenvolvido em linguagem Assembly, tem como objetivo gerar os N primeiros termos da sequência de Fibonacci. O valor de N é pré-definido no código. Os termos da sequência são armazenados em um vetor na memória e, ao final da execução, são exibidos no console.


[Relatório](/assets/Relatório%20Atividade%20Prática%203ª%20Unidade-%20Sequência%20de%20Fibonacci.pdf)

[Slide](/assets/Slide%20Sequência%20de%20Fiboancci%20-%20Assembly.pdf)

[Instruções do Trabalho](/assets/Trabalho_Final_Arquitetura.pdf)


### Fórmula da Sequência de Fibonacci

$F(n) = F(n-1) + F(n-2) , \quad com\quad n>2\quad e\quad F(1)=F(2)=1$

*Onde:*
* $F(n)$ é o n-ésimo termo da sequência.
* $F(n-1)$ é o termo anterior.
* $F(n-2)$ é o termo dois antes.
* Os termos iniciais são $F(1) = 1$ e $F(2) = 1$.


### Como compilar: 

* Compilando usando um compilador online:

https://www.jdoodle.com/compile-assembler-nasm-online


* Compilando usando o [Nasm](https://www.nasm.us/):
```bash
nasm -f elf32 fibonacci.asm
ld -m elf_i386 fibonacci.o -o fibonacci
./fibonacci
```

### Dependências: 

[Nasm](https://www.nasm.us/)

Debian/Ubuntu
```bash
sudo apt install nasm
```

ArchLinux
```bash
sudo pacman -S nasm
```
Fedora
```bash
sudo dnf install nasm
```
