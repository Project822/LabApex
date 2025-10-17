using System;
using System.Collections;
 
public enum Team
{
    Red,
    Blue
}
public record PlayerStats(string PlayerName, int Kills, int Deaths);
 
public interface IAttackable
{
    void TakeDamage(int amount);
}
 
public interface IUsable
{
    void Use(Player player);
}
 
public class InvalidAbilityException : GameException
{
    public override string Message => "Неверная способность легенды!";
}
