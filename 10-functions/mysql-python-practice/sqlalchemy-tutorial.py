# для установки sqlalchemy в консоли надо выполнить следующую команду: pip install sqlalchemy
# для использования конкретно mysql, надо в консоли выполнить это: pip install mysql-connector-python
import sqlalchemy
import sqlalchemy.orm
from sqlalchemy.orm import Session
from typing import List

# -------------------------------------------------------------------------------------------------->

username = 'root'  # логин к базе данных
password = 'secret'  # пароль к базе данных
host = 'localhost'  # адрес хоста (компьютера), к которому мы подключаемся
database = 'python_shop'  # название базы данных
charset = 'utf8mb4'  # кодировка сессии
port = 3306  # порт базы данных

# объявление полной строки адреса для подключения к базе данных
url = f'mysql+mysqlconnector://{username}:{password}@{host}/{database}?charset={charset}&port={port}'

# создание объекта для взаимодействия с базой данных (с отображением всех запросов - echo=True)
engine = sqlalchemy.create_engine(url, echo=True)


# -------------------------------------------------------------------------------------------------->


#################### ПРОЦЕДУРНЫЙ (СТАНДАРТНЫЙ) ПОДХОД К РАБОТЕ С БАЗАМИ ДАННЫХ ######################

def run_selection_example():
    # открытие сессии
    with engine.connect() as connection:
        # выборка всех данных из таблицы products
        query = 'SELECT id, title, description, price, category_id FROM products'
        result = connection.execute(sqlalchemy.text(query))  # выполнение запроса
        products = result.all()  # получение из результата всех строк
        # ids = result.scalars('id').all() # получение из результата значений конкретного столбца из всех строк

        # выборка конкретной строки (с id = 1)
        query = 'SELECT id, title, description, price, category_id FROM products WHERE id = :id'
        result = connection.execute(sqlalchemy.text(query), {'id': 22})  # выполнение запроса
        product = result.first()  # получение первой строки запроса


################### ОБЪЕКТНО - ОРИЕНТИРОВАННЫЙ ПОДХОД К РАБОТЕ С БАЗАМИ ДАННЫХ ######################

# -------------------------------------------------------------------------------------------------->

# Суперкласс для создания классов, которые отображают разные таблицы
class Base(sqlalchemy.orm.MappedAsDataclass, sqlalchemy.orm.DeclarativeBase):
    pass


# Класс для отображения таблицы categories (каждый объект отображает данные каждой строки таблицы) 
class Category(Base):
    __tablename__ = 'categories'

    id: sqlalchemy.orm.Mapped[int] = sqlalchemy.orm.mapped_column(primary_key=True, init=False, autoincrement=True)
    title: sqlalchemy.orm.Mapped[str] = sqlalchemy.orm.mapped_column(sqlalchemy.String(255))

    products: sqlalchemy.orm.Mapped[List['Product']] = sqlalchemy.orm.relationship(back_populates='category',
                                                                                   init=False)


# Класс для отображения таблицы products (каждый объект отображает данные каждой строки таблицы) 
class Product(Base):
    __tablename__ = 'products'

    id: sqlalchemy.orm.Mapped[int] = sqlalchemy.orm.mapped_column(primary_key=True, init=False, autoincrement=True)
    title: sqlalchemy.orm.Mapped[str] = sqlalchemy.orm.mapped_column(sqlalchemy.String(255))
    price: sqlalchemy.orm.Mapped[str] = sqlalchemy.orm.mapped_column(sqlalchemy.Float)
    description: sqlalchemy.orm.Mapped[float] = sqlalchemy.orm.mapped_column(sqlalchemy.Text)
    category_id: sqlalchemy.orm.Mapped[int] = sqlalchemy.orm.mapped_column(sqlalchemy.ForeignKey('categories.id'))

    category: sqlalchemy.orm.Mapped[Category] = sqlalchemy.orm.relationship(back_populates='products', init=False)


# -------------------------------------------------------------------------------------------------->


def get_products():
    """Пример выборки всех строк из таблицы без фильтрации"""

    # открытие сессии (подзапросы к родственным сущностям возможны только в рамках сессии)
    with Session(engine) as session:
        # получение списка объектов класса Product, отображающих строки таблицы products
        products = session.execute(sqlalchemy.select(Product).order_by(Product.id.desc())).all()
        print(products)


def get_product_by_id(product_id):
    """
    Пример выборки одной строки с фильтрацией (в данном 
    случае - чтобы id равнялся переданному параметру)
    """

    # открытие сессии (подзапросы к родственным сущностям возможны только в рамках сессии)
    with Session(engine) as session:
        # получение объекта класса Product, отображающего строку таблицы products
        product = session.execute(sqlalchemy.select(Product).filter(Product.id == product_id)).scalars().first()
        print(product)


def create_product(title, description, price, category_id):
    """Пример вставки данных в таблицу - данные передаются в функцию"""

    # открытие сессии (подзапросы к родственным сущностям возможны только в рамках сессии)
    with Session(engine) as session:
        # создание объекта с данными
        product = Product(
            title=title,
            description=description,
            price=price,
            category_id=category_id  # убедитесь, что category_id реально существует!
        )

        # добавление нового объекта в сессию
        session.add(product)

        # сохранение данных (подтверждение вставки)
        session.commit()

        print(product)


def update_product(product_id, title, description, price, category_id):
    """Пример обновления данных в таблице - данные передаются в функцию"""

    # открытие сессии (подзапросы к родственным сущностям возможны только в рамках сессии)
    with Session(engine) as session:
        # получение объекта продукта
        product = session.execute(sqlalchemy.select(Product).filter(Product.id == product_id)).scalars().first()

        if product:
            # обновляем продукта новыми данными
            product.title = title
            product.description = description
            product.price = price
            product.category_id = category_id  # убедитесь, что category_id реально существует!

            # добавление обновленного объекта в сессию
            session.add(product)

            # сохранение данных (подтверждение обновление)
            session.commit()

            print(product)


def delete_product_by_id(product_id):
    """Пример удаления данных в таблице - данные для фильтрации передаются в функцию"""

    # открытие сессии (подзапросы к родственным сущностям возможны только в рамках сессии)
    with Session(engine) as session:
        # получение объекта продукта
        product = session.execute(sqlalchemy.select(Product).filter(Product.id == product_id)).scalars().first()

        if product:
            # удаление продукта
            session.delete(product)

            # сохранение данных (подтверждение обновления)
            session.commit()
