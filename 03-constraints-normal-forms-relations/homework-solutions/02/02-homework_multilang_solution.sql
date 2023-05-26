-- удаление старой базы данных (если она существует)
DROP DATABASE IF EXISTS homework_multilang_solution;

-- создание новой базы данных
CREATE DATABASE homework_multilang_solution DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE homework_multilang_solution;


/*
    СОЗДАНИЕ ТАБЛИЦ
*/

-- код языка (iso_code) - уникальное значение (нельзя занести два языка с одним кодом)
CREATE TABLE languages (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    iso_code CHAR(2) UNIQUE NOT NULL CHECK(CHAR_LENGTH(iso_code) = 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- код продукта (code) - уникальное значение (нельзя занести два продукта с одним кодом)
CREATE TABLE products (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(20,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- language_id представляет собой ссылку на таблицу languages (посредством ограничения внешнего ключа через столбец id)
-- product_id представляет собой ссылку на таблицу products (посредством ограничения внешнего ключа через столбец id)
-- язык (language_id) и продукт (product_id) - первичный ключ - уникальная комбинация (нельзя написать перевод на конкретный язык для одного и того же продукта несколько раз)
CREATE TABLE products_translations(
    language_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY(language_id) REFERENCES languages(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(language_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE articles (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    position INT UNSIGNED NOT NULL, 
    created_at DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- language_id представляет собой ссылку на таблицу languages (посредством ограничения внешнего ключа через столбец id)
-- article_id представляет собой ссылку на таблицу articles (посредством ограничения внешнего ключа через столбец id)
-- язык (language_id) и статья (article_id) - первичный ключ - уникальная комбинация (нельзя написать перевод на конкретный язык для одной и той же статьи несколько раз)
CREATE TABLE articles_translations(
    language_id BIGINT UNSIGNED NOT NULL,
    article_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT NOT NULL,
    FOREIGN KEY(language_id) REFERENCES languages(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(article_id) REFERENCES articles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(language_id, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*
    ВСТАВКА ДАННЫХ ВО ВСЕ ТАБЛИЦЫ
*/

-- вставка данных в таблицу languages
INSERT INTO languages (id, name, iso_code) 
VALUES 
(1, 'Latviešu', 'lv'),
(2, 'Русский', 'ru'),
(3, 'Английский', 'en');

-- вставка данных в таблицу products
INSERT INTO products (id, code, price) 
VALUES 
(1, '1234567890', 39.99),
(2, '9876543210', 999.99),
(3, '6518283460', 2499.99);

-- вставка данных в таблицу products_translations
INSERT INTO products_translations(product_id, language_id, name, description)
VALUES
(1, 1, 'T-krekls iDad', 'Uzdāviniet ideālu dāvanu savam tētim - T-krekls iDad ar viedu un tehnoloģisku dizainu!'),
(1, 2, 'Футболка iDad', 'Подарите идеальный подарок своему отцу - Футболка iDad с умным дизайном в технологичном стиле!'),
(1, 3, 'T-shirt iDad', 'Get the perfect gift for your dad with T-shirt iDad featuring clever tech-themed designs!'),
(2, 1, 'Talrunis iPhone 14', 'Iepazīstiet jauno iPhone 14 ar apburošu dizainu, uzlabotu kameras sistēmu un jaunākajām funkcijām!'),
(2, 2, 'Телефон iPhone 14', 'Представляем новый iPhone 14 с потрясающим дизайном, продвинутой системой камер и передовыми функциями!'),
(2, 3, 'Phone iPhone 14', 'Introducing the all-new iPhone 14 with a stunning design, advanced camera system, and cutting-edge features!'),
(3, 1, 'Dators Mac Mini M2 Pro', 'Izbaudiet jaunā Mac Mini M2 Pro jaudu - aprīkots ar jaunāko M2 čipu un apbrīnojamiem grafikas iespējām!'),
(3, 2, 'Компьютер Mac Mini M2 Pro', 'Почувствуйте мощь нового Mac Mini M2 Pro - с новейшим чипом M2 и потрясающими графическими возможностями!'),
(3, 3, 'Computer Mac Mini M2 Pro', 'Experience the power of the new Mac Mini M2 Pro - packed with the latest M2 chip and stunning graphics capabilities!');

-- вставка данных в таблицу articles
INSERT INTO articles(id, position, created_at)
VALUES
(1, 1, '2023-05-10 10:00:00'),
(2, 2, '2023-05-12 15:43:00'),
(3, 3, '2023-05-15 08:27:34');

-- вставка данных в таблицу articles_translations
INSERT INTO articles_translations(article_id, language_id, title, content)
VALUES
(1, 1, 'Kā ietaupīt naudu iepērkoties Internetā', 'Efektīva stratēģija ir vākt atlaides kodus vai kuponus, kuri var tikt piemēroti apmaksa laikā.'),
(1, 2, 'Как сэкономить деньги при покупках онлайн', 'Эффективной стратегией является поиск скидочных кодов или купонов, которые можно применить при оформлении заказа.'),
(1, 3, 'How to Save Money when Shopping Online' , 'An effective strategy is to look for discount codes or coupons that can be applied at checkout.'),
(2, 1, 'Droša maksājumu veikšana Internetā', 'Ir svarīgi pārliecināties, ka tīmekļa vietnei, ar kuru jūs veicat darījumu, ir droša un šifrēta maksājumu sistēma, pirms ievadāt jebkādu jutīgu finanšu informāciju.'),
(2, 2, 'Безопасные платежи в интернете', 'Важно убедиться, что веб-сайт, с которым вы проводите транзакцию, имеет безопасную и зашифрованную систему платежей перед вводом любой конфиденциальной финансовой информации.'),
(2, 3, 'Safe Online Payments', 'It is important to ensure that the website you are transacting with has a secure and encrypted payment system before entering any sensitive financial information.'),
(3, 1, 'Ātra pirkumu piegāde', 'Lielākā daļa tiešsaistes tirgotāju piedāvā paātrinātas vai eksprespiegādes iespējas, lai nodrošinātu savlaicīgu preču piegādi klientiem.'),
(3, 2, 'Быстрая доставка покупок', 'Многие интернет-ретейлеры предлагают ускоренные или экспресс-варианты доставки, чтобы обеспечить быструю доставку товаров своим клиентам.'),
(3, 3, 'Fast Delivery of Purchases', 'Many online retailers offer expedited or express shipping options to ensure speedy delivery of goods to their customers.');


/*
    ВЫБОРКА ДАННЫХ ИЗ ВСЕХ ТАБЛИЦ
*/

-- выборка данных из таблицы languages
SELECT id, name, iso_code FROM languages;

-- выборка данных из таблицы products
SELECT id, code, price FROM products;

-- выборка данных из таблицы products_translations
SELECT language_id, product_id, name, description FROM products_translations;

-- выборка данных из таблицы articles
SELECT id, position, created_at FROM articles;

-- выборка данных из таблицы articles_translations
SELECT language_id, article_id, title, content FROM articles_translations;


/*
    ПРИМЕРЫ ЗАПРОСОВ НА ПОЛУЧЕНИЕ ДАННЫХ ИЗ НЕСКОЛЬКИХ ТАБЛИЦ ОДНОВРЕМЕННО (МЫ ПОКА НЕ ПРОХОДИЛИ ЭТИ ТЕМЫ, НО ПОЛЕЗНО ПОСМОТРЕТЬ РЕАЛЬНЫЕ ВОЗМОЖНОСТИ MYSQL)
*/

-- получение полной информации о всех продуктах, включая информацию на русском языке, если мы только знаем код (iso_code) этого языка
SELECT p.id, p.code, p.price, pt.name, pt.description
FROM products p
LEFT JOIN (
    SELECT name, description, product_id FROM products_translations WHERE language_id = (
        SELECT id FROM languages WHERE iso_code = 'ru' LIMIT 1
    )
) pt ON p.id = pt.product_id;

-- получение позиций и названий всех статей на всех языках с добавлением кодов этих языков
SELECT at.title, a.position, l.iso_code
FROM articles a
LEFT JOIN articles_translations at ON a.id = at.article_id
LEFT JOIN languages l ON at.language_id = l.id;