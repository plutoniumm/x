from sys import argv
from python import Python


def parse_number(num: String) -> DynamicVector[String]:
    digits = DynamicVector[String]()
    for i in range(0, len(num)):
        if String("0123456789").find(num[i]) == -1:
            continue
        digits.push_back(num[i])

    if digits.size < 10:
        for i in range(0, 10 - digits.size):
            digits.push_back("0")
    elif digits.size > 10:
        for i in range(0, digits.size - 10):
            digits.pop_back()
    else:
        pass

    return digits


def main():
    args = argv()
    if len(args) < 2:
        print("Usage: mojo main.mojo long-number")
        return

    num = args[1]
    digits = parse_number(num)

    let np = Python.import_module("numpy")
    let matrix = np.zeros((10, 10))
    for i in range(0, 10):
        digit = atol(digits[i])
        for j in range(0, 10):
            if j == digit:
                matrix.itemset((i, j), 1)
            else:
                matrix.itemset((i, j), 0)

    weights = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])
    eigenvalues = np.linalg.eigvals(matrix)
    result = np.dot(eigenvalues, weights)
    result = String(result).replace(".0", "")
    print(result)
