DROP DATABASE shop;
CREATE DATABASE shop;
USE shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
  (NULL, 'Видеокарты'),
  (NULL, 'Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

SELECT * FROM orders;

INSERT INTO orders (id, user_id)
VALUES (1,2);
INSERT INTO orders (id, user_id)
VALUES (2,3);
INSERT INTO orders (id, user_id)
VALUES (3,5);
INSERT INTO orders (id, user_id)
VALUES (4,2);
INSERT INTO orders (id, user_id)
VALUES (5,4);
INSERT INTO orders (id, user_id)
VALUES (6,5);
INSERT INTO orders (id, user_id)
VALUES (7,3);
INSERT INTO orders (id, user_id)
VALUES (8,3);
INSERT INTO orders (id, user_id)
VALUES (9,3);


/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */
-- СДЕЛАТЬ!

SELECT * FROM orders;
SELECT * FROM users;

SELECT name FROM users
WHERE id IN (	
SELECT user_id
    FROM orders
    GROUP BY 
	user_id);
    
    
  -- я так понимаю есть и второй вариант рещения   
    SELECT u.name
    FROM users AS u JOIN orders AS o
    ON u.id = o.user_id;


/*Выведите список товаров products и разделов catalogs, который соответствует товару.*/
SELECT * FROM products;
SELECT * FROM catalogs;

SELECT p.name, c.name
FROM products AS p JOIN catalogs AS c
ON c.id = p.catalog_id;

/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.*/

CREATE TABLE flights (
id SERIAL PRIMARY KEY,
`from` VARCHAR(255),
`to` VARCHAR(255)
);

CREATE TABLE cities (
label VARCHAR(255),
name VARCHAR(255)
);


INSERT INTO flights (`id`, `from`,`to`)
VALUES (1, 'moscow', 'omsk');
INSERT INTO flights (`id`, `from`,`to`)
VALUES (2, 'novgorod', 'kazan');
INSERT INTO flights (`id`, `from`,`to`)
VALUES (3, 'irkutsk', 'moscow');
INSERT INTO flights (`id`, `from`,`to`)
VALUES (4, 'omsk', 'irkutsk');
INSERT INTO flights (`id`, `from`,`to`)
VALUES (5, 'moscow', 'kazan');

INSERT INTO cities (`label`, `name`)
VALUES ('moscow', 'москва');
INSERT INTO cities (`label`, `name`)
VALUES ('irkutsk', 'иркутск');
INSERT INTO cities (`label`, `name`)
VALUES ('novgorod', 'новгород');
INSERT INTO cities (`label`, `name`)
VALUES ('kazan', 'казань');
INSERT INTO cities (`label`, `name`)
VALUES ('omsk', 'омск');

SELECT * FROM flights;
SELECT * FROM cities;


SELECT
(SELECT name FROM cities WHERE label = `from`) AS `from`,
(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights;
