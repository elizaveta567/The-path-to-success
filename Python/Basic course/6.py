# Приветствие из функции
#
# Напишите greet(name): функция принимает имя строкой и возвращает приветствие, например
# 'Привет, Илья!'. Сохраните запятую, пробел и восклицательный знак. Для проверки выведите
# результат снаружи функции.
#
# Проверьте себя:
# greet('Илья') → 'Привет, Илья!'; greet('Анна') → 'Привет, Анна!'.

def greet(name):
    return f'Привет, {name}!'

# Запустите после того, как допишете функцию.
print(greet('Илья'))






# Квадрат числа
#
# Напишите square(number): функция принимает целое или дробное число и возвращает его
# квадрат через return.
#
# Проверьте себя:
# square(7) → 49; square(-3) → 9; square(0) → 0.

def square(number):
    return number**2

# Запустите после того, как допишете функцию.
print(square(7))
print(square(-3))




# Функция чётности
#
# Напишите is_even(number): функция принимает целое число и возвращает True, если оно
# чётное, иначе — False. Верните логическое значение, без кавычек.
#
# Проверьте себя:
# is_even(42) → True; is_even(3) → False; is_even(0) → True.

def is_even(number):
    if number%2==0:
        return True
    else:
        return False

# Запустите после того, как допишете функцию.
print(is_even(42))
print(is_even(3))





# Максимум трёх аргументов
#
# Напишите max_of_three(a, b, c): функция принимает три числа и возвращает самое большое.
# Используйте сравнения, без max() и сортировки. Числа могут совпадать.
#
# Проверьте себя:
# max_of_three(8, 21, 13) → 21; max_of_three(5, 5, 2) → 5.

def max_of_three(a, b, c):
    if a>=b and a>=c:
        return a
    elif b>=a and b>=c:
        return b
    else:
        return c

# Запустите после того, как допишете функцию.
print(max_of_three(8, 21, 13))





# Палиндром с ранним выходом
#
# Напишите is_palindrome(text). После strip() и lower() проверяйте символы с двух концов
# строки. При первом несовпадении верните False; если все пары совпали — True. Внутренние
# пробелы и знаки участвуют в сравнении. Для пустой очищенной строки верните True.
#
# Проверьте себя:
# is_palindrome(' Шалаш ') → True; is_palindrome('код') → False; is_palindrome('') → True.

def is_palindrome(text):
    text_changed = text.strip().lower()
    for i in range(len(text_changed)//2):
        if text_changed[i]!=text_changed[len(text_changed)-1-i]:
            return False
    else:
        return True

# Запустите после того, как допишете функцию.
print(is_palindrome(' Шалаш '))
print(is_palindrome('код'))




# Функция стоимости доставки
#
# Напишите delivery_cost(total): функция принимает неотрицательную сумму заказа и
# возвращает стоимость доставки. При сумме от 1500 рублей включительно верните 0, иначе —
# 199.
#
# Проверьте себя:
# delivery_cost(1499) → 199; delivery_cost(1500) → 0.

def delivery_cost(total):
    if total>=1500:
        return 0
    else:
        return 199

# Запустите после того, как допишете функцию.
print(delivery_cost(1499))
print(delivery_cost(1500))




# Среднее с пустым списком
#
# Напишите list_average(numbers): функция принимает список чисел и возвращает их среднее.
# Сумму найдите циклом, без sum(). Для пустого списка верните None.
#
# Проверьте себя:
# list_average([10, 20, 30]) → 20.0; list_average([]) → None.

def list_average(numbers):
    sm = 0
    for i in numbers:
        sm+=i

    if len(numbers)==0:
        return None
    else:
        return sm/len(numbers)

# Запустите после того, как допишете функцию.
print(list_average([10, 20, 30]))
print(list_average([]))



# Подсчёт заданного символа
#
# Напишите count_char(text, target): функция возвращает количество появлений символа
# target в строке text. Если совпадений нет, верните 0. target — строка из одного символа;
# регистр важен. count() использовать нельзя.
#
# Проверьте себя:
# count_char('аналитика', 'а') → 3; count_char('Аа', 'а') → 1; count_char('', 'а') → 0.

def count_char(text, target):
    k = 0
    for i in range(len(text)):
        if text[i]==target:
            k+=1
    return k

# Запустите после того, как допишете функцию.
print(count_char('аналитика', 'а'))





# Нормализация имени
#
# Напишите normalize_name(name): функция принимает имя строкой, убирает пробелы по краям,
# делает буквы строчными, а первый символ — заглавным. Верните новую строку, сохранив
# пробелы внутри. Если после очистки ничего не осталось, верните ''.
#
# Проверьте себя:
# normalize_name('  мАРИЯ ') → 'Мария'; normalize_name('   ') → ''.

def normalize_name(name):
    return name.strip().lower().capitalize()

# Запустите после того, как допишете функцию.
print(normalize_name('  мАРИЯ '))
print(normalize_name('   '))





# Расчёт чека двумя функциями
#
# Напишите две функции для чека. line_total(price, quantity) возвращает стоимость одной
# позиции. order_total(lines) принимает список пар (цена, количество) и возвращает общую
# стоимость, вызывая первую функцию для каждой пары. Для пустого списка верните 0. Цены
# неотрицательные, количества — целые не меньше нуля; доставки и скидок нет. Пара в
# круглых скобках — кортеж из двух значений.
#
# Проверьте себя:
# line_total(199, 2) → 398; order_total([(199, 2), (850, 1)]) → 1248; order_total([]) → 0.

def line_total(price, quantity):
    return price*quantity

def order_total(lines):
    total = 0
    for q,w in lines:
        total+= q*w
    return total

# Запустите после того, как допишете функцию.
print(line_total(199, 2))
print(order_total([(199, 2), (850, 1)]))
print(order_total([]))

