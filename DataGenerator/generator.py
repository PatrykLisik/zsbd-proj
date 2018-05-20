import random
from random import randint
import string
import itertools
import math
import datetime


def password_generator(size=6, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def random_with_N_digits(n):
    range_start = 10**(n - 1)
    range_end = (10**n) - 1
    return randint(range_start, range_end)


def toList(fileToUse):
    lista = [line.strip() for line in open(fileToUse)]
    return lista


meskie = toList("meskie.txt")
zenskie = toList("zenskie.txt")
nazwiska = toList("nazwiska.txt")
przedmioty = toList("przedmioty.txt")
imiona = meskie
imiona.extend(zenskie)


def genNauczyciele(howMany):
    ans = []
    imiona_ = [random.choice(imiona) for _ in range(howMany)]
    nazwiska_ = [random.choice(nazwiska) for _ in range(howMany)]
    telefony = [random_with_N_digits(9) for _ in range(howMany)]
    Emaile = [i.lower() + n.lower() + "@gmail.com" for i,
              n in zip(imiona_, nazwiska_)]
    # W ostatecznej wersji można dać jakieś 1
    CzyAdmin = [0 for _ in range(howMany)]
    UserLogin = [i.lower() + "_" + n.lower() for i,
                 n in zip(imiona_, nazwiska_)]
    hasla = [password_generator() for _ in range(howMany)]
    ids = list(range(howMany))
    for id, imie, naz, tel, mail,  Czyadm, login, pas in zip(ids, imiona_,
                                                             nazwiska_,
                                                             telefony,
                                                             Emaile,
                                                             CzyAdmin,
                                                             UserLogin,
                                                             hasla):
        ans.append(
            "INSERT INTO Nauczyciel VALUES({},\"{}\",\"{}\",\"{}\",\"{}\",{},\"{}\",\"{}\");"
            .format(id, imie, naz, tel, mail, Czyadm, login, pas)
        )

    return ans


def genPrzedmioty(howMany):
    ans = []
    random.shuffle(przedmioty)
    for id, nazwa_przedmiotu in zip(range(howMany), przedmioty):
        ans.append(
            "INSERT INTO Przedmiot VALUES({},\"{}\");"
            .format(id, nazwa_przedmiotu)
        )
    return ans


def genKlasy(howMany):
    """
    howMany - ilość klas w roczniku
    """
    ans = []
    numberOfYears = 3
    lettes_string = list(string.ascii_uppercase)[:howMany]
    letters = itertools.cycle(lettes_string)
    for id, letter in zip(range(howMany * numberOfYears), letters):
        year = math.floor(id / howMany) + 1
        class_number = letter + str(year)
        ans.append(
            "INSERT INTO Klasa VALUES({},\"{}\");"
            .format(id, class_number)
        )
    return ans


def genOpiekunowie(howMany):
    ans = []
    imiona_ = [random.choice(imiona) for _ in range(howMany)]
    nazwiska_ = [random.choice(nazwiska) for _ in range(howMany)]
    telefony = [random_with_N_digits(9) for _ in range(howMany)]
    Emaile = [i.lower() + n.lower() + "@gmail.com" for i,
              n in zip(imiona_, nazwiska_)]
    # W ostatecznej wersji można dać jakieś 1
    UserLogin = [i.lower() + "_" + n.lower() for i,
                 n in zip(imiona_, nazwiska_)]
    hasla = [password_generator() for _ in range(howMany)]
    ids = list(range(howMany))
    for id, imie, naz, tel, mail, login, pas in zip(ids, imiona_,
                                                    nazwiska_,
                                                    telefony,
                                                    Emaile,
                                                    UserLogin,
                                                    hasla):
        ZgodaNaMail = random.randrange(0, 2)
        ZgodaNaSMS = random.randrange(0, 2)
        ans.append(
            "INSERT INTO Opiekun VALUES({},\"{}\",\"{}\",\"{}\",\"{}\",\"{}\",\"{}\",{},{});"
            .format(id, imie, naz, tel, mail, login, pas, ZgodaNaMail, ZgodaNaSMS)
        )

    return ans


def genUczniowie(howMany, max_class_id, max_opiekun_id):
    ans = []
    imiona_ = [random.choice(imiona) for _ in range(howMany)]
    nazwiska_ = [random.choice(nazwiska) for _ in range(howMany)]
    PESELs = [str(random_with_N_digits(11)) for _ in range(howMany)]
    telefony = [random_with_N_digits(9) for _ in range(howMany)]
    Emaile = [i.lower() + n.lower() + "@gmail.com" for i,
              n in zip(imiona_, nazwiska_)]
    # W ostatecznej wersji można dać jakieś 1
    UserLogin = [i.lower() + "_" + n.lower() for i,
                 n in zip(imiona_, nazwiska_)]
    hasla = [password_generator() for _ in range(howMany)]
    ids = list(range(howMany))
    classIDs = list(range(max_class_id))
    opiekunIds = list(range(max_opiekun_id))
    for id, imie, naz, pesel, tel, mail, login, pas, in zip(ids, imiona_,
                                                            nazwiska_,
                                                            PESELs,
                                                            telefony,
                                                            Emaile,
                                                            UserLogin,
                                                            hasla):
        opID = random.choice(classIDs)
        classID = random.choice(opiekunIds)
        ans.append(
            "INSERT INTO Uczen VALUES({},\"{}\",\"{}\",\"{}\",\"{}\",\"{}\",\"{}\",\"{}\",{},{});"
            .format(id, imie, naz, pesel, tel, mail, login, pas, opID, classID)
        )

    return ans


def genNauczanaKlasaPrzedmiot(howMany, max_id_nauczyciela,
                              max_klass_id, max_przedmiot_id=len(przedmioty)):
    nauczycielIDs = list(range(max_id_nauczyciela))
    klasIDs = list(range(max_klass_id))
    przedmiotIDs = list(range(max_przedmiot_id))
    ans = []
    for id in range(howMany):
        nauczycielID = random.choice(nauczycielIDs)
        klasID = random.choice(klasIDs)
        przedmiotID = random.choice(przedmiotIDs)
        ans.append(
            "INSERT INTO Uczen VALUES({},{},{},{});"
            .format(id, nauczycielID, klasID, przedmiotID)
        )

    return ans


def genProg(nauczyciel_id):
    """
    jeden zahardkodowany próg
    """
    ans = []
    id = 0
    ProcentNa2 = 40
    ProcentNa2_5 = 50
    ProcentNa3 = 55
    ProcentNa3_5 = 60
    ProcentNa4 = 70
    ProcentNa4_5 = 80
    ProcentNa5 = 90
    ans.append(
        "INSERT INTO Prog VALUES({},{},{},{},{},{},{},{},{},{});"
        .format(id, nauczyciel_id, ProcentNa2, ProcentNa2_5,
                ProcentNa3, ProcentNa3, ProcentNa3_5, ProcentNa4,
                ProcentNa4_5, ProcentNa5)
    )
    return ans


def random_date(start=datetime.datetime.now()):
    current = start
    curr = current + \
        datetime.timedelta(days=random.randrange(365),
                           hours=random.randrange(0, 24)
                           )
    return curr


def genTest(howMany, max_id_nauczyciela, max_prog_id, max_przedmiot_id):
    """
    howMany - ilość testów
    """
    ans = []
    nauczycielIDs = list(range(max_id_nauczyciela))
    progIDs = list(range(max_prog_id))
    przedmiotIDs = list(range(max_przedmiot_id))
    id = 0
    for i in range(howMany):
        nazwa = "Test" + str(i)
        IDPrzedmiotu = random.choice(przedmiotIDs)
        IDNauczyciela = random.choice(nauczycielIDs)
        IDProgu = random.choice(progIDs)
        DataTestu = random_date()
        MaxLiczbaPytan = random.randrange(40)
        ans.append(
            "INSERT INTO Prog VALUES({},\"{}\",{},{},{},{},{},);"
            .format(id, nazwa, IDNauczyciela,
                    IDProgu, IDPrzedmiotu, DataTestu, MaxLiczbaPytan)
        )
    return ans


for i in genNauczyciele(10):
    print(i)
