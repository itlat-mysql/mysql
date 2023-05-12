import mysql.connector

"""

Данный код приведен только для образовательных целей!
Использовать в настоящих коммерческих программах крайне опасно!

Для работы с файлом нужны установленные Python и MySQL, база данных shop и таблица products. 
Также необходимо установить MySQL модуль для Python командой pip install mysql-connector-python
Для запуска надо зайти в командной строке в каталог с файлом и исполнить команду python example.py

"""

# соединение с базой данных
connection = mysql.connector.connect(
    host='localhost',
    port=3306,
    username='root',
    password='secret',
    database='shop',
    charset='utf8mb4'
)

# создание объекта для выполнения запросов
cursor = connection.cursor()

# запрос на выборку продуктов
cursor.execute('SELECT name, code FROM products;')

# получение результатов запроса
products = cursor.fetchall()

# отображение результатов запроса (обход в цикле и вывод на печать)
for product in products:
    print(product[0], ' ', product[1])

# закрытие соединения
connection.close()
