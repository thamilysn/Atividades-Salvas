using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp2
{
    internal class AgendaTelefonica
    {
        Dictionary<String, String> dictionary = new();

        public void inserir(String nome, String numero)
        {
            dictionary.Add(nome, numero);
        }

        public string buscarNumero(String nome)
        {
            if (dictionary.ContainsKey(nome))
                return dictionary[nome];
            else
                return "Contato não encontrado.";
            }

        public void remover(String nome)
        {
            dictionary.Remove(nome);
        }

        public int tamanho()
        {

        }
    }
}
