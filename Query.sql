﻿USE Szkola

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

--a
SELECT DISTINCT Opiekun.Nazwisko 
FROM Opiekun, (
				SELECT opiekunowie_wielodzietni.IDOpiekuna, Klasa.Nazwa, COUNT(Uczen.IDUcznia) as liczba_dzieci_w_klasie
				FROM Klasa, Uczen, (
									--Wybieramy rodziców, ktorzy mają więcej niż jedno dziecko
									SELECT Opiekun.IDOpiekuna
									FROM Opiekun, Uczen
									WHERE Uczen.IDOpiekuna = Opiekun.IDOpiekuna
									GROUP BY Opiekun.IDOpiekuna
									HAVING COUNT(Uczen.IDUcznia) >= 2
									) opiekunowie_wielodzietni
				WHERE Uczen.IDKlasy = Klasa.IDKlasy AND opiekunowie_wielodzietni.IDOpiekuna = Uczen.IDOpiekuna
				GROUP BY opiekunowie_wielodzietni.IDOpiekuna, Klasa.Nazwa
				HAVING COUNT(Uczen.IDUcznia) = 1
				) id_opiekunow
WHERE id_opiekunow.IDOpiekuna = Opiekun.IDOpiekuna
ORDER BY Opiekun.Nazwisko


--b
SELECT DISTINCT Opiekun.Nazwisko 
FROM Opiekun, (
				SELECT opiekunowie_wielodzietni.IDOpiekuna, Klasa.Nazwa, COUNT(Uczen.IDUcznia) as liczba_dzieci_w_klasie
				FROM Klasa, Uczen, (
									--Wybieramy rodziców, ktorzy mają więcej niż jedno dziecko
									SELECT Opiekun.IDOpiekuna
									FROM Opiekun, Uczen
									WHERE Uczen.IDOpiekuna = Opiekun.IDOpiekuna
									GROUP BY Opiekun.IDOpiekuna
									HAVING COUNT(Uczen.IDUcznia) >= 2
									) opiekunowie_wielodzietni
				WHERE Uczen.IDKlasy = Klasa.IDKlasy AND opiekunowie_wielodzietni.IDOpiekuna = Uczen.IDOpiekuna
				GROUP BY opiekunowie_wielodzietni.IDOpiekuna, Klasa.Nazwa
				HAVING COUNT(Uczen.IDUcznia) >= 2
				) id_opiekunow
WHERE id_opiekunow.IDOpiekuna = Opiekun.IDOpiekuna
ORDER BY Opiekun.Nazwisko

--W każdej klasie oblicz liczbę uczniów zasługujących na świadectwo z
--czerwonym paskiem (średnia większa, równa 4.75) oraz takich którzy nie
--zdają do następnej klasy (średnia poniżej 2.0)
--Wypisz tych uczniów i ich średnią 

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id('fn_slaby_czy_dobry_uczen') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION fn_slaby_czy_dobry_uczen
GO

CREATE FUNCTION fn_slaby_czy_dobry_uczen (@srednia decimal(3,2)) RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @feedback VARCHAR(25)
	IF (@srednia >= 4.75)
		SET @feedback = 'czerwony pasek'
	ELSE IF (@srednia < 2.0)
		SET @feedback = 'uczeń bez promocji'
RETURN @feedback
END
GO

SELECT Uczen.Nazwisko, Uczen.Imie, Klasa.Nazwa as klasa,
	   CONVERT(decimal(3,2), ROUND(AVG(CAST(Ocena.Ocena as decimal(3,2))), 2)) as srednia,
	   dbo.fn_slaby_czy_dobry_uczen(AVG(CAST(Ocena.Ocena as decimal(3,2)))) as informacja_zwrotna
FROM Ocena, Uczen, Klasa
WHERE Uczen.IDUcznia = Ocena.IDUcznia AND Klasa.IDKlasy = Uczen.IDKlasy
GROUP BY Uczen.Nazwisko, Uczen.Imie, Klasa.Nazwa
HAVING AVG(CAST(Ocena.Ocena as decimal(3,2))) >= 4.75 OR AVG(CAST(Ocena.Ocena as decimal(3,2))) < 2.0
ORDER BY Klasa.Nazwa

--Napisz procedurę, która pozwoli na podwyższenie lub obniżenie progu z
--testu na konkretną ocenę. Procedura powinna przyjmować jako argumenty:
--idTestu, ocena, nowy próg punktowy w procentach.

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'zmianaProgu')
DROP PROCEDURE zmianaProgu
GO

