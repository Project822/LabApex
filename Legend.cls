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
