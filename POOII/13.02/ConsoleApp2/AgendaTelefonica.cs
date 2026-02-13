using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp2
{
    internal class AgendaTelefonica
    {
        public Dictionary<string, Contato> Agenda { get; set; }

        //public AgendaTelefonica() => Agenda = new Dictionary<string, string>();
        public AgendaTelefonica() => Agenda = [];

        public void Inserir(string nome, Contato c) => Agenda.Add(nome, c);

        //public void inserir(string nome, string numero)
        //{
        //    Agenda.Add(nome, numero);
        //}

        public Contato buscarNumero(string nome) => Agenda[nome];

        public int tamanho() => Agenda.Count;

        public void remover(String nome) => Agenda.Remove(nome);

    }
}
