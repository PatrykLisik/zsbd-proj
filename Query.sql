USE Szkola

--Znaleźć klasy, w których istnieją uczniowie, którzy napisali test bezbłędnie 
-- a.) z dowolnego przedmiotu
-- b.) z języka angielskiego

--a
SELECT Klasa.Nazwa as Klasy_zdolnych_uczniow 
FROM Klasa ,
(
	SELECT Uczen.IDKlasy FROM Uczen, 
	(
		SELECT Ocena.IDOceny, Ocena.IDPrzedmiotu, Ocena.IDUcznia
		FROM Ocena 
		WHERE Ocena.Ocena = 5
	) wybitni_uczniowie
	WHERE Uczen.IDUcznia IN (wybitni_uczniowie.IDUcznia)
) klasy_zdolnych_uczniow
WHERE klasy_zdolnych_uczniow.IDKlasy = Klasa.IDKlasy

--b
SELECT Klasa.Nazwa as Klasy_zdolnych_uczniow 
FROM Klasa ,
(
	SELECT Uczen.IDKlasy FROM Uczen, 
	(
		SELECT Ocena.IDOceny, Ocena.IDPrzedmiotu, Ocena.IDUcznia
		FROM Ocena 
		WHERE Ocena.Ocena = 5 AND 
			  Ocena.IDPrzedmiotu IN(SELECT Przedmiot.IDPrzedmiotu 
					  FROM Przedmiot 
					  WHERE Przedmiot.Nazwa = 'J. angielski')
	) wybitni_uczniowie
	WHERE Uczen.IDUcznia IN (wybitni_uczniowie.IDUcznia)
) klasy_zdolnych_uczniow
WHERE klasy_zdolnych_uczniow.IDKlasy = Klasa.IDKlasy

--Znaleźć uczniów, którzy dostali piątki z tego samego przedmiotu
SELECT Imie + ' ' + Uczen.Nazwisko as Imie_i_Nazwisko, Przedmiot.Nazwa
FROM Uczen, Przedmiot, 
(
	SELECT Ocena.IDUcznia, X.IDPrzedmiotu
	FROM Ocena,
	(
		SELECT Ocena.IDPrzedmiotu
		FROM Ocena 
		WHERE Ocena.Ocena = 5
		GROUP BY Ocena.IDPrzedmiotu
		HAVING COUNT (Ocena.IDUcznia) >= 2
	) X
	WHERE Ocena.Ocena = 5 AND X.IDPrzedmiotu = Ocena.IDPrzedmiotu
) wybitni_uczniowie
WHERE Uczen.IDUcznia IN (wybitni_uczniowie.IDUcznia) 
      AND Przedmiot.IDPrzedmiotu = wybitni_uczniowie.IDPrzedmiotu

--Pokazać ile ocen dostał każdy uczeń.
SELECT Uczen.IDUcznia, COUNT(Ocena.IDUcznia) as liczba_ocen
FROM Ocena, Uczen 
WHERE Ocena.IDUcznia = Uczen.IDUcznia
GROUP BY Uczen.IDUcznia

--Znaleźć 
--a.) ucznia z średnia arytmetyczna ocen powyżej 4.75
--b.) średnią arytmetyczna każdej klasy (na podstawie średniej ucznia)

SELECT Uczen.Imie + ' ' + Uczen.Nazwisko as imie_i_nazwisko, CONVERT(decimal(3,2), ROUND(AVG(CAST(Ocena.Ocena as decimal(3,2))), 2)) as srednia_ocen
FROM Ocena, Uczen 
WHERE Uczen.IDUcznia = Ocena.IDUcznia
GROUP BY Uczen.Imie + ' ' + Uczen.Nazwisko
HAVING AVG(Ocena.Ocena) > 4.75

--b
SELECT  Klasa.Nazwa, CONVERT(decimal(3,2), ROUND(AVG(CAST(uczniowie.srednia_ocen as decimal(3,2))), 2)) as srednia_klasy
FROM Uczen, Klasa, 
(
	SELECT Ocena.IDUcznia , AVG(Ocena.Ocena) as srednia_ocen
	FROM Ocena 
	GROUP BY Ocena.IDUcznia
) uczniowie
WHERE Klasa.IDKlasy = Uczen.IDKlasy AND 
	  uczniowie.IDUcznia = Uczen.IDUcznia
GROUP BY  Klasa.Nazwa
ORDER BY Klasa.Nazwa ASC

--Policzyć ilu uczniów ma każda klasa
SELECT Klasa.Nazwa, COUNT(Uczen.IDUcznia) as liczba_uczniow_w_klasie
FROM Klasa, Uczen
WHERE Uczen.IDKlasy = Klasa.IDKlasy
GROUP BY Klasa.Nazwa
ORDER BY Klasa.Nazwa

--Znaleźć testy z każdego przedmiotu w klasie z
--najniższa średnią ocen.

SELECT Test.Nazwa as nazwa_testu, 
	   Test.DataTestu, 
	   Przedmiot.Nazwa as nazwa_przedmiotu, 
	   Nauczyciel.Nazwisko as nazwisko_autora 
