# для установки этого пакета в консоли надо выполнить следующую команду: pip install mysql-connector-python
import mysql.connector


def get_connection():
    """Пример открытия соединения с базой данных"""

    return mysql.connector.connect(
        host='localhost',  # адрес хоста (компьютера), к которому мы подключаемся
        database='python_shop',  # название базы данных
        username='root',  # логин к базе данных
        password='secret',  # пароль к базе данных
        charset='utf8mb4'  # кодировка соединения с базой данных
    )


def get_products():
    """Пример выборки всех строк из таблицы без фильтрации"""

    # открытие соединения с базой данных
    with get_connection() as connection:
        """
        создание объекта для запросов (дополнительно указываем, чтобы 
        возвращались словари (dict) с текстовыми ключами - названиями столбцов)
        """
        cursor = connection.cursor(dictionary=True)

        # выполнение запроса
        query = 'SELECT id, title, description, price, category_id FROM products ORDER BY id DESC'
        cursor.execute(query)

        # получения всех данных в виде списка словарей
        return cursor.fetchall()


def get_product_by_id(product_id):
    """
    Пример выборки одной строки с фильтрацией (в данном 
    случае - чтобы id равнялся переданному параметру)
    """

    # открытие соединения с базой данных
    with get_connection() as connection:
        """
        создание объекта для запросов (дополнительно указываем, чтобы 
        возвращались словари (dict) с текстовыми ключами - названиями столбцов)
        """
        cursor = connection.cursor(dictionary=True)

        # выполнение запроса с передачей параметров в виде кортежа (tuple)
        query = 'SELECT id, title, description, price, category_id FROM products WHERE id = %s'
        cursor.execute(query, (product_id,))

        # получения одной строки в виде словаря (dict) - если же строка не найдена - вернется None
        return cursor.fetchone()


def create_product(title, description, price, category_id):
    """Пример вставки данных в таблицу - данные передаются в функцию"""

    # открытие соединения с базой данных
    with get_connection() as connection:
        # создание объекта для запросов
        cursor = connection.cursor()

        # подготовка данных для вставки (перечислены в том же порядке, что и в запросе)
        # убедитесь, что category_id реально существует!
        params = (title, description, price, category_id,)

        # выполнение запроса с передачей параметров в виде кортежа (tuple)
        query = 'INSERT INTO products(title, description, price, category_id) VALUES(%s, %s, %s, %s)'
        cursor.execute(query, params)

        # фиксация (подтверждение вставки) данных
        connection.commit()

        # возвращение идентификатора (id) вставленной строки
        return cursor.lastrowid


def update_product(product_id, title, description, price, category_id):
    """Пример обновления данных в таблице - данные передаются в функцию"""

    # открытие соединения с базой данных
    with get_connection() as connection:
        # создание объекта для запросов
        cursor = connection.cursor()

        # подготовка данных для обновления (перечислены в том же порядке, что и в запросе)
        # убедитесь, что category_id реально существует!
        params = (title, description, price, category_id, product_id,)

        # выполнение запроса с передачей параметров в виде кортежа (tuple)
        query = 'UPDATE products SET title = %s, description = %s, price = %s, category_id = %s WHERE id = %s'
        cursor.execute(query, params)

        # фиксация (подтверждение обновления) данных
        connection.commit()


def delete_product_by_id(product_id):
    """Пример удаления данных в таблице - данные для фильтрации передаются в функцию"""

    # открытие соединения с базой данных
    with get_connection() as connection:
        # создание объекта для запросов
        cursor = connection.cursor()

        # выполнение запроса с передачей параметров в виде кортежа (tuple)
        query = 'DELETE FROM products WHERE id = %s'
        cursor.execute(query, (product_id,))

        # фиксация (подтверждение удаления) данных
        connection.commit()
