# встроенный пакет для получения переменных окружения
import os

# пакет для подгрузки переменных окружения, для установки надо выполнить следующую команду: pip install python-dotenv
from dotenv import load_dotenv

# пакет фреймворка Flask, устанавливается следующей командой: pip install flask
from flask import Flask, render_template, abort, request, redirect, url_for, flash, Blueprint


# подгрузка переменных окружения из файла .env
load_dotenv()

# создание основного Flask приложения
app = Flask(__name__)

# установка секретного ключа (нужен для инициализации сессии)
app.config['SECRET_KEY'] = os.getenv('APP_SECRET_KEY')

# создание группы для страниц (можно назначать страницы без нее, но с ней удобнее)
section = Blueprint('section', __name__)


# по этому пути / (с учетом префикса группы страницы /admin) будет доступно то, что вернет данная функция (строку)
@section.route('/')
def simple_example():
    return 'Hello, it is simple example.'


@section.route('/template')
def template_example():
    """
    В данном случае при посещении страницы будет показан специальный шаблон example.html,
    куда могут подставляться переменные, включаться другие шаблоны, стили и т.д. Шаблон
    должен находиться в директории templates
    """
    return render_template('example.html')


@section.route('/redirect')
def redirect_example():
    # эта страница будет перенаправлять пользователя на другую страницу
    return redirect(url_for('section.simple_example'))


@section.route('/abort')
def abort_example():
    """
    Вызов ошибки "страница не найдена" - если есть
    обработчик такой ошибки - будет вызван он
    """
    abort(404)


@section.route('/flash')
def flash_example():
    """
    Запись в сессию одноразового сообщения, которое будет доступно после
    перехода на другую страницу (только один раз).
    """
    flash('This message will be accessible after redirect')
    return redirect(url_for('section.simple_example'))


@section.route('/path_parameter/<int:number>')
def path_parameter_example(number):
    # получение части пути запроса
    return f'Provided path parameter - {number}.'


@section.route('/query_parameter')
def query_parameter_example():
    # получение параметра GET запроса по ключу name
    name = request.args.get('name')
    return f'Provided query parameter "name" - {name}.'


# эту страницу можно посетить только с помощью метода POST
@section.route('/post_parameter', methods=['POST'])
def post_parameter_example():
    # получение параметра POST запроса по ключу name
    name = request.form.get('name')
    return f'Provided post parameter "name" - {name}.'


@app.errorhandler(404)
def abort_example(e):
    # обработчик для тех случаев, когда такая страница не существует
    return 'Page is not found.', 404


# регистрация группы страниц (для пути каждой страницы будет подставлен префикс /admin)
app.register_blueprint(section, url_prefix='/admin')
