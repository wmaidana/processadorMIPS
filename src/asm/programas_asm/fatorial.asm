# ------------------------------------------------------------------------------
# Algoritmo:
#
# Programa princial:
#    le n do teclado
#    resultado = fatorial(n)
#    escreve resultado na tela
#
# Subrotina fatorial(n)
#    if (n < 2)
#       retorna 1
#    else
#       aux = fatorial(n - 1)
#       retorna n * aux
# ------------------------------------------------------------------------------
# Uso dos registradores:
#
# $a0: parâmetro passado para subrotina fatorial
#      (e para algumas chamadas ao sistema)
# $v0: valor de retorno da subrotina fatorial
#      (e no. da chamada ao sistema e valor de retorno de algumas chamadas ao sistema)
# $t0: auxiliar para comparação
# $t1: max
# $t2: n
# $ra: endereço de retorno da subrotina
# $sp: stack pointer (endereço na memória de dado no topo da pilha)
# ------------------------------------------------------------------------------
         .text                     # Area de codigo
 main:    addi $v0, $zero, 4       # Chamada ao sistema para escrever string msg1 na tela
          la   $a0, msg1           # $a0 = endereco da string a ser escrita na tela
          syscall

          addi $v0, $zero, 5       # Chamada ao sistema para ler inteiro do teclado
          syscall                  # $v0 recebera' inteiro lido do teclado
          add  $t2, $v0, $zero     # $t2 recebe n

          lw   $t1, max ($zero)    # Lê max da memoria e coloca em $t1

          slt  $t0, $t1, $t2       # Se max < n então $t0 = 1 senão $t0 = 0
          beq  $t0, $zero, executa # Se $t0 == 0 (max >= n) então desvia para início da execução do programa
          addi $v0, $zero, 4       # Chamada ao sistema para escrever string na tela
          la   $a0, msg2           # $a0 := endereco da string a ser escrita na tela
          syscall
          j    encerra             # Desvia para fim do programa

executa:  add  $a0, $t2, $zero     # $a0 recebe parametro de entrada para subrotina (n)
          jal  fatorial            # Chama fatorial(n), $v0 receberá resultado da subrotina
          add  $t0, $v0, $zero     # 

          addi $v0, $zero, 4       # Chamada ao sistema para escrever string msg2 na tela
          la   $a0, msg3           # $a0 = endereco da string a ser escrita na tela
          syscall

          addi $v0, $zero, 1       # Chamada ao sistema para escrever inteiro na tela
          add  $a0, $t0, $zero     # $a0 = inteiro a ser escrito na tela
          syscall

encerra:  addi $v0, $zero,10       # Chamada ao sistema para encerrar programa
          syscall
# ------------------------------------------------------------------------------
fatorial: slti $t0, $a0, 2         # Compara n com valor 2
          beq  $t0, $zero, else    # Se n >= 2 entao desvia para else 
          addi $v0, $zero, 1       # Valor de retorno é 1 (em $v0)
          jr   $ra                 # Retorna da subrotina
else:     addi $sp, $sp, -8        # Aloca espaço na pilha para 2 palavras
          sw   $ra, 4 ($sp)        # Salva endereço de retorno na pilha
          sw   $a0, 0($sp)         # Salva argumento n na pilha
          addi $a0, $a0, -1        # Decrementa n
          jal  fatorial            # Chamada recursiva fatorial(n-1), $v0 receberá resultado da subrotina
          lw   $a0, 0 ($sp)        # Restaura argumento n da pilha
          lw   $ra, 4 ($sp)        # Restaura endereço de retorno da pilha
          addi $sp, $sp, 8         # Libera espaço na pilha
          mult $a0, $v0            # Valor de retorno é n*fatorial(n-1) (em $v0)
          mflo $v0
          jr   $ra                 # Retorna da subrotina
# ------------------------------------------------------------------------------
          .data                    # Area de dados
max:      .word 12                 # Valor máximo de n
msg1:     .asciiz "Entre com um numero natural: "
msg2:     .asciiz "Valor de n deve ser no máximo 12"
msg3:     .asciiz "O fatorial deste numero e': "
# ------------------------------------------------------------------------------
