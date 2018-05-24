# ------------------------------------------------------------------------------
# Soma os elementos de um vetor
# ------------------------------------------------------------------------------
# Algoritmo:
# soma = 0
# for (i = 0 ; i < n ; i++)
#    soma = soma + vetor[i]
# escreve soma na tela
# ------------------------------------------------------------------------------
# Uso dos registradores:
# $t0: soma
# $t1: i
# $t2: n
# $t3: endereço na memória de vetor[i]
# $t4: vetor[i]
# $t5: auxiliar para comparação
# ------------------------------------------------------------------------------
      .text                  # Seção de código
      add  $t0, $zero, $zero # $t0 = 0 (soma = 0)
      add  $t1, $zero, $zero # $t1 = 0 (i = 0)
      lw   $t2, n ($zero)    # Lê n da memoria e coloca em $t2
      la   $t3, vetor        # $t3 = endereço inicial do vetor na memória
loop: slt  $t5, $t1, $t2     # Se i < n então $t5 = 1 senão $t5 = 0
      beq  $t5, $zero, fim   # Se $t5 == 0 (i >= n) então desvia p/ fora do laço
      lw   $t4, 0 ($t3)      # Lê vetor[i] da memória e coloca em $t4
      add  $t0, $t0, $t4     # $t0 = $t0 + $t4 (soma = soma + vetor[i])
      addi $t1, $t1, 1       # $t1 = $t1 + 1 (i++)
      addi $t3, $t3, 4       # $t3 = $t3 + 4 (endereço de vetor[i] na memória)
      j    loop              # Desvia para início do laço
fim:  sw   $t0, soma ($zero) # Escreve $t0 na memoria em soma

      addi $v0, $zero, 1     # Chamada ao sistema para escrever inteiro na tela
      add  $a0, $t0, $zero   # $a0 := inteiro a ser escrito na tela
      syscall

      addi $v0, $zero,10     # Chamada ao sistema para encerrar programa
      syscall
# ------------------------------------------------------------------------------
      .data                  # Seção de dados
n:    .word 20               # Número de elementos do vetor
soma: .word 0                # Soma dos elementos do vetor
vetor:.word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20  # Vetor
# ------------------------------------------------------------------------------
