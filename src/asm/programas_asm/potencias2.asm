# ------------------------------------------------------------------------------
# Gera sequência de n números potências de 2 (1, 2, 4, ..., 2^(n-1))
# ------------------------------------------------------------------------------
# Algoritmo:
# lê n do teclado
# se n > max então
#    imprime msg de erro
#    encerra execução
# senão
#    dado = 1
#    for (i = 0 ; i < n ; i++)
#       vetor[i] = dado (2^i)
#       escreve dado na tela
#       dado = dado * 2
# ------------------------------------------------------------------------------
# Uso dos registradores:
# $t0: n
# $t1: max
# $t2: i
# $t3: dado (vetor[i])
# $t4: endereço na memória de vetor[i]
# $t5: auxiliar para comparação
# ------------------------------------------------------------------------------
          .text                      # Seção de código

          addi $v0, $zero, 4         # Chamada ao sistema para escrever string na tela
          la   $a0, msg1             # $a0 := endereco da string a ser escrita na tela
          syscall

          addi $v0, $zero, 5         # Chamada ao sistema para ler inteiro do teclado
          syscall                    # $v0 recebera' inteiro lido do teclado
          add  $t0, $v0, $zero       # $t0 = n

          lw   $t1, max ($zero)      # Lê max da memoria e coloca em $t1

          slt  $t5, $t1, $t0         # Se max < n então $t5 = 1 senão $t5 = 0
          beq  $t5, $zero, executa   # Se $t5 == 0 (max >= n) então desvia para início da execução do programa
          addi $v0, $zero, 4         # Chamada ao sistema para escrever string na tela
          la   $a0, msg2             # $a0 := endereco da string a ser escrita na tela
          syscall

          j    encerra               # Desvia para fim do programa

executa:  add  $t2, $zero, $zero     # $t2 = 0 (i = 0)
          addi $t3, $zero, 1         # $t3 = 1 (dado = 1)
          la   $t4, vetor            # $t4 = endereço inicial do vetor na memória

loop:     slt  $t5, $t2, $t0         # Se i < n então $t5 = 1 senão $t5 = 0
          beq  $t5, $zero, fimloop   # Se $t5 == 0 (i >= n) então desvia para fora do laço
          sw   $t3, 0 ($t4)          # Escreve dado em vetor[i] na memória

          addi $v0, $zero, 1         # Chamada ao sistema para escrever inteiro na tela
          add  $a0, $t3, $zero       # $a0 := inteiro a ser escrito na tela
          syscall

          addi $v0, $zero, 4         # Chamada ao sistema para escrever string na tela
          la   $a0, msg3             # $a0 := endereco da string a ser escrita na tela
          syscall

          sll  $t3, $t3, 1           # $t3 = $t3 << 1 (dado = dado * 2)
          addi $t2, $t2, 1           # $t2 = $t2 + 1 (i++)
          addi $t4, $t4, 4           # $t4 = $t4 + 4 (endereço de vetor[i] na memória)
          j    loop                  # Desvia para início do laço

fimloop:
encerra:  addi $v0, $zero,10         # Chamada ao sistema para encerrar programa
          syscall
# ------------------------------------------------------------------------------
          .data                      # Seção de dados
max:      .word 30                   # Número máximo de elementos do vetor
vetor:    .word 0:30                 # Reserva espaço para vetor com no máximo 30 palavras
msg1:     .asciiz "Entre com n: "
msg2:     .asciiz "Valor de n deve ser no máximo 30"
msg3:     .asciiz " "
# ------------------------------------------------------------------------------
