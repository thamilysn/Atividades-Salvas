//Exercicio 1 - UVV Acadêmico
//Classe professor
public abstract class Professor
{
    protected string nome;
    protected int matricula;
    protected int cargaHoraria;
    protected double beneficio;

    public Professor(string nome, int matricula, int cargaHoraria)
    {
        this.nome = nome;
        this.matricula = matricula;
        this.cargaHoraria = cargaHoraria;
        this.beneficio = 0;
    }

    public abstract void calcularBeneficio();

    public double getBeneficio()
    {
        return beneficio;
    }

    public override string ToString()
    {
        return $"Nome: {nome} | Matrícula: {matricula} | Carga Horária: {cargaHoraria}h | Benefício: R$ {beneficio:F2}";
    }
}

public class ProfDE : Professor
{
    public ProfDE(string nome, int matricula, int cargaHoraria)
        : base(nome, matricula, cargaHoraria)
    {
    }

    public override void calcularBeneficio()
    {
    }

    public override string ToString()
    {
        return $"[ProfDE] {base.ToString()}";
    }
}
