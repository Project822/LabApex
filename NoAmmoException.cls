public class NoAmmoException : GameException
{
    public override string Message => "Оружие не имеет патронов!";
}
