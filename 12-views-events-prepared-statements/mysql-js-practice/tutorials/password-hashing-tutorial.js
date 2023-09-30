// подгружаем библиотеку для работы с криптографией
const crypto = require('crypto')


// --------------------------------------------------


// функция для хеширования паролей
function hashPassword(password) {
    return crypto.createHash('sha256').update(password).digest('hex')
}


// --------------------------------------------------


// экспорт hashPassword для возможности использования в других файлах
module.exports = {hashPassword}