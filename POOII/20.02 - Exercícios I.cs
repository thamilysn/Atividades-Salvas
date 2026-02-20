//Exercício I - IBGE
using System.Collections;

namespace Exercicios
{
    internal class Program
    {
        static void Main(string[] args)
        {

            ArrayList idades = new ArrayList();
            int idade;
            Console.WriteLine("Digite as idades (idade <= 0 para encerrar): ");

            while (true)
            {
                Console.Write("Idade: ");
                idade = int.Parse(Console.ReadLine());

                if (idade <= 0)
                    break;

                idades.Add(idade);
            }

            int faixaA = 0; 
            int faixaB = 0; 
            int faixaC = 0; 
            int faixaD = 0; 
            int faixaE = 0; 

            foreach (int i in idades)
            {
                if (i >= 1 && i <= 15)
                    faixaA++;
                else if (i <= 30)
                    faixaB++;
                else if (i <= 45)
                    faixaC++;
                else if (i <= 60)
                    faixaD++;
                else
                    faixaE++;
            }

            int totalPessoas = idades.Count;

            if (totalPessoas > 0)
            {
                Console.WriteLine("\nPorcentagem por faixa etária:");

                Console.WriteLine($"Faixa A (1-15): {(faixaA * 100.0 / totalPessoas):F2}%");
                Console.WriteLine($"Faixa B (16-30): {(faixaB * 100.0 / totalPessoas):F2}%");
                Console.WriteLine($"Faixa C (31-45): {(faixaC * 100.0 / totalPessoas):F2}%");
                Console.WriteLine($"Faixa D (46-60): {(faixaD * 100.0 / totalPessoas):F2}%");
                Console.WriteLine($"Faixa E (61+): {(faixaE * 100.0 / totalPessoas):F2}%");
            }
            else
            {
                Console.WriteLine("Nenhuma idade válida foi informada.");
            }
        }
    }
}

//Exercício 2 - Verão Capixaba
