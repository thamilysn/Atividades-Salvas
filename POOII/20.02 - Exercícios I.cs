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

            int total = idades.Count;

            if (total > 0)
            {
                Console.WriteLine("\nA porcentagem seria de:");

                Console.WriteLine($"Faixa A (1-15): {(faixaA * 100.0 / total):F2}%");
                Console.WriteLine($"Faixa B (16-30): {(faixaB * 100.0 / total):F2}%");
                Console.WriteLine($"Faixa C (31-45): {(faixaC * 100.0 / total):F2}%");
                Console.WriteLine($"Faixa D (46-60): {(faixaD * 100.0 / total):F2}%");
                Console.WriteLine($"Faixa E (61+): {(faixaE * 100.0 / total):F2}%");
            }
            else
            {
                Console.WriteLine("Idade não foi informada.");
            }
        }
    }
}

//Exercício 2.1 - Verão Capixaba 01
using System.Collections;

namespace Exercicios
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int inicio, fim;
            double temperatura, resultado = 0;
            string valorInicial = "", valorFinal = "";

            Console.WriteLine("\nDigite a temperatura inicial:");
            Console.WriteLine("1 - Celsius");
            Console.WriteLine("2 - Fahrenheit");
            Console.WriteLine("3 - Kelvin");
            Console.Write("Opção: ");
            inicio = int.Parse(Console.ReadLine());

            Console.WriteLine("\nDigite a temperatura inicial:");
            Console.WriteLine("1 - Celsius");
            Console.WriteLine("2 - Fahrenheit");
            Console.WriteLine("3 - Kelvin");
            Console.Write("Opção: ");
            fim = int.Parse(Console.ReadLine());

            Console.Write("\nDigite o valor da temperatura: ");
            temperatura = double.Parse(Console.ReadLine());

            switch (inicio)
            {
                case 1:
                    valorInicial = "Celsius";
                    switch (fim)
                    {
                        case 1:
                            valorFinal = "Celsius";
                            resultado = temperatura;
                            break;
                        case 2:
                            valorFinal = "Fahrenheit";
                            resultado = (temperatura * 9 / 5) + 32;
                            break;
                        case 3:
                            valorFinal = "Kelvin";
                            resultado = temperatura + 273.15;
                            break;
                        default:
                            Console.WriteLine("Valor inválido.");
                            return;
                    }
                    break;

                case 2:
                    valorInicial = "Fahrenheit";
                    switch (fim)
                    {
                        case 1:
                            valorFinal = "Celsius";
                            resultado = (temperatura - 32) * 5 / 9;
                            break;
                        case 2:
                            valorFinal = "Fahrenheit";
                            resultado = temperatura;
                            break;
                        case 3:
                            valorFinal = "Kelvin";
                            resultado = (temperatura - 32) * 5 / 9 + 273.15;
                            break;
                        default:
                            Console.WriteLine("Valor inválido.");
                            return;
                    }
                    break;

                case 3:
                    valorInicial = "Kelvin";
                    switch (fim)
                    {
                        case 1:
                            valorFinal = "Celsius";
                            resultado = temperatura - 273.15;
                            break;
                        case 2:
                            valorFinal = "Fahrenheit";
                            resultado = (temperatura - 273.15) * 9 / 5 + 32;
                            break;
                        case 3:
                            valorFinal = "Kelvin";
                            resultado = temperatura;
                            break;
                        default:
                            Console.WriteLine("Valor inválido.");
                            return;
                    }
                    break;

                default:
                    Console.WriteLine("Erro. Valor inválido");
                    return;
            }

            Console.WriteLine($"\nVocê converteu {temperatura:F2} graus {valorInicial} para {valorFinal}.");
            Console.WriteLine($"O resultado é: {resultado:F2} graus {valorFinal}.");
        }
    }
}

//Exercicio 2.2 - Verão Capixaba 02 
using System.Collections;

namespace Exercicios
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double temperatura, soma = 0;
            int dias = 15;

            Console.WriteLine("Digite as temperaturas dos últimos 15 dias (acima de 28°C)\n");

            for (int i = 1; i <= dias; i++)
            {
                while (true)
                {
                    Console.Write($"Dia {i}: ");
                    temperatura = double.Parse(Console.ReadLine());

                    if (temperatura > 28)
                    {
                        soma += temperatura;
                        break;
                    }
                    else
                    {
                        Console.WriteLine("Insira apenas valores acima de 28°C.");
                    }
                }
            }
            double media = soma / dias;
            Console.WriteLine($"\nA temperatura média do verão capixaba foi: {media:F2}°C");
        }
    }
}

//Exercício 3 - Gestão de Recursos na “Supermercado da Mãe”
using System.Collections;

namespace Exercicios
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double preco;
            char codigo;

            double totalGeral = 0;
            double totalLimpeza = 0;
            double totalAlimentacao = 0;
            double totalHigiene = 0;

            for (int i = 1; i <= 20; i++)
            {
                Console.WriteLine($"Mercadoria número {i}: ");

                Console.Write("Digite o preço da mercadoria: ");
                preco = double.Parse(Console.ReadLine());

                Console.Write("Digite o código (L - Limpeza, A - Alimentação, H - Higiene): ");
                codigo = char.Parse(Console.ReadLine());

                totalGeral += preco;

                switch (char.ToLower(codigo))
                {
                    case 'l':
                        totalLimpeza += preco;
                        break;

                    case 'a':
                        totalAlimentacao += preco;
                        break;

                    case 'h':
                        totalHigiene += preco;
                        break;

                    default:
                        Console.WriteLine("Erro. Código inválido.");
                        break;
                }

                Console.WriteLine();
            }

            Console.WriteLine("Valor total: ");
            Console.WriteLine($"Total Geral da Cesta: R$ {totalGeral:F2}");
            Console.WriteLine($"Total Limpeza: R$ {totalLimpeza:F2}");
            Console.WriteLine($"Total Alimentação: R$ {totalAlimentacao:F2}");
            Console.WriteLine($"Total Higiene: R$ {totalHigiene:F2}");
        }
    }
}

//Exercício 4 - Cenário: Gestão de RH de uma Empresa