CREATE PROCEDURE zmianaProgu @idTestu INT, @ocena INT, @nowyProg INT
AS
BEGIN 
BEGIN TRY
	IF (@ocena = 2)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa2 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE IF (@ocena = 2.5)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa2_5 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE IF (@ocena = 3)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa3 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE IF (@ocena = 3.5)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa3_5 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE IF (@ocena = 4.0)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa4 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE IF (@ocena = 4.5)
	BEGIN 
		UPDATE Prog 
		SET Prog.ProcentNa4_5 = @nowyProg 
		FROM Test
		WHERE Prog.IDProgu = Test.IDProgu
	END
	ELSE 
	BEGIN
		RAISERROR('Nie ma takiej oceny',16,1); 
	END 
END TRY
BEGIN CATCH
	DECLARE @msg NVARCHAR(4000) =   ERROR_MESSAGE();
	DECLARE @severity tinyint =   ERROR_SEVERITY();
	DECLARE @state tinyint =   ERROR_STATE();

	RAISERROR (@msg,@severity,@state);
END CATCH
		 

END
GO

select Prog.* from Test,Prog where Prog.IDProgu = Test.IDProgu AND Test.IDTestu = 0
EXEC Szkola..zmianaProgu 0, 7, 45
GO
select Prog.* from Test,Prog where Prog.IDProgu = Test.IDProgu AND Test.IDTestu = 0

--Znaleźć nauczycieli, którzy są jednocześnie opiekunami 
--(zakładając że mają po prostu to samo nazwisko).

SELECT Nauczyciel.Nazwisko, Uczen.IDUcznia
FROM Nauczyciel, Opiekun, Uczen
WHERE Nauczyciel.Nazwisko = Opiekun.Nazwisko AND
	  Uczen.IDOpiekuna = Opiekun.IDOpiekuna 

--Sprawdź czy to prawda że dzieci nauczycieli mają wyższe oceny niż inne dzieci
SELECT CONVERT(decimal(3,2), ROUND(AVG(CAST(uczniowie.srednia as decimal(3,2))), 2)) as srednia,
	   'srednia dzieci nauczycieli' as informacja
FROM Nauczyciel, Opiekun, Uczen,
		 (
		 SELECT Uczen.IDUcznia,
		 CONVERT(decimal(3,2), ROUND(AVG(CAST(Ocena.Ocena as decimal(3,2))), 2)) as srednia
		 FROM Ocena, Uczen
		 WHERE Uczen.IDUcznia = Ocena.IDUcznia
		 GROUP BY Uczen.IDUcznia
		 ) uczniowie				
WHERE Nauczyciel.Nazwisko = Opiekun.Nazwisko AND
	  Uczen.IDOpiekuna = Opiekun.IDOpiekuna AND 
	  uczniowie.IDUcznia = Uczen.IDUcznia
UNION
SELECT CONVERT(decimal(3,2), ROUND(AVG(CAST(uczniowie.srednia as decimal(3,2))), 2)),
	   'srednia dzieci nie nauczycieli'
FROM Nauczyciel, Opiekun, Uczen,
		 (
		 SELECT Uczen.IDUcznia,
			CONVERT(decimal(3,2), ROUND(AVG(CAST(Ocena.Ocena as decimal(3,2))), 2)) as srednia
	FROM Ocena, Uczen
	WHERE Uczen.IDUcznia = Ocena.IDUcznia
	GROUP BY Uczen.IDUcznia
	) uczniowie
							
WHERE Nauczyciel.Nazwisko != Opiekun.Nazwisko AND
	  Uczen.IDOpiekuna = Opiekun.IDOpiekuna AND 
	  uczniowie.IDUcznia = Uczen.IDUcznia

	--NIEPRAWDA - POGEOMCY MITÓW OBALILI KOLEJNY PRZESĄD

--Znajdź nauczycieli, którzy uczą w szkole 
--b) tylko jednego przedmiotu 
--a) więcej niż jednego przedmiotu

--b
SELECT Nauczyciel.Nazwisko, COUNT(Przedmiot.Nazwa) as liczba_przedmiotow
FROM Przedmiot, Nauczyciel, NauczanaKlasaPrzedmiot
WHERE Nauczyciel.IDNauczyciela = NauczanaKlasaPrzedmiot.IDNauczyciela AND 
	  NauczanaKlasaPrzedmiot.IDPrzedmiotu = Przedmiot.IDPrzedmiotu
