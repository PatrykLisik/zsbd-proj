from generator import genNauczyciele, genPrzedmioty, genKlasy, genOpiekunowie
from generator import genNauczanaKlasaPrzedmiot, genProg, genTest, genUczniowie


results = []

ilosc_nauczyciel = 10
ilosc_opieknuowie = 8
ilosc_uczniowie = 120
NauczanaKlasaPrzedmiot = 13
ilosc_klas = 4
results.extend(genNauczyciele(ilosc_nauczyciel))
results.extend(genOpiekunowie(ilosc_opieknuowie))
results.extend(genPrzedmioty())
results.extend(genKlasy(ilosc_klas))
results.extend(genNauczanaKlasaPrzedmiot(
    NauczanaKlasaPrzedmiot, ilosc_nauczyciel, ilosc_klas * 3))
results.extend(genProg(0))
results.extend(genTest(6, ilosc_nauczyciel, 1,))
results.extend(genUczniowie(ilosc_uczniowie,
                            ilosc_klas * 3, ilosc_opieknuowie))

with open("dane.sql", 'w') as dane:
    for line in results:
        dane.write(line + "\n")
