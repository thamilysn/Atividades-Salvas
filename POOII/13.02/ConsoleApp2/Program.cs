namespace ConsoleApp2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            AgendaTelefonica ag = new();

            ag.Inserir("Vinicius", new Contato("Vinicius", "123", 28));
            ag.Inserir("Vinicius", new Contato("Rosalen", "456", 29));
            ag.Inserir("Vinicius", new Contato("Silva", "789", 30));

            Console.WriteLine($"Quantidade de contatos armazenados: {ag.tamanho()}");
            Console.WriteLine($"O numero do telefone do Vinicius é {ag.buscarNumero("Vinicius").numero}");

        }
    }
}
