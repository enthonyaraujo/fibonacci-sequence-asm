
# Sequência de Fibonacci

## Este Trabalho implementa o Tema 3 de uma atividade prática de Arquitetura e Organização de Computadores. O programa, desenvolvido em linguagem Assembly, tem como objetivo gerar os N primeiros termos da sequência de Fibonacci. O valor de N é pré-definido no código. Os termos da sequência são armazenados em um vetor na memória e, ao final da execução, são exibidos no console.

### Fórmula da Sequência de Fibonacci


![Fórmula da Sequência de Fibonacci](/assets/formula-geral.png)

*Onde:*
* $F(n)$ é o n-ésimo termo da sequência.
* $F(n+1)$ é o termo anterior.
* $F(n+2)$ é o termo dois antes.
* Os termos iniciais são $F(1) = 1$ e $F(2) = 1$.

### A Espiral de Fibonacci

A espiral de Fibonacci é uma representação visual da sequência e sua relação com a proporção áurea. 

![Espiral de Fibonacci](/assets/sequencia-de-fibonacci-em-uma-aspiral.jpeg)


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
