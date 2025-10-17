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
