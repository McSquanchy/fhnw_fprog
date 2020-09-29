
Listen als Modell

Wie erwähnt sind Listen die zentrale Datenstruktur in der funktionalen Programmierung. 
Listen können verwendet werden um diverse unterschiedliche Datensätze zu modellieren. 
Gesucht sind die Typen für die beschriebenen Daten sowie ein Beispiel. 
Verwenden Sie Kombinationen von Listen, Tuples und den Basic Types.

a.	Börsenkurse
Aktiennamen und deren Dollar Kurse. 

> a :: [(String, Float)]
> a = [("GOOG", 875.92), ("MSFT", 32.85), ("ORCL", 33.75)]

b.	Einkaufsliste
Eine Liste der zu kaufenden Artikel jeweils mit der benötigten Anzahl.

> b :: [(String, Int)]
> b = [("Milch", 5), ("Brot", 8)]

c.	Stundenplan
Für jeden Wochentag eine Abfolge der Module.

> c :: [(String, [String])]
> c = [("Mo", ["fprog", "depa", "uuid"])]

d.	Videothek Datenbank
Für jeden Kunden den Namen und alle ausgeliehenen Filme, jeweils mit der Information, ob der Film bereits wieder zurückgebracht wurde.

> d :: [(String, [(String, Bool)])]
> d = [("Lukas Meier", [("Harry Potter", False), ("Frozen", True)])]
