if exists(select 1 from master.dbo.sysdatabases where name = 'Szkola') drop database Szkola

GO

CREATE DATABASE Szkola

GO

USE Szkola



CREATE TABLE Nauczyciel
    (IDNauczyciela INT
	CONSTRAINT  IDNauczyciela_nn NOT NULL,
	Imie VARCHAR(25),
	Nazwisko VARCHAR(25),
	Telefon VARCHAR(9),
	Email VARCHAR(45),
	CzyAdmin BIT,
	UserLogin VARCHAR(30),
	Haslo VARCHAR(15)
    );
GO

ALTER TABLE Nauczyciel ADD CONSTRAINT IDNauczyciela_pk PRIMARY KEY (IDNauczyciela);

GO



CREATE TABLE Przedmiot

    (IDPrzedmiotu INT

	CONSTRAINT  IDPrzedmiotu_nn NOT NULL,

	Nazwa VARCHAR(50),

    );

GO

ALTER TABLE Przedmiot ADD CONSTRAINT IDPrzedmiotu_pk PRIMARY KEY (IDPrzedmiotu);

GO



CREATE TABLE Klasa

    (IDKlasy INT

	CONSTRAINT  IDKlasy_nn NOT NULL,

	Nazwa VARCHAR(40),

    );

GO

ALTER TABLE Klasa ADD CONSTRAINT IDKlasy_pk PRIMARY KEY (IDKlasy);

GO



CREATE TABLE Opiekun

    (IDOpiekuna INT

	CONSTRAINT  IDOpiekuna_nn NOT NULL,

	Imie VARCHAR(25),

	Nazwisko VARCHAR(25),

	Telefon VARCHAR(9),

	Email VARCHAR(60),

	UserLogin VARCHAR(30),

	Haslo VARCHAR(15),

	ZgodaNaMail BIT,

	ZgodaNaSMS BIT

    );

GO

ALTER TABLE Opiekun ADD CONSTRAINT IDOpiekuna_pk PRIMARY KEY (IDOpiekuna);

GO



CREATE TABLE Uczen

    (IDUcznia INT

	CONSTRAINT  IDUcznia_nn NOT NULL,

	Imie VARCHAR(25),

	Nazwisko VARCHAR(25),

	Pesel VARCHAR(11),

	Telefon VARCHAR(9),

	Email VARCHAR(60),

	UserLogin VARCHAR(40),

	Haslo VARCHAR(15),

	IDOpiekuna INT,

	IDKlasy INT

    );

GO

ALTER TABLE Uczen ADD CONSTRAINT IDUcznia_pk PRIMARY KEY (IDUcznia);

ALTER TABLE Uczen ADD CONSTRAINT IDOpiekuna_fk FOREIGN KEY (IDOpiekuna) REFERENCES Opiekun(IDOpiekuna);

ALTER TABLE Uczen ADD CONSTRAINT IDKlasy_fk FOREIGN KEY (IDKlasy) REFERENCES Klasa(IDKlasy);

GO



CREATE TABLE NauczanaKlasaPrzedmiot

    (IDNauczanaKlasaPrzedmiot INT

	CONSTRAINT  IDNauczanaKlasaPrzedmiot_nn NOT NULL,

	IDNauczyciela INT,

	IDKlasy INT,

	IDPrzedmiotu INT

    );

GO

ALTER TABLE NauczanaKlasaPrzedmiot ADD CONSTRAINT IDNauczanaKlasaPrzedmiot_pk PRIMARY KEY (IDNauczanaKlasaPrzedmiot);

ALTER TABLE NauczanaKlasaPrzedmiot ADD CONSTRAINT IDNauczyciela_fk FOREIGN KEY (IDNauczyciela) REFERENCES Nauczyciel(IDNauczyciela);

ALTER TABLE NauczanaKlasaPrzedmiot ADD CONSTRAINT IDKlasy_fk1 FOREIGN KEY (IDKlasy) REFERENCES Klasa(IDKlasy);

ALTER TABLE NauczanaKlasaPrzedmiot ADD CONSTRAINT IDPrzedmiotu_fk FOREIGN KEY (IDPrzedmiotu) REFERENCES Przedmiot(IDPrzedmiotu);

