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
 
 
public abstract class GameObject
{
    public string Name { get; protected set; }
 
    public GameObject(string name)
    {
        Name = name;
    }
 
    public abstract void ShowInfo();
}
 
 //Дополнительный функционал
 public class GameNotification : Exception
{
    public override string Message => "Объявление!";
}
 
//исключения
public class GameException : Exception
{
    public override string Message => "Произошла игровая ошибка!";
}
 
public class NoAmmoException : GameException
{
    public override string Message => "Оружие не имеет патронов!";
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
 
//Легенда
public class Legend : GameObject
{
    public string[] Abilities { get; private set; }
 
    public Legend(string name, string[] abilities) : base(name)
    {
        Abilities = abilities;
    }
 
    public void UseAbility(int index)
    {
        if (index < 0 || index >= Abilities.Length)
            throw new InvalidAbilityException();
 
        Console.WriteLine($"{Name} использует {Abilities[index]}!");
    }
 
    public override void ShowInfo()
    {
        Console.WriteLine($"Легенда {Name}, Способности:");
        foreach (var ability in Abilities)
            Console.WriteLine($" - {ability}");
    }
 
    public override bool Equals(object obj)
    {
        if (obj is Legend other)
            return Name == other.Name;
        return false;
    }
 
    public override int GetHashCode() => Name.GetHashCode();
 
    public override string ToString() => $"Легенда: {Name}";
}
 
 
class Program
{
    static void Main(string[] args)
    {
 
        Legend revenant = new Legend("Revenant", new string[] { "Заглушение", "Сильная броня" });
        Legend mirage = new Legend("Mirage", new string[] { "Приманка", "Невидимость" });
        Legend krypto = new Legend("Krypto", new string[] { "Дрон", "ЭМИ" });
        Legend fuze = new Legend("Fuze", new string[] { "Кастет", "Напалм" });
        Legend ballistic = new Legend("Ballistic", new string[] { "Пуля", "Буря" });
        Legend octane = new Legend("Octane", new string[] { "Шприц", "Батут" });
        Legend lifeline = new Legend("LifeLine", new string[] { "Целебный Дрон", "Круговой щит" });
        Legend caustic = new Legend("Caustic", new string[] { "Бочка с газом", "Граната с газом" });
        Legend bloodhound = new Legend("Bloodhound", new string[] { "Око", "Охота" });
        Legend pathfinder = new Legend("Pathfinder", new string[] { "Крюк", "Трос" });
        Legend seer = new Legend("Seer", new string[] { "Вуаль", "Сердце" });
        Legend gibraltar = new Legend("Gibraltar", new string[] { "Купол", "Авиаудар" });
 
        Player p1 = new Player("Kaleb", revenant, Team.Blue);
        Player p2 = new Player("Elias", mirage, Team.Blue);
        Player p3 = new Player("Kuroda", krypto, Team.Blue);
        Player p4 = new Player("Yolter", fuze, Team.Blue);
        Player p5 = new Player("Brinkman", ballistic, Team.Blue);
        Player p6 = new Player("Octavio", octane, Team.Blue);
        Player p7 = new Player("Jey", lifeline, Team.Red);
        Player p8 = new Player("Alexander", caustic, Team.Red);
        Player p9 = new Player("Bloody", bloodhound, Team.Red);
        Player p10 = new Player("Bot", pathfinder, Team.Red);
        Player p11 = new Player("Ozar", seer, Team.Red);
        Player p12 = new Player("Mike", gibraltar, Team.Red);
 
        Weapon volt = new Weapon("Volt", 30, 20);
        Weapon p2020 = new Weapon("P2020", 35, 10);
        Weapon hemlock = new Weapon("Hemlock", 35, 25);
        Weapon peacekeeper = new Weapon("Peacekeeper", 45, 5);
        Weapon spitfire = new Weapon("Spitfire", 30, 30);
        Weapon kraber = new Weapon("Kraber", 35, 5);
        Weapon mastiff = new Weapon("Mastiff", 60, 5);
        Weapon eva = new Weapon("Eva", 40, 10);
        Weapon flatline = new Weapon("Flatline", 35, 30);
        Weapon sentinel = new Weapon("Sentinel", 60, 5);
        Weapon alternator = new Weapon("Alternator", 30, 25);
        Weapon nemesis = new Weapon("Nemesis", 40, 30);

        p1.Weapon = volt;
        p2.Weapon = p2020;
        p3.Weapon = hemlock;
        p4.Weapon = peacekeeper;
        p5.Weapon = spitfire;
        p6.Weapon = kraber;
        p7.Weapon = mastiff;
        p8.Weapon = eva;
        p9.Weapon = flatline;
        p10.Weapon = sentinel;
        p11.Weapon = nemesis;
        p12.Weapon = alternator;
 
 
        Item medkit = new Item("Аптечка", "лечение");
        Item ammoBox = new Item("Коробка патрон", "патроны");
 
 
        Player[] players = { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12 };
 
        Console.WriteLine("Начало боя\n");
 
 
        for (int i = 0; i < players.Length; i++)
        {
            Player shooter = players[i];
            Player target = players[(i + 1) % players.Length];
            shooter.Shoot(target);
        }
 
        Console.WriteLine("\n Используем предметы \n");
        medkit.Use(p1);
        medkit.Use(p2);
        medkit.Use(p3);
        ammoBox.Use(p6);
 
        Console.WriteLine("\nЛегенды используют способности\n");
        foreach (var legendPlayer in players)
        {
            legendPlayer.Legend.UseAbility(0);
        }
 
        Console.WriteLine("\nКонец боя");
    }
}
