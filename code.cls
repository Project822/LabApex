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
 
//оружия
public class Weapon : GameObject
{
    public int Damage { get; private set; }
    public int Ammo { get; private set; }
    public int MaxAmmo { get; private set; }
 
    public Weapon(string name, int damage, int ammo) : base(name)
    {
        Damage = damage;
        Ammo = ammo;
        MaxAmmo = ammo;
    }
 
    public void Reload()
    {
        Ammo = MaxAmmo;
        Console.WriteLine($"{Name} перезаряжено. Патроны: {Ammo}");
    }
 
    public void Fire(Player target)
    {
        if (Ammo <= 0)
            throw new NoAmmoException();
 
        Ammo--;
        Console.WriteLine($"{Name} стреляет по {target.Name}, урон: {Damage}");
        target.TakeDamage(Damage);
    }
 
    public override void ShowInfo()
    {
        Console.WriteLine($"Оружие {Name}: Урон={Damage}, Патроны={Ammo}/{MaxAmmo}");
    }
 
    public override bool Equals(object obj)
    {
        if (obj is Weapon other)
            return Name == other.Name && Damage == other.Damage;
        return false;
    }
 
    public override int GetHashCode() => (Name, Damage).GetHashCode();
 
    public override string ToString() => $"Оружие: {Name}, Урон={Damage}, Патроны={Ammo}";
}
 
//предметы
public class Item : GameObject, IUsable
{
    public string ItemType { get; private set; }
 
    public Item(string name, string type) : base(name)
    {
        ItemType = type;
    }
    public void Use(Player player)
    {
        if (ItemType.ToLower() == "лечение")
        {
            player.Heal(20);
        }
        else if (ItemType.ToLower() == "патроны")
        {
            player.Weapon?.Reload();
        }
        else
        {
            Console.WriteLine($"{Name} не используется.");
        }
    }
 
    public override void ShowInfo()
    {
        Console.WriteLine($"Предмет {Name}, Тип: {ItemType}");
    }
 
    public override bool Equals(object obj)
    {
        if (obj is Item other)
            return Name == other.Name && ItemType == other.ItemType;
        return false;
    }
 
    public override int GetHashCode() => (Name, ItemType).GetHashCode();
 
    public override string ToString() => $"Предмет: {Name}, Тип={ItemType}";
}
