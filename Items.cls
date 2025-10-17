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
