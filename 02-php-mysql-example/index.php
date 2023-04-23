<?php

/**
 * Данный код приведен только для образовательных целей!
 * Использовать в настоящих коммерческих программах крайне опасно!
 *
 * Для работы с файлом нужны установленные PHP и MySQL, база данных shop и таблица products. 
 * Для запуска надо зайти в командной строке в каталог с файлом и исполнить команду php index.php
 */

// соединение с базой данных
$connection = new PDO('mysql:host=localhost;dbname=shop;charset=utf8mb4', 'root', 'secret', [
	PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
	PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
]);

// запрос на выборку продуктов и получение результата запроса
$result = $connection->query('SELECT name, code FROM products;');

// отображение результатов запроса (обход в цикле и вывод на печать)
foreach ($result->fetchAll() as $product) {
	echo $product['name'], ' ', $product['code'], '<br>';
}