GROUP BY Nauczyciel.Nazwisko
EXCEPT 
SELECT Nauczyciel.Nazwisko, COUNT(Przedmiot.Nazwa) as liczba_przedmiotow
FROM Przedmiot, Nauczyciel, NauczanaKlasaPrzedmiot
WHERE Nauczyciel.IDNauczyciela = NauczanaKlasaPrzedmiot.IDNauczyciela AND 
	  NauczanaKlasaPrzedmiot.IDPrzedmiotu = Przedmiot.IDPrzedmiotu
GROUP BY Nauczyciel.Nazwisko
HAVING (COUNT(Przedmiot.Nazwa)) >= 2

--a
SELECT Nauczyciel.Nazwisko, COUNT(Przedmiot.Nazwa) as liczba_przedmiotow
FROM Przedmiot, Nauczyciel, NauczanaKlasaPrzedmiot
WHERE Nauczyciel.IDNauczyciela = NauczanaKlasaPrzedmiot.IDNauczyciela AND 
	  NauczanaKlasaPrzedmiot.IDPrzedmiotu = Przedmiot.IDPrzedmiotu
GROUP BY Nauczyciel.Nazwisko
HAVING (COUNT(Przedmiot.Nazwa)) >= 2

--Dla wybranego testu pokaż ilu uczniów dostało jaką ocenę z tego testu.
SELECT Test.Nazwa, Przedmiot.Nazwa, Ocena.Ocena, Uczen.Nazwisko
FROM Test, Przedmiot, Ocena, Uczen
WHERE Test.IDPrzedmiotu = Przedmiot.IDPrzedmiotu AND
	  Test.IDTestu = Ocena.IDTestu AND
	  Uczen.IDUcznia = Ocena.IDUcznia AND 
	  Test.Nazwa = 'Test0'

--Wypisać wszystkich uczniów którzy nie zaliczyli 
-- a) przynajmniej 1 testu
-- b) tego samego testu

--a 
SELECT Uczen.Nazwisko, Test.Nazwa
FROM Uczen, Test, Ocena
WHERE Uczen.IDUcznia = Ocena.IDUcznia AND
	  Test.IDTestu = Ocena.IDTestu AND
	  Ocena.Ocena < 2
--b)
SELECT Test.Nazwa, Uczen.Nazwisko
FROM Test, Uczen, Ocena
WHERE Uczen.IDUcznia = Ocena.IDUcznia AND
	  Test.IDTestu = Ocena.IDTestu AND
	  Ocena.Ocena < 2 AND
	  Test.IDTestu = (
						SELECT Test.IDTestu
						FROM Uczen, Test, Ocena
						WHERE Uczen.IDUcznia = Ocena.IDUcznia AND
							  Test.IDTestu = Ocena.IDTestu AND
							  Ocena.Ocena < 2
						GROUP BY Test.IDTestu
						HAVING COUNT(Uczen.IDUcznia) >= 2
					 )
	
--Wypisać opiekuna, którego
--a) dziecko urodziło się w pierwszej połowie stycznia 97 roku

SELECT DISTINCT Opiekun.IDOpiekuna, Opiekun.Nazwisko 
FROM Opiekun, Uczen
WHERE Opiekun.IDOpiekuna = Uczen.IDOpiekuna AND
	  MONTH(dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel)) = 1 AND
	  YEAR(dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel)) = 1997 AND 
	  DAY(dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel)) >= 1 AND 
	  DAY(dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel)) <= 16

--LUB

SELECT DISTINCT Opiekun.IDOpiekuna, Opiekun.Nazwisko 
FROM Opiekun, Uczen
WHERE Opiekun.IDOpiekuna = Uczen.IDOpiekuna AND
	  dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel) >= '1/1/1997' AND
	  dbo.fn_data_urodzenia_z_peselu(Uczen.Pesel) <= '1/16/1997'

--Odnaleźć test z 
--a.) największą i najmniejszą liczbą pytań 
--b.) największą i największą liczbą pytań

--a
SELECT Test.Nazwa
FROM Test 
WHERE MaxLiczbaPytan = ( SELECT MAX(Test.MaxLiczbaPytan) as maksymalna_liczba_pytan FROM Test)
--b
SELECT Test.Nazwa
FROM Test 
WHERE MaxLiczbaPytan = ( SELECT MIN(Test.MaxLiczbaPytan) as maksymalna_liczba_pytan FROM Test)

GO
--Procedura która dodaje nową ocenę do bazy i wstawia aktualną datę jako datę otrzymania

--drop procedure dodanieOceny
CREATE PROCEDURE dodanieOceny @idTestu INT, @idUcznia INT, @ocena INT, @idNauczyciela INT, @idPrzedmiotu INT
AS
BEGIN 
BEGIN TRY
	IF (@ocena = 2 or @ocena = 2.5 or @ocena = 3 or @ocena = 3.5 or @ocena = 4 or @ocena = 4.5 or @ocena = 5)
	BEGIN 
		DECLARE @a INT
		select @a = max(IDOceny) from Ocena
		INSERT INTO Ocena (IDOceny, IDTestu, IDUcznia, Ocena, IDNauczyciela, IDPrzedmiotu, DataOtrzymania)
		VALUES (@a+1, @idTestu, @idUcznia, @ocena, @idNauczyciela, @idPrzedmiotu, GETDATE())
	END
	ELSE 
	BEGIN
	RAISERROR('Nie ma takiej oceny!',16,1); 
	END 
END TRY
BEGIN CATCH
	DECLARE @msg NVARCHAR(4000) =   ERROR_MESSAGE();
	DECLARE @severity tinyint =   ERROR_SEVERITY();
	DECLARE @state tinyint =   ERROR_STATE();

	RAISERROR (@msg,@severity,@state);
END CATCH
END
GO

--select * from Ocena
--exec dodanieOceny 1, 2, 3.5, 0, 4
--select * from Ocena


--Funkcja która pokazuje kto uczy jakich przedmiotów lub klas
--parametry: ID nauczyciela; wybór k - klasa; p - przedmiot
-- Podaje imię i nazwisko nauczyciela oraz listę klas lub przedmiotów jak string

--drop FUNCTION fn_nauczyciel_jakie_przedmioty_i_klasy
CREATE FUNCTION fn_nauczyciel_jakie_przedmioty_i_klasy (@id int, @wybor varchar(1)) RETURNS varchar(200)
AS
BEGIN
	DECLARE @imie varchar (25)
	DECLARE @nazwisko varchar (25)

	select @imie = Imie from Nauczyciel where IDNauczyciela=@id
	select @nazwisko = Nazwisko from Nauczyciel where IDNauczyciela=@id

	DECLARE @str varchar (200)
	set @str = @imie+ ' ' + @nazwisko
	DECLARE @result NVARCHAR(MAX)

	if @wybor='k' or @wybor ='K'
	BEGIN
		if (select count(IDKlasy) FROM NauczanaKlasaPrzedmiot WHERE IDNauczyciela = @id) = 0
			set @str = @str +' nie uczy zadnej klasy.'
		else
		BEGIN
			set @str = @str +' uczy nastepujace klasy: '

			SELECT @result = STUFF(
                        (   SELECT ', ' + CONVERT(NVARCHAR(20), Nazwa) 
                            FROM Klasa 
                            WHERE IDKlasy IN (SELECT IDKlasy from NauczanaKlasaPrzedmiot where IDNauczyciela = @id) 
                            FOR xml path('')
                        )
                        , 1
                        , 1
                        , '')
			set @str = @str + @result
		END
	END
	ELSE IF @wybor='p' or @wybor='P'
	BEGIN
		if (select count(IDPrzedmiotu) FROM NauczanaKlasaPrzedmiot WHERE IDNauczyciela = @id) = 0
			set @str = @str +' nie uczy zadnego przedmiotu.'
		else
		BEGIN
			set @str = @str +' uczy nastepujacych przedmiotow: '
			SELECT @result = STUFF(
                        (   SELECT ', ' + CONVERT(NVARCHAR(20), Nazwa) 
                            FROM Przedmiot 
                            WHERE IDPrzedmiotu IN (SELECT IDPrzedmiotu from NauczanaKlasaPrzedmiot where IDNauczyciela = @id) 
                            FOR xml path('')
                        )
                        , 1
                        , 1
                        , '')
			set @str = @str + @result
		END
	END
	ELSE
		SET @str = 'Wybierz k lub p!'

	RETURN @str
END
GO

--declare @b varchar (200)
--exec @b = fn_nauczyciel_jakie_przedmioty_i_klasy 1, 'p'
--select @b


