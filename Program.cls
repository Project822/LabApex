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
