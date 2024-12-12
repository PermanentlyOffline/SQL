CREATE TABLE  Bend(
    id INT PRIMARY KEY,
    ime VARCHAR(50),
    godina_osnovanje INT,
    CONSTRAINT godina_osnovanje CHECK (godina_osnovanje > 1990)
);


CREATE TABLE Muzicar_bend(
    id_muzicar INT DEFAULT -1,
    id_bend INT,
    datum_napustanje DATE,
    PRIMARY KEY(id_muzicar, id_bend),
    FOREIGN KEY(id_muzicar) REFERENCES Muzicar(id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY(id_bend) REFERENCES Bend(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT datum_napustanje_check CHECK (datum_napustanje <= '2024-12-31')
);

CREATE TABLE Ucestvo_festival(
    id_festival INT,
    datum_od DATE,
    id_bend INT,
    den INT,
    vremetraenje_nastap INT DEFAULT 30,
    plata_nastap INT,
    PRIMARY KEY(id_festival, datum_od, id_bend),
    FOREIGN KEY(id_festival, datum_od) REFERENCES Festival_odrzuvanje(id, datum_od) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_bend) REFERENCES Bend(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Bend_zanr(
    id_bend INT,
    zanr varchar(30),
    PRIMARY KEY(id_bend, zanr),
    FOREIGN KEY(id_bend) REFERENCES Bend(id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*На сликата подолу е прикажан дел од ЕР дијаграмот на база на податоци на систем за организација на музички фестивали и концерти.
	
Релационата база е дефинирана преку следните релации: 
Muzicar(id, ime, prezime, datum_ragjanje)
Muzicar_instrument(id_muzicar*, instrument)
Bend(id, ime, godina_osnovanje)
Bend_zanr(id_bend*, zanr)
Nastan(id, cena, kapacitet)
Koncert(id*, datum, vreme)
Festival(id*, ime)
Festival_odrzuvanje(id*, datum_od, datum_do)
Muzicar_bend(id_muzicar*, id_bend*, datum_napustanje)
Ucestvo_festival(id_festival*, datum_od*, id_bend*, den, vremetraenje_nastap, plata_nastap)
Ucestvo_koncert(id_koncert*, id_muzicar*, id_bend*)
Да се напишат соодветните DDL изрази за ентитетните множества, вклучително и мултивредносни атрибути „БЕНД“, „МУЗИЧАР_БЕНД“ и „УЧЕСТВО_ФЕСТИВАЛ“ како и за евентуалните релации кои произлегуваат од истите, доколку треба да бидат 
исполнети следните барања:
Доколку времетраењето на настап не е наведено, потребно е да се пополни со предефинирана вредност од 30 минути
Имињата на жанровите може да имаат максимална должина од 30 карактери
Годината на основање на бендот мора да биде по 1990 година
При бришење на музичар од базата на податоци, информациите за бендовите во кои бил член треба да останат зачувани во базата на податоци со предефинирана вредност за музичар '-1'.
Датумот на напуштање на бенд мора да биде заклучно со крајот на 2024 година
Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип INT. За 
надворешните клучеви за кои не е наведено ограничување за референцијален интегритет се претпоставува каскадна промена и бришење. Конкретните вредности за датум дефинирајте ги како стринг (на пример "2021-08-25").*/
