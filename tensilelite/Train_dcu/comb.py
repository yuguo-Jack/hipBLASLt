from itertools import product

def generate_combinations():
    m = 16
    n = 16
    combinations = []
    for w1 in range(1, 4 + 1):
        for w2 in range(1, 4 + 1):
            permutations = list(product(range(1, m + 1), range(1, n + 1)))
            for tt in permutations:               
                if tt[0] * tt[1] < 49 and w1 * w2 == 4 and tt[0] * w1 < 17 and tt[1] * w2 < 17:
                    combinations.append([tt[0], tt[1], w1, w2])
    return combinations

# m = int(input("请输入第一个整数 m："))
# n = int(input("请输入第二个整数 n："))
combinations_final = generate_combinations()

for combination_final in combinations_final:
    print(f"- [16, 16, 4, 1, 1, {combination_final[0]}, {combination_final[1]}, {combination_final[2]}, {combination_final[3]}]")
