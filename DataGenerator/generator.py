import random as r

roomNrs = [(str(pietro) + "0" + str(pokoj))
           for pietro in range(1, 10)
           for pokoj in range(10)]


def toList(fileToUse):
    lista = [line.strip() for line in open(fileToUse)]
    return lista


meskie = toList("meskie.txt")
zenskie = toList("zenskie.txt")
nazwiska = toList("nazwiska.txt")

print(r.choice(meskie))
