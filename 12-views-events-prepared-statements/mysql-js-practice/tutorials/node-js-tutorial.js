// подгружаем библиотеку для обработки http запросов (устанавливается командой npm install express)
const express = require('express')

// подгружаем библиотеку для обработки сессий - хранят данные между запросами (npm install express-session)
const expressSession = require('express-session')

// подгружаем библиотеку для постоянного соединения с клиентом (npm install socket.io)
const socket = require('socket.io')

// подгружаем библиотеку для подгрузка параметров из конфигурационного файла .env (npm install dotenv)
const dotenv = require('dotenv')

// подгружаем наш собственный файл для работы с базой данных
const dao = require('./mysql-js-tutorial')

// --------------------------------------------------


// подгрузка параметров из конфигурационного файла .env
dotenv.config()


// --------------------------------------------------


// создание объекта для обработки http запросов
const app = express()

// включение возможности пользоваться шаблонами (библиотека устанавливается командой npm install ejs)
app.set('view engine', 'ejs')

// включение доступа к статическим файлам (стилям) в директории /static
app.use(express.static('static'))

// включение поддержки обработки POST запросов, extended означает, что будет поддержка вложенных структур (массивы)
app.use(express.urlencoded({extended: true}))

// подключение объекта сессий к объекту для обработки http запросов
app.use(expressSession({
    secret: process.env.SESSION_SECRET_KEY, // установка ключа для шифрования сессии
    resave: false,                          // сессия не будет пересохранена, если не была изменена
    saveUninitialized: false,               // сессия не будет созранятся, если она пустая
    cookie: {maxAge: 86400}                 // время жизни сессионной куки (в секундах)
}))

// подготовка посредника (middleware) для проверки аутентификации
const authentification = (req, res, next) => {
    if (req.session.authenticated) {
        // если ключ 'authenticated' присутствует в нашей сессии - пропускаем запрос
        next()
    } else {
        // если ключа 'authenticated' в сессии нет - возвращает ошибку в формате JSON
        res.json({'error': 'You are not authenticated.'})
    }
}


// --------------------------------------------------


// обработка GET запроса по пути /
app.get('/', (req, res) => {
    
    // при заходе по этому пути клиент будет видеть текст 'Hello, World!'
    res.send('Hello, World!')
})

// обработка GET запроса по пути /template
app.get('/template', (req, res) => {
    
    // подготовка данных
    const data = {message: 'Hello, Client!'}
    
    /*
        1) при заходе по этому пути клиенту вернется содержимое шаблона views/layout.ejs (он должен существовать)
        2) также в шаблоне будет доступна переменная message со значением 'Hello, Client!'
    */
    res.render('layout', data)
})

// обработка GET запроса по пути /json
app.get('/json', (req, res) => {
    
    // подготовка данных
    const data = {firstname: 'John', lastname: 'Smith'}
    
    // при заходе по этому пути клиент вернутся данные в формате JSON
    res.json(data)
})

// обработка GET запроса по пути /get-params
app.get('/get-params', (req, res) => {

    // получение GET данных (данных из адресной строки)
    const firstname = typeof req.query.firstname === 'string' ? req.query.firstname.trim() : ''
    const lastname = typeof req.query.lastname === 'string' ? req.query.lastname.trim() : ''
    
    // подготовка данных
    const data = {firstname, lastname}
    
    // при заходе по этому пути клиент вернутся данные в формате JSON
    res.json(data)
})

// обработка POST запроса по пути /post-params
app.post('/post-params', (req, res) => {

    // получение POST данных (данных из тела запроса)
    const firstname = typeof req.body.firstname === 'string' ? req.body.firstname.trim() : ''
    const lastname = typeof req.body.lastname === 'string' ? req.body.lastname.trim() : ''
    
    // подготовка данных
    const data = {firstname, lastname}
    
    // при заходе по этому пути клиент вернутся данные в формате JSON
    res.json(data)
})

// обработка GET запроса по пути /session-set
app.get('/session-set', (req, res) => {

    // установка значения сессии (authenticated = true)
    req.session.authenticated = true;
    
    // при заходе по этому пути клиент будет перенаправлен по пути /middleware-example
    res.redirect('/middleware-example')
})

// обработка GET запроса по пути /middleware-example
app.get('/middleware-example', authentification, (req, res) => {
    
    /*
        1) если клиент попал внутрь этого обработчика - он прошел проверку на аутентификацию
        2) при заходе по этому пути клиент будет видеть текст 'You have been successfully authenticated!'
    */
    res.send('You have been successfully authenticated!')
})

// обработка GET запроса по пути /messages (с использованием запроса в базу данных)
app.get('/messages', async (req, res) => {
    
    // вернем клиенту все сообщения из базы данных в JSON формате
    res.json(await dao.MessageDao.getAllMessages())  
})


// обработка GET запроса по пути /messages/{some-id} (с использованием параметра в пути и запроса в базу данных)
app.get('/messages/:id', async (req, res) => {
    
    // получение параметра пути
    const id = req.params.id;
    
    // вернем клиенту все сообщения из базы данных в JSON формате
    res.json(await dao.MessageDao.getMessageById(id))  
})

// --------------------------------------------------


// установка того порта (8000), по которому наше приложение будет принимать запросы
const server = app.listen(8000)


// --------------------------------------------------


// создание обработчика, который будт поддерживать постоянное соединение с клиентом
const io = socket(server)

// обработчик установления постоянного соединения с клиентом (название 'connection' обязательно)
io.on('connection', (connection) => {
    
    // обработчик событий внутри соединения (в даннном случае события 'new-message' - название выбираем сами)
    connection.on('new-message', () => {
        
        // отправка события 'reload-messages' всем соединениям (название отправляемого события выбираем сами)
        io.emit('reload-messages')
    })
})