--Wyświetlić klasę i liczbę testów które jej uczniowie pisali od początku:
-- a) aktualnego miesiąca
-- b) początku roku szkolnego

--a
SELECT Klasa.Nazwa as NazwaKlasy, COUNT(TestKlasa.IDTestu) as LiczbaTestowTenMiesiac
from Klasa, TestKlasa, Test
where Klasa.IDKlasy=TestKlasa.IDKlasy
AND Test.IDTestu=TestKlasa.IDTestu
AND MONTH(Test.DataTestu)= MONTH(getdate())
AND YEAR(Test.DataTestu)= YEAR(getdate())
GROUP BY Klasa.Nazwa

--b
SELECT Klasa.Nazwa as NazwaKlasy, COUNT(TestKlasa.IDTestu) as LiczbaTestowOdPoczatkuRoku
from Klasa, TestKlasa, Test
where Klasa.IDKlasy=TestKlasa.IDKlasy
AND Test.IDTestu=TestKlasa.IDTestu
AND (
		(MONTH(Test.DataTestu) > 0 AND MONTH(Test.DataTestu) < 9 AND MONTH(getdate()) > 0 AND MONTH(getdate()) < 9 
		AND YEAR(Test.DataTestu)= YEAR(getdate()) )
		OR
		(MONTH(Test.DataTestu) > 9 AND MONTH(Test.DataTestu) < 12 AND MONTH(getdate()) > 9 AND MONTH(getdate()) < 12 
		AND YEAR(Test.DataTestu)= YEAR(getdate()) )
		OR
		(MONTH(Test.DataTestu) > 9 AND MONTH(Test.DataTestu) < 12 AND MONTH(getdate()) > 0 AND MONTH(getdate()) < 9 
		AND YEAR(Test.DataTestu)= YEAR(getdate())-1 )
	)
GROUP BY Klasa.Nazwa
GO

--wyzwalacze

--zamiast usuniecia ucznia wypelnia jego dane nullami zeby nie bylo konfliktu z innymi tabelami
--oraz kpiuje czesc danych do tabeli archiwum

--drop trigger tt_CopyToArchive
create trigger tt_CopyToArchive
on Uczen instead of delete
as
insert INTO UczenArchiwum (IDUcznia, Imie, Nazwisko, Pesel, IDOpiekuna, IDKlasy)
select IDUcznia, Imie, Nazwisko, Pesel, IDOpiekuna, IDKlasy from deleted

declare @a int
select @a = IDUcznia from deleted
update Uczen
set Imie =null, Nazwisko=null, Pesel=null, Email=null, Telefon=null, UserLogin=null, Haslo=null
where IDUcznia = @a
UPDATE UczenArchiwum
set DataUsuniecia = getdate()
where IDUcznia = @a
GO

--select * from Uczen where IDUcznia =4
--select * from UczenArchiwum where IDUcznia = 4
--DELETE FROM Uczen where IDUcznia = 4
--select * from Uczen where IDUcznia =4
--select * from UczenArchiwum where IDUcznia = 4


--wyzwalacz ktory nie pozwoli zmienic hasla nauczyciela jesli
--nie spelnia wymogu: min. 8 znakow

create trigger tt_psw_constraint1
on Nauczyciel after update
as
DECLARE @haslo varchar(15)
DECLARE @id int
SELECT @haslo = Haslo from inserted
SELECT @id = IDNauczyciela from inserted
if LEN(@haslo)<8
BEGIN
	SELECT 'Haslo musi miec co najmniej 8 znakow dlugosci!'
	update Nauczyciel
	set Haslo = (select Haslo from deleted where IDNauczyciela = @id)
	where IDNauczyciela = @id
END
GO



--wyzwalacz ktory nie pozwoli zmienic hasla ucznia jesli
--nie spelnia wymogu: min. 1 duża litera i jedna cyfra

create trigger tt_psw_constraint2
on Uczen after update
as
DECLARE @haslo varchar(15)
DECLARE @id int
SELECT @haslo = Haslo from inserted
SELECT @id = IDUcznia from inserted
if @haslo NOT LIKE '%[A-Z]%' OR @haslo NOT LIKE '%[1-9]%'
BEGIN
	SELECT 'Haslo musi zawierac jedna duza litere i jedna cyfre'
	update Uczen
	set Haslo = (select Haslo from deleted where IDUcznia = @id)
	where IDUcznia = @id
END
GO