GO



CREATE TABLE Prog

    (IDProgu INT

	CONSTRAINT  IDProgu_nn NOT NULL,

	ProcentNa2 INT CHECK (ProcentNa2>=0 AND ProcentNa2<=100),

	ProcentNa2_5 INT CHECK (ProcentNa2_5>=0 AND ProcentNa2_5<=100),

	ProcentNa3 INT CHECK (ProcentNa3>=0 AND ProcentNa3<=100),

	ProcentNa3_5 INT CHECK (ProcentNa3_5>=0 AND ProcentNa3_5<=100),

	ProcentNa4 INT CHECK (ProcentNa4>=0 AND ProcentNa4<=100),

	ProcentNa4_5 INT CHECK (ProcentNa4_5>=0 AND ProcentNa4_5<=100),

	ProcentNa5 INT CHECK (ProcentNa5>=0 AND ProcentNa5<=100)

    );

GO

ALTER TABLE Prog ADD CONSTRAINT IDProgu_pk PRIMARY KEY (IDProgu);

GO



CREATE TABLE Test

    (IDTestu INT

	CONSTRAINT  IDTestu_nn NOT NULL,

	Nazwa VARCHAR(25),

	IDNauczyciela INT,


	IDProgu INT,

	IDPrzedmiotu INT,

	DataTestu DATE,

	MaxLiczbaPytan INT,

    );

GO

ALTER TABLE Test ADD CONSTRAINT IDTestu_pk PRIMARY KEY (IDTestu);

ALTER TABLE Test ADD CONSTRAINT IDNauczyciela_fk2 FOREIGN KEY (IDNauczyciela) REFERENCES Nauczyciel(IDNauczyciela);

ALTER TABLE Test ADD CONSTRAINT IDPrzedmiotu_fk2 FOREIGN KEY (IDPrzedmiotu) REFERENCES Przedmiot(IDPrzedmiotu);

ALTER TABLE Test ADD CONSTRAINT IDProgu_fk2 FOREIGN KEY (IDProgu) REFERENCES Prog(IDProgu);


GO



CREATE TABLE Ocena

    (IDOceny INT

	CONSTRAINT  IDOceny_nn NOT NULL,

	IDTestu INT,

	IDUcznia INT,

	Ocena INT CHECK (Ocena=1 OR Ocena=2 OR Ocena=2.5 OR Ocena=3 OR Ocena=3.5 OR Ocena=4 OR Ocena=4.5 OR Ocena=5),

	IDNauczyciela INT,

	IDPrzedmiotu INT,

	DataOtrzymania DATE

    );

GO

ALTER TABLE Ocena ADD CONSTRAINT IDOceny_pk PRIMARY KEY (IDOceny);

ALTER TABLE Ocena ADD CONSTRAINT IDTestu_fk FOREIGN KEY (IDTestu) REFERENCES Test(IDTestu);

ALTER TABLE Ocena ADD CONSTRAINT IDUcznia_fk FOREIGN KEY (IDUcznia) REFERENCES Uczen(IDUcznia);

ALTER TABLE Ocena ADD CONSTRAINT IDNauczyciela_fk3 FOREIGN KEY (IDNauczyciela) REFERENCES Nauczyciel(IDNauczyciela);

ALTER TABLE Ocena ADD CONSTRAINT IDPrzedmiotu_fk1 FOREIGN KEY (IDPrzedmiotu) REFERENCES Przedmiot(IDPrzedmiotu);

GO





CREATE TABLE TestKlasa

    (IDTestKlasa INT

	CONSTRAINT  IDTestKlasa_nn NOT NULL,

	IDTestu INT,

	IDKlasy INT

    );

GO

ALTER TABLE TestKlasa ADD CONSTRAINT IDTestKlasa_pk PRIMARY KEY (IDTestKlasa);

ALTER TABLE TestKlasa ADD CONSTRAINT IDTestu_fk2 FOREIGN KEY (IDTestu) REFERENCES Test(IDTestu);

ALTER TABLE TestKlasa ADD CONSTRAINT IDKlasy_fk2 FOREIGN KEY (IDKlasy) REFERENCES Klasa(IDKlasy);

GO

