from generator import genNauczyciele, genPrzedmioty, genKlasy, genOpiekunowie
from generator import genNauczanaKlasaPrzedmiot, genProg, genTest, genUczniowie
from generator import genOceny, genTestKlasa

results = []

ilosc_nauczyciel = 10
ilosc_opieknuowie = 8
ilosc_uczniowie = 120
NauczanaKlasaPrzedmiot = 13
ilosc_klas = 4
ilosc_ocen = 50
ilosc_test = 10
ilosc_przedmiot = 15
results.extend(genNauczyciele(ilosc_nauczyciel))
results.extend(genOpiekunowie(ilosc_opieknuowie))
results.extend(genPrzedmioty())
results.extend(genKlasy(ilosc_klas))
results.extend(genNauczanaKlasaPrzedmiot(
    NauczanaKlasaPrzedmiot, ilosc_nauczyciel, ilosc_klas * 3))
results.extend(genProg(0))
results.extend(genTest(ilosc_test, ilosc_nauczyciel, 1,))
results.extend(genUczniowie(ilosc_uczniowie,
                            ilosc_klas * 3, ilosc_opieknuowie))
results.extend(genTestKlasa(ilosc_test * 2, ilosc_test, ilosc_klas * 3))
results.extend(genOceny(ilosc_ocen, ilosc_test,
                        ilosc_uczniowie, ilosc_nauczyciel))

with open("dane.sql", 'w') as dane:
    for line in results:
        dane.write(line + "\n")
