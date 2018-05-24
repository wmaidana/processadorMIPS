/**
 *
 * Programa que simula um processador MIPS
 * 
 * Academicos:
 * 		2016 1907 015-4 KELLI REGINA MESA DE SOUSA MARTINS
 *		2016 1907 004-9 WALKER MAIDANA DA SILVA
 */

// SUGESTAO: class processadorMIPS

import java.util.Scanner;
import java.io.FileInputStream

class trabalho2 {
	public static void main( String[] args) {

	// Inicio do programa
	InputStream arquivoFonte;
	String nomeDoExecutavel;
	

	int[] reg = new int[32];
		
	// PC = Program Couter -> Endereço da Proxima Instrucao a executar
	int pc = 12288;

	// IR = Instruction Registrer -> Proxima Instrução
	int ir;

	// HI e LO = Hight e Lower -> Alto e Baixo
	int hi, lo;

	/**
	 * A memória principal seria um vetor de 16.384 bytes (2^14)
	 * Será preciso pensar em uma solução melhor pra isso.
	 */
	int[] memoriaPrincipal = new int[16384];

	// Sao 4 bytes em sequência. Deve ser multiplo de 4 (validar)
	int palavra;






	// Recebe o nome do(s) arquivo(s) via terminal ou teclado
	if (args.length > 0) {
		for (int i = 0; i < args.length; i++){
			nomeDoExecutavel = args[i];
			abrirArquivoFonte (nomeDoExecutavel)
		}
	}
	else {
		System.out.println("Informe o nome.extensao do arquivo a executar:");

		abrirArquivoFonte(nomeDoExecutavel);		
	}

			
		/**
		 * Coloca o programa na memoria e inicializa o conteudoDaProximaInstrução
		 * alem de deixar pronto o enderecoDaProximaInstrucao
		 */
		inicializa();
		
		while( !fim_execucao ) {
			// Le da memoria instrucao a executar (apontada por PC) e guarda em IR
			ir = buscaInstrucao(pc);

			// Atualiza PC
			pc +=4;

			// Decodifica instrucao em IR: Determina campo OP e demais campos
			decodificaInstrucao(ir);

			// Executa instrucao, com base em seus campos
			// Dependendo da instrução, PC pode ser alterado
			executaInstrucao();
		}

		nomeDoExecutavel.close();
	}

	// Vai imprimir o arquivo fonte. Testar isoladamente.
	void abrirArquivoFonte (String nomeDoArquivo) {
		try {
				arquivoFonte = new FileInputStream(nomeDoExecutavel);
				int dado = arquivoFonte.read();

				while (dado != -1){
					System.out.println(data);
					dado = arquivoFonte.read();
				}
		}
		catch (FileNotFoudException e1) {
			e1.printStackTrace();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}
}