--select * from Uczen where IDUcznia = 1
--update Uczen
--set Haslo ='bb5bbCbi'
--where IDUcznia = 1
--select * from Uczen where IDUcznia = 1


--//////////////////////////////////////////////--


--Wyświetl nauczycieli, którzy uczą w każdej klasie
--przynajmniej jednego przedmiotu.

SELECT Nazwisko FROM Nauczyciel
WHERE NOT EXISTS
	(SELECT * FROM Klasa
	WHERE NOT EXISTS
		(SELECT * FROM NauczanaKlasaPrzedmiot
		WHERE NauczanaKlasaPrzedmiot.IDKlasy=Klasa.IDKlasy
		AND NauczanaKlasaPrzedmiot.IDNauczyciela=Nauczyciel.IDNauczyciela))


--Znaleźć klasy, w których nie istnieje żaden uczeń, który nie posiada
--numeru telefonu i jego opiekun nie wyraził zgody na wysyłanie
--wiadomości email i sms
SELECT Nazwa from Klasa
WHERE NOT EXISTS
	(SELECT * FROM Uczen
	WHERE Telefon is null
	AND Uczen.IDKlasy=Klasa.IDKlasy
	AND NOT EXISTS
	(SELECT * FROM Opiekun
	WHERE ZgodaNaMail = 0
	AND ZgodaNaSMS = 0
	AND Opiekun.IDOpiekuna = Uczen.IDUcznia)
	)


--Znaleźć uczniów którzy we WSZYSTKICH testach dostali ocenę 4 lub wyższą 

SELECT * FROM Uczen
WHERE NOT EXISTS
	(SELECT * FROM Ocena
	WHERE Ocena < 4
	AND Ocena.IDUcznia = Uczen.IDUcznia)
AND Uczen.IDUcznia IN
	(SELECT IDUcznia FROM Ocena)


--Znaleźć wszystkich opiekunów którzy mają wyłącznie uczniów o średniej 4.0 i większej

SELECT * FROM Opiekun
WHERE NOT EXISTS
	(SELECT * FROM Uczen
	WHERE ((SELECT SUM (IDUcznia) FROM Ocena
			WHERE Uczen.IDUcznia=Ocena.IDUcznia)
			/(SELECT COUNT (IDUcznia) FROM Ocena WHERE Uczen.IDUcznia=Ocena.IDUcznia) < 4.0
			OR Uczen.IDUcznia NOT IN (SELECT IDUcznia FROM Ocena)
			)
	AND Opiekun.IDOpiekuna=Uczen.IDOpiekuna
	)

--Wypisać jakie testy każda klasa będzie miała w nadchodzącym miesiącu.
--Wyniki ułożyć najpierw wzgędem klas, potem przedmiotów, potem daty w
--której test się odbędzie (od najbliższych).

SELECT Klasa.Nazwa as Klasa, Test.Nazwa as Test FROM Klasa, Test, TestKlasa, Przedmiot
WHERE Klasa.IDKlasy = TestKlasa.IDKlasy
AND Test.IDTestu = TestKlasa.IDTestu
AND Przedmiot.IDPrzedmiotu = Test.IDPrzedmiotu
AND MONTH(Test.DataTestu) = MONTH(getdate())+1
AND YEAR(Test.DataTestu) = YEAR(getdate())
ORDER BY Klasa.Nazwa, Przedmiot.Nazwa, Test.DataTestu

--select * from Test where MONTH(Test.DataTestu) = MONTH(getdate())+1
go

--rozmyte

alter table Uczen
add sound varchar (10)
select * from Uczen

go
create trigger tt_rozmyte on Uczen
for insert 
as
declare @personid int;
select @personid=IDUcznia from inserted;
update Uczen
set sound=soundex(Imie) where IDUcznia=@personid;

go
create procedure getfuzzi(@personid int)
         as
         declare @sound varchar(10)
         select @sound= sound from Uczen where IDUcznia=@personid
         select IDUcznia,Imie,Nazwisko from Uczen
         where sound=@sound

exec getfuzzi 200

select * from Uczen where IDUcznia = 200

INSERT INTO Uczen (IDUcznia, Imie, Nazwisko, Pesel, Telefon, Email, UserLogin, Haslo, IDOpiekuna, IDKlasy)
Values(205, 'Krzysgtar', 'Kazdepka', '97041809251', '664705778', 'jan@gmail.com','janek', 'zupa123', 5, 6)
