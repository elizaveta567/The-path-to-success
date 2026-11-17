#Задание 1

'''*
   **
   ***
   ****'''


def f(n):
    for i in range(n+1):
        for j in range(i):
            print('*', end='')
        print()
f(5)



#'abbc' - посчитай кол-во букв

def f(n):
    d = {}
    for i in n:
        if i in d.keys():
            d[i]+=1
        else:
            d[i]=1
    return d



#Убираем дубликаты
def f(l):
    new_l = []
    for i in l:
        if i not in new_l:
            new_l.append(i)
    print(new_l)

f([1,1,2,555,5,666,7,7])



#скользящее окно
def f(l, window_size=3):
    for i in range(len(l)-window_size+1):
        n = 0
        for j in range(window_size):
            n+=l[i+j]
        print(n)

f([1,2,3,4,5], window_size=2)



#фибоначчи
def f(n):
    if n==1 or n==0:
        return 1
    else:
        return f(n-1)+f(n-2)

print(f(5))