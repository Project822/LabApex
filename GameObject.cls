public abstract class GameObject
{
    public string Name { get; protected set; }
 
    public GameObject(string name)
    {
        Name = name;
    }
 
    public abstract void ShowInfo();
}
