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
 
//классы основные
public class Player : GameObject, IAttackable
{
    public int Health { get; private set; }
    public Weapon Weapon { get; set; }
    public Legend Legend { get; private set; }
    public Team Team { get; private set; }
 
    public Player(string name, Legend legend, Team team) : base(name)
    {
        Health = 100;
        Legend = legend;
        Team = team;
    }
 
    public void Shoot(Player target)
    {
        if (Weapon == null)
        {
            Console.WriteLine($"{Name} не имеет оружия.");
            return;
        }
        Weapon.Fire(target);
    }
 
    public void TakeDamage(int amount)
    {
        Health -= amount;
        if (Health < 0) Health = 0;
        Console.WriteLine($"{Name} получает {amount} урона. HP = {Health}");
    }
 
    public void Heal(int amount)
    {
        Health = Math.Min(100, Health + amount);
        Console.WriteLine($"{Name} восстановил {amount} HP. Текущее HP = {Health}");
    }
 
    public override void ShowInfo()
    {
        Console.WriteLine($"Игрок {Name}, Команда: {Team}, Легенда: {Legend.Name}, HP = {Health}");
    }
 
    public override bool Equals(object obj)
    {
        if (obj is Player other)
            return Name == other.Name && Team == other.Team;
        return false;
    }
 
    public override int GetHashCode() => (Name, Team).GetHashCode();
 
    public override string ToString() => $"Игрок: {Name} ({Team}), HP = {Health}";
}
