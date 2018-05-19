import random
from random import randint
import string


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
imiona = meskie.extend(zenskie)
print(przedmioty)


def genNauczyciele(howMany):
    ans = []
    imiona_ = [random.choice(meskie) for _ in range(howMany)]
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
            "INSERT INTO Nauczyciel VALUES({},{},{},{},{},{},{},{});"
            .format(id, imie, naz, tel, mail, Czyadm, login, pas)
        )

    return ans
