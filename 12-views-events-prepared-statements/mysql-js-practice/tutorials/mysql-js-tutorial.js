// подгружаем библиотеку для обработки запросов в MySQL (устанавливается командой npm install mysql2)
const mysql2 = require('mysql2')

// подгружаем библиотеку для подгрузка параметров из конфигурационного файла .env (npm install dotenv)
const dotenv = require('dotenv')


// --------------------------------------------------


// подгрузка параметров из конфигурационного файла .env
dotenv.config()

// создание объекта соединения с базой данных
const connection = mysql2.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    charset: process.env.DB_CHARSET,
    port: process.env.DB_PORT,
    dateStrings: true
}).promise()


// --------------------------------------------------


/*
    1) представим, что в нашей базе данных есть таблица messages, которая была создана следующим образом:
    CREATE TABLE IF NOT EXISTS messages (
        id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255),
        content LONGTEXT
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
    2) создадим класс MessageDao, который работает с этой таблицей
*/
class MessageDao {
    // получение всех сообщений
    static async getAllMessages() {
        try {
            const query = 'SELECT id, title, content FROM messages ORDER BY id DESC'
            const [messages] = await connection.query(query)
            return messages
        } catch (err) {
            throw new Error(`Failed to get all messages. Error: '${err.message}'.`)
        }
    }
    
    // получение сообщения по его идентификатору (id)
    static async getMessageById(id) {
        try {
            const query = 'SELECT id, title, content FROM messages WHERE id = ?'
            const [result] = await connection.query(query, [id]);
            return result[0] ? result[0] : null
        } catch (err) {
            throw new Error(`Failed to get message with id ${id}. Error: '${err.message}'.`)
        }
    }
    
    // создание сообщения и возвращение его идентификатора (id)
    static async createMessage(title, content) {
        try {
            const query = 'INSERT INTO messages (title, content) VALUES (?, ?)'
            const [result] = await connection.execute(query, [title, content])
            return result ? result.insertId : null
        } catch (err) {
            throw new Error(`Failed to create message with title '${title}'. Error: '${err.message}'.`)
        }
    }
    
    // обновление сообщения
    static async updateMessage(id, title, content) {
        try {
            const query = 'UPDATE messages SET title = ?, content = ? WHERE id = ?'
            await connection.execute(query, [title, content, id])
        } catch (err) {
            throw new Error(`Failed to update message with id ${id}. Error: '${err.message}'.`)
        }
    }
    
    // удаление сообщения
    static async deleteMessageById(id) {
        try {
            const query = 'DELETE FROM messages WHERE id = ?'
            await connection.execute(query, [id])
        } catch (err) {
            throw new Error(`Failed to delete message with id ${id}. Error: '${err.message}'.`)
        }
    }
}


// --------------------------------------------------


// экспорт MessageDao для возможности использования в других файлах
module.exports = {MessageDao}