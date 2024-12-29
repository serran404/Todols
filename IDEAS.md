## Idéer för `todols`

---

# HIERARKISK STRUKTUR

(xml fil)

ex:

    KTH:
        Linalg FK
                Plugga föreläsning
                Gör bevis
        PDE
                Labb 2
                kS
        Prutt
                Projektet
                        välj projekt
                        nivå E
                        nivå C
                        nivå A
                Quiz
                        Öva mönster
    Scouter:
        etc
            etc

---

# TAGS

Tanke: namnge tags för varje container

ex: 
    
    Linalg FK [linalg]
        Plugga föreläsning [plugga]

och där plugga loggas som `linalg:plugga`. Man ska kunna komma åt en tag genom nummer och tag och då ska man få ut info:

    DEADLINE: datum
    dir: vilket directory sakerna ligger i
    ingress: kort beskrivning, mål etc

och sen ska man ha ett kommando för att komma direkt till repot.
Om man tar ut info om en todo som har undertodos då ska dessa skrivas ut här också.

Om man väljer att inte ge någon tag kan man ta förälderns tag och lägga till en siffra, e.g. `linalg4` eller inte ha någon tag.
Mindre todos kommer inte behöva en tag.

---

# KORTKOMMANDON

Kortkommandon för att ta bort och lägga till todos.
Det ska finnas olika options för om man vill lägga till en deadline, lägg till nuvarande directory, en kort ingress...
Sen måste man uppge vilken förälder eller todo list som man ska lägga till den på, en tom sådan kan vara en övrigt lista.
För att ta bort kan man ha ett kommando med två val, ta bort eller vara klar, göra grön och en bock.
Därefter kan man ha en tag c eller clear som tar bort alla avklarade saker, de grönmarkerade.
För att ta bort kan kommandot heta done, där ska man kunna ge nummer eller tag.

## LÄGGA TILL TODOS

För att lägga till en todo vill vi specificera vilken förälder vi vill ha, enklast är att specificera tags, ex: todo i [linalg]. Därefter iterera igenom xml filen, om taggen är densamma lägger vi in en ny rad på formen
	`<tag prio="" dir="" text="" dueDate="">Do this</tag>


---

# SESSIONS

Idén är att kunna starta sessions som delar upp terminalen så att vänster eller höger sida är en lista med olika valda todos och en timer, och sen då och då kan man bocka av olika todos eller lägga till flera.
När en session är klar ska man återigen kunna välja vilka todos som är klara.
Man kan exempelvis ha gjort tillräckligt på en todo för en session även om den inte är klar.
När sessionen är igång ska denna todo vara klar men sen måste man välja om den är helt klar eller fortfarande aktuell.
Föräldern till en todo ska visas över, alltså typ:

    Tid: 2h 23min

    Att göra:

    Prutt:
        Gå igenom designmönster [des_monst]
        Öva gammal KS [ks]
    Scouter:
        Maila föräldrar [scout3]
        Logga möten [scout2]

---