FROM TestKlasa, Test, Przedmiot, Nauczyciel 
WHERE TestKlasa.IDKlasy = (
							SELECT  TOP 1 Klasa.IDKlasy
							FROM Uczen, Klasa, 
							(
								SELECT Ocena.IDUcznia , AVG(CAST(Ocena.Ocena as decimal(3,2))) as srednia_ocen
								FROM Ocena  
								GROUP BY Ocena.IDUcznia
							) uczniowie
							WHERE Klasa.IDKlasy = Uczen.IDKlasy AND 
								  uczniowie.IDUcznia = Uczen.IDUcznia
							GROUP BY  Klasa.IDKlasy
							ORDER BY AVG(CAST(uczniowie.srednia_ocen as decimal(3,2))) ASC
							)
AND Przedmiot.IDPrzedmiotu = Test.IDPrzedmiotu 
AND Nauczyciel.IDNauczyciela = Test.IDNauczyciela
AND Test.IDTestu = TestKlasa.IDTestu

--Uszeregować uczniów jednej z wybranych klas w kolejności od
--najstarszego do najmłodszego
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id('fn_data_urodzenia_z_peselu') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION fn_data_urodzenia_z_peselu
GO

CREATE FUNCTION fn_data_urodzenia_z_peselu (@pesel nvarchar(11)) RETURNS date
AS
BEGIN
--Bierzemy sobie pierwsze dwie cyfry - to jest rok
DECLARE @int int = SUBSTRING(@pesel,1,2)
DECLARE @date date
    DECLARE @rok int = 1900 + @int;
    --Patrzymy na pierwszą cyfrę miesiąca, może tam być
    --informacja o latach 1800-1899 i 2000-2299
	--sposób z https://pl.wikipedia.org/wiki/PESEL
    SET @int = SUBSTRING(@pesel,3,1)
    IF (@int >= 2 AND @int < 8)
      SET @rok += @int / 2 * 100;
    IF (@int >= 8)
      SET @rok-=100;

    DECLARE @miesiac int = (@int % 2) * 10 + SUBSTRING(@pesel,4,1);

    DECLARE @str varchar(10) = CAST(@rok AS varchar)+
      CASE WHEN @miesiac < 10 THEN '0' ELSE '' END +
      CAST(@miesiac AS varchar) + SUBSTRING(@pesel,5,2);
	IF ISDATE(@str)=1
      SET @date=CAST(@str as date)
  RETURN @date
END
GO

SELECT DISTINCT Uczen.Nazwisko, Uczen.Imie, dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel) as data_urodzenia
FROM Uczen, Klasa
WHERE Uczen.IDKlasy = (
						SELECT Klasa.IDKlasy 
						FROM Klasa 
						WHERE Nazwa = 'A2')
ORDER BY data_urodzenia


--Wyobraź sobie, że nauczyciel jedzie na wycieczkę szkolną z daną klasą.
--Napisz procedurę, która jako argument przyjmie nazwe klasy i wypisze
--numery telefonów uczniów i opiekunów tych uczniów w kolejności
--alfabetycznej w postaci:
--„Uczen: Władysław Jagiełło , telefon ucznia: 15071410, telefon opiekuna:
--123456789”

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'generujKontakty')
DROP PROCEDURE generujKontakty
GO

CREATE PROCEDURE generujKontakty @klasa VARCHAR(2)
AS
BEGIN 
DECLARE  @imieUcznia VARCHAR(25),
		 @nazwiskoUcznia VARCHAR(25), 
		 @telefonUcznia VARCHAR(25),
		 @telefonOpiekuna VARCHAR(25)
	DECLARE kursor CURSOR FOR (
		SELECT Uczen.Imie, Uczen.Nazwisko, Uczen.Telefon, Opiekun.Telefon
		FROM Uczen, Opiekun, Klasa
		WHERE Uczen.IDOpiekuna = Opiekun.IDOpiekuna 
			  AND Uczen.IDKlasy = Klasa.IDKlasy
			  AND Klasa.Nazwa = @klasa)
	OPEN kursor 
		FETCH kursor INTO @imieUcznia, @nazwiskoUcznia, @telefonUcznia, @telefonOpiekuna
		WHILE (@@FETCH_STATUS = 0)
		   BEGIN 
			  PRINT ('Uczen: ' + @imieUcznia + ' ' + @nazwiskoUcznia + 
					 ', Telefon ucznia: ' + @telefonUcznia + 
					 ', Telefon opiekuna: ' + @telefonOpiekuna)
			  FETCH NEXT FROM kursor INTO  @imieUcznia, @nazwiskoUcznia, @telefonUcznia, @telefonOpiekuna
		   END
	CLOSE kursor 
DEALLOCATE kursor 
END
GO

EXEC Szkola..generujKontakty 'A2'
GO

--Odszukaj opiekunów, którzy mają więcej niż jedno dziecko, których dzieci
--chodzą:
--a.) do różnych klas
--b.) do tej samej klasy

SELECT Opiekun.IDOpiekuna, Uczen.IDUcznia 
FROM Opiekun, Uczen
WHERE Uczen.IDOpiekuna = Opiekun.IDOpiekuna 
	  AND Uczen.IDUcznia IN ( SELECT Uczen.IDUcznia 
							  FROM Opiekun, Uczen
							  WHERE Uczen.IDOpiekuna = Opiekun.IDOpiekuna )


 