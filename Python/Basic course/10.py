# Квадратные корни через math
#
# Импортируйте math и получите квадратные корни чисел 4, 9 и 144 через math.sqrt(). Для
# каждого выведите исходное число и его корень на одной строке, как в примере ниже.
#
# Проверьте себя:
# 4 → 2.0; 9 → 3.0; 144 → 12.0.

numbers = [4, 9, 144]

# Напишите решение ниже.


import math

for number in numbers:
    print(number, math.sqrt(number))




# Окружность и круг
#
# Для неотрицательного радиуса radius посчитайте длину окружности и площадь круга.
# Возьмите π из math.pi: формулы — 2 * π * radius и π * radius ** 2. Выведите оба
# результата с подписями, округлив до 2 знаков после запятой.
#
# Проверьте себя:
# Длина окружности: 31.42; площадь круга: 78.54; при нулевом радиусе обе величины — 0.0.

radius = 5

# Напишите решение ниже.
import math

print(f'Длина окружности: {round(2*math.pi*radius,2)}')
print(f'Площадь круга: {round(math.pi*radius**2,2)}')




# Случайное целое число
#
# С помощью модуля random получите и выведите случайное целое число от 1 до 10
# включительно. При повторном запуске число может повториться.
#
# Проверьте себя:
# Подходят, например, 1, 7, 10; 0, 11 и дробные числа не подходят.

lower = 1
upper = 10

# Напишите решение ниже.
import random
print(random.randint(lower,upper))




# Сто бросков монеты
#
# Смоделируйте 100 бросков монеты через random, с равной вероятностью орла и решки.
# Выведите количество орлов, решек и общее число бросков. Сумма должна быть 100, но орлов
# и решек может быть разное количество.
#
# Проверьте себя:
# Например: Орёл: 47, Решка: 53, Всего: 100. Точные первые два числа меняются.

import random
throws = 100

# Напишите решение ниже.
p = 0.5

O = random.binomialvariate(throws, p)
P  = throws - O
print(f'Орёл:{O}')
print(f'Решка:{P}')



#Эталонное решение
O = P = 0

for i in range(100):
    if random.choice(['орёл', 'решка'])=='решка':
        O+=1
    else:
        P+=1

print(f'Орёл: {O}')
print(f'Решка: {P}')




# Как устроен запрос к API
#
# Представьте, что ваша программа запрашивает температуру у погодного сервиса. В
# комментариях к файлу объясните своими словами пять понятий: клиент, сервер, API, запрос
# и ответ. Покажите на этом примере, кто отправляет координаты и кто возвращает погоду.
# Код запроса писать не нужно.
#
# Проверьте себя:
# Из ответа должно быть понятно, кто отправляет координаты, кто обрабатывает обращение и в
# какую сторону возвращаются данные.

# Сценарий: ваша программа запрашивает погоду по координатам.
# Клиент — человек, который хочет узнать температуру
# Сервер — принимает данные, обрабатывает их и формирует ответ
# API — набор правил и договоренности, по которым клиент и сервер общаются
# Запрос — обращение через api к серверу, чтобы получить данные 
# Ответ —  json файл с нужными данными от сервера

# Напишите решение ниже.



# Погода в браузере
#
# Соберите URL для Open-Meteo из base_url и params и откройте его в браузере. Сохраните
# ссылку в комментарии. В JSON найдите current и выпишите названия и значения трёх полей:
# temperature_2m, apparent_temperature, wind_speed_10m. Готовая ссылка для сравнения есть
# перед заданиями; погодные значения зависят от времени запроса.
#
# Проверьте себя:
# В current должны быть temperature_2m, apparent_temperature, wind_speed_10m. Значения
# зависят от времени запроса; совпадения с фиксированными числами не требуется.

base_url = 'https://api.open-meteo.com/v1/forecast'
params = {
    'latitude': 55.7558,
    'longitude': 37.6173,
    'current': 'temperature_2m,apparent_temperature,wind_speed_10m',
    'timezone': 'Europe/Moscow',
}

# Напишите решение ниже.

'https://api.open-meteo.com/v1/forecast?latitude=55.7558&longitude=37.6173&current=temperature_2m,apparent_temperature,wind_speed_10m&timezone=Europe%2FMoscow'


#"current":{"time":"2026-11-15T23:00","interval":900,"temperature_2m":0.6,"apparent_temperature":-2.7,"wind_speed_10m":6.9}



from urllib.parse import urlencode

base_url = 'https://api.open-meteo.com/v1/forecast'
params = {
    'latitude': 55.7558,
    'longitude': 37.6173,
    'current': 'temperature_2m,apparent_temperature,wind_speed_10m',
    'timezone': 'Europe/Moscow',
}
url = base_url + '?' + urlencode(params)

print(url)
# Откройте напечатанный адрес и найдите объект current в JSON.




# GET-запрос из Python
#
# Запросите температуру Москвы из Python через requests.get(). Адрес и params уже даны.
# Укажите timeout=10, проверьте статус через raise_for_status() и разберите JSON. Выведите
# словарь data['current']. Здесь достаточно успешного запроса; обработка ошибок будет в
# дополнительных заданиях.
#
# Проверьте себя:
# Проверьте наличие ключа temperature_2m внутри current. Само число не фиксировано.


import requests
url = 'https://api.open-meteo.com/v1/forecast'
params = {
    'latitude': 55.7558,
    'longitude': 37.6173,
    'current': 'temperature_2m',
}

response = requests.get(url, params=params, timeout=10)
response.raise_for_status()

data = response.json()
print(data['current'])

#{'time': '2026-11-15T20:15', 'interval': 900, 'temperature_2m': 0.6}




# Три показателя погоды
#
# Запросите у Open-Meteo три показателя погоды для Москвы. Из current достаньте
# температуру, ощущаемую температуру и скорость ветра. Выведите каждый показатель с
# подписью: температуры в °C, ветер в км/ч. Используйте timeout=10 и raise_for_status().
#
# Проверьте себя:
# Для учебного current {'temperature_2m': 18.2, 'apparent_temperature': 17.5,
# 'wind_speed_10m': 8.0} вывод содержит 18.2 °C, 17.5 °C, 8.0 км/ч. Реальная погода будет
# другой.


import requests 
url = 'https://api.open-meteo.com/v1/forecast'
params = {
    'latitude': 55.7558,
    'longitude': 37.6173,
    'current': 'temperature_2m,apparent_temperature,wind_speed_10m',
}

response = requests.get(url, params = params, timeout=10)
response.raise_for_status()
data = response.json()

print(f'{data['current']['temperature_2m']} °C')
print(f'{data['current']['apparent_temperature']} °C')
print(f'{data['current']['wind_speed_10m']} км/ч')





# Запрос для другого города
#
# Получите температуру Казани по данным ниже — либо замените город и координаты на свои.
# Вызовите Open-Meteo с timeout=10 и проверкой статуса. Выведите название города и
# температуру в °C. Если выбираете другой город, поменяйте и координаты запроса, и
# подпись.
#
# Проверьте себя:
# Проверьте, что в запрос переданы координаты выбранного города. Различие температур не
# является критерием правильности.

import requests
city = 'Казань'
url = 'https://api.open-meteo.com/v1/forecast'
params = {
    'latitude': 55.7961,
    'longitude': 49.1064,
    'current': 'temperature_2m',
}

response = requests.get(url, params = params, timeout=10)
response.raise_for_status()

data = response.json()
print(f'Город: {city}, температура: {data['current']['temperature_2m']} °C')




# Ключ из переменной окружения
#
# Задайте учебную переменную окружения WEATHER_API_KEY со значением demo-only и прочитайте
# её через os.getenv(). Если значение есть, соберите headers с Authorization вида Bearer
# <ключ> и сообщите, что заголовок готов. Если переменной нет, сообщите об этом. Сам ключ
# не печатайте и запрос не отправляйте. В примере настроек для сдачи оставьте только
# WEATHER_API_KEY= без значения.
#
# Проверьте себя:
# С заданной переменной: Заголовок подготовлен, ключ не печатаем; без неё — понятное
# сообщение. Для учебного Open-Meteo этот ключ не используется.

# До запуска задайте переменную окружения WEATHER_API_KEY.
# Учебное значение: demo-only. Настоящий ключ не нужен.
# Например, в терминале PowerShell:
# $env:WEATHER_API_KEY='demo-only'
import os
variable_name = 'WEATHER_API_KEY'

api_key = os.getenv(variable_name)
if not api_key:
    print('WEATHER_API_KEY без значения')



