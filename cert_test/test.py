def f_to_c(f):
    return (f - 32) * 5.0/9.0

def c_to_f(c):
    return c * 9.0/5.0 + 32

def main():
    print("F to C:")
    for f in [32, 68, 100, 212]:
        c = f_to_c(f)
        print(f"{f} F = {c:.2f} C")

    print("\nC to F:")
    for c in [0, 20, 37, 100]:
        f = c_to_f(c)
        print(f"{c} C = {f:.2f} F")

if __name__ == "__main__":
    main()