USE Szkola

--Znale¼æ klasy, w których istniej± uczniowie, którzy napisali test bezb³êdnie 
-- a.) z dowolnego przedmiotu
-- b.) z jêzyka angielskiego

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

--Znale¼æ uczniów, którzy dostali pi±tki z tego samego przedmiotu
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

--Pokazaæ ile ocen dosta³ ka¿dy uczeñ.
SELECT Uczen.IDUcznia, COUNT(Ocena.IDUcznia) as liczba_ocen
FROM Ocena, Uczen 
WHERE Ocena.IDUcznia = Uczen.IDUcznia
GROUP BY Uczen.IDUcznia

--Znale¼æ 
--a.) ucznia z ¶rednia arytmetyczna ocen powy¿ej 4.75
--b.) ¶redni± arytmetyczna ka¿dej klasy (na podstawie ¶redniej ucznia)

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

--Policzyæ ilu uczniów ma ka¿da klasa
SELECT Klasa.Nazwa, COUNT(Uczen.IDUcznia) as liczba_uczniow_w_klasie
FROM Klasa, Uczen
WHERE Uczen.IDKlasy = Klasa.IDKlasy
GROUP BY Klasa.Nazwa
ORDER BY Klasa.Nazwa

--Znale¼æ testy z ka¿dego przedmiotu w klasie z
--najni¿sza ¶redni± ocen.

SELECT Test.Nazwa as nazwa_testu, 
	   Test.DataTestu, 
	   Przedmiot.Nazwa as nazwa_przedmiotu, 
	   Nauczyciel.Nazwisko as nazwisko_autora 
FROM TestKlasa, Test, Przedmiot, Nauczyciel 
WHERE TestKlasa.IDKlasy = (
							SELECT  TOP 1 Klasa.IDKlasy
							FROM Uczen, Klasa, 
							(
								SELECT Ocena.IDUcznia , AVG(Ocena.Ocena) as srednia_ocen
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

