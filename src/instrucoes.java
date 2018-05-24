class instrucoes {

	int tipo; //
	/**
	 * Construtor da classe
	 */ 
	instrucao() {}

	/**
	* Instruções lógico-aritméticas
	* add, sub, addi, and, or, xor, nor, andi, ori, sll, srl, slt, slti
	*/
	add();
	sub();
	addi();
	and();
	or();
	xor();
	nor();
	andi();
	ori();
	sll();
	srl();
	slt();
	slti();
	
	/**
	 * Multiplicação e divisão
	 */
	mult();
	div();

	/**
	 * Acesso à memória
	 */
	lw();
	sw();
	lb();
	sb();

	/**
	 * Desvios condicionais
	 */
	beq();
	bne();
	

	/**
	 * Desvios incondicionais
	 */
	j();
	jr();
	jal();

	/**
	 * Chamadas ao sistema operacional (syscall)
	 * 1 = print integer
	 * 4 = print string
	 * 5 = read integer
	 * 8 = read string
	 * 10= exit
	 */
	syscall(int v) {
		case v{
			1: prinInteger();
			4: printString();
			5: readInteger();
			8: readString();
			10: exit();
			default: printError();
		}
	}
	prinInteger();
	printString();
	readInteger();
	readString();
	exit();
	syscallError(int op) {
		print("Erro! syscall não suporta a opção" + op + ".");
	}


}
