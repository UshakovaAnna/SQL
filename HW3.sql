-- Создаём БД
CREATE DATABASE vk;

-- Делаем её текущей
USE vk;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи"; 
-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";

-- Таблица дружбы
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

-- Таблица групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";


/*Проанализировать структуру БД vk, которую мы создали на занятии, и внести предложения по усовершенствованию (если такие идеи есть).
 * Напишите пожалуйста, всё-ли понятно по структуре.
 
 Вроде бы пока все понятно. Но тяжело с пониманием... С таблицой по лайкам зависла прям, переделывала много раз ине уверена, что правильно. 
 В моем понимании, чтобы посчитать сколько лайков у медиа, нужно сделать count по столбцу media_id*/



-- Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов, постов и пользователей.

-- Таблица связи пользователй и лайков

CREATE TABLE likes_users (
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (media_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между пользователями и лайками";


/* Используя сервис http://filldb.info или другой по вашему желанию, сгенерировать тестовые данные для всех таблиц, учитывая логику связей.
 Для всех таблиц, где это имеет смысл, создать не менее 100 строк.
 Создать локально БД vk и загрузить в неё тестовые данные.*/

-- заполняем базу vk

-- заполнем пользователей

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Coby', 'Shanahan', 'qkling@example.net', '600.437.1627', '1972-11-06 20:00:25', '1986-12-01 05:34:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Roberta', 'Maggio', 'ywelch@example.net', '+22(4)8608820161', '2007-02-20 17:06:31', '1971-07-24 06:16:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Bo', 'Stark', 'dickens.dora@example.org', '+29(2)1615500127', '2015-03-26 16:51:10', '1996-06-15 03:34:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Elton', 'Ruecker', 'mateo04@example.org', '691.596.1509x37365', '2007-12-23 08:24:59', '1988-07-18 01:18:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Hassie', 'Wisozk', 'jmckenzie@example.com', '04715813579', '2012-03-31 00:07:19', '1999-12-10 13:10:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Lilian', 'Barrows', 'hlowe@example.net', '(812)379-1566', '1975-07-13 13:48:45', '2020-07-23 03:30:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Maye', 'Sauer', 'cruickshank.gaylord@example.net', '(679)579-6266x1374', '2002-07-20 14:55:24', '1984-01-04 03:50:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Eloise', 'Hilll', 'mattie82@example.com', '(110)073-0858', '1995-04-09 04:32:12', '1986-03-31 11:10:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Lucas', 'Pfannerstill', 'qbaumbach@example.org', '1-388-377-1788', '1980-10-16 14:32:24', '2021-02-15 22:47:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Forrest', 'Eichmann', 'davis.leone@example.org', '+84(9)3890783064', '2017-03-10 18:43:59', '1988-02-05 21:29:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Taryn', 'Halvorson', 'nadia83@example.com', '865-324-3616', '1996-01-27 14:48:47', '1986-03-02 12:20:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Darrick', 'Nikolaus', 'lschimmel@example.net', '224.713.1579', '1995-12-19 21:30:49', '2000-05-04 05:01:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Sonya', 'Hessel', 'samir73@example.net', '08617722438', '1978-11-24 12:18:52', '2006-10-25 22:43:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Christophe', 'Bernhard', 'william41@example.org', '(051)494-7622x9862', '1991-01-29 06:29:49', '2010-11-09 04:58:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Helena', 'Yundt', 'jarret.erdman@example.org', '1-038-641-7532', '1984-02-10 14:03:58', '2006-12-08 06:11:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Audra', 'Weber', 'stamm.lelia@example.com', '321.597.9642', '2011-12-04 12:10:18', '1973-07-15 11:12:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Celestino', 'Labadie', 'dfisher@example.net', '259.624.9113x6330', '1971-11-26 09:03:53', '1983-11-30 02:50:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Zander', 'Mueller', 'moore.orval@example.com', '919.456.8374x3995', '1994-04-20 12:32:25', '1987-12-03 05:24:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Roderick', 'Kuphal', 'maia.grady@example.org', '835.929.3149x74343', '2008-07-14 11:47:02', '1985-03-27 10:43:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Santino', 'O\'Kon', 'bechtelar.erna@example.org', '600-933-8144x89228', '1981-05-09 08:30:09', '2007-03-19 16:02:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Darryl', 'Prosacco', 'fannie.hagenes@example.com', '944.710.6955x292', '2012-11-01 17:14:33', '1973-07-15 16:28:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Alayna', 'Fay', 'medhurst.suzanne@example.net', '05810277954', '1992-12-25 14:22:09', '1989-08-21 17:30:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Hilton', 'Glover', 'bogan.kirstin@example.org', '064-273-6284x192', '1977-09-12 17:38:44', '1978-04-20 10:18:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Lawson', 'Simonis', 'nelson65@example.org', '713.204.4837', '2007-04-02 10:00:13', '2010-01-31 03:26:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Dolly', 'Watsica', 'sgerhold@example.net', '+15(1)7885155865', '1982-03-07 08:58:28', '2001-05-02 10:21:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Jabari', 'Spinka', 'reva.bartoletti@example.com', '(702)985-4820', '1994-01-16 08:54:49', '2020-09-24 18:54:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Wilhelm', 'Walker', 'madaline01@example.org', '(933)469-1055x809', '2002-05-27 07:10:31', '1970-03-25 10:25:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Clarabelle', 'Koelpin', 'ambrose.kub@example.org', '682-151-1513x0569', '2011-09-27 09:29:02', '2018-11-08 10:52:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Doris', 'Ferry', 'welch.abelardo@example.com', '(221)762-5958', '2007-02-25 11:41:56', '1975-06-19 12:26:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Al', 'Frami', 'cortney.stamm@example.net', '(910)813-9916', '1972-10-09 21:24:19', '1999-05-12 13:28:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Oceane', 'Renner', 'violet.durgan@example.com', '01793752534', '1987-03-19 23:35:09', '1976-10-05 01:02:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Seth', 'Kuhic', 'ima26@example.com', '168.769.0766x8227', '2018-04-06 11:15:53', '1970-09-07 12:33:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Kiera', 'Kling', 'rosamond66@example.org', '636.235.5396', '2004-11-04 23:08:02', '2017-08-26 23:32:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Rosie', 'Hickle', 'bjacobs@example.com', '321-575-2184', '2010-09-16 01:21:24', '2012-05-18 15:16:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Janet', 'Bernhard', 'xkoepp@example.com', '+66(5)5041388866', '1998-08-07 12:54:20', '2020-02-02 21:50:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Cassandre', 'Gutkowski', 'george.ernser@example.org', '031.300.6573', '2005-02-08 10:11:22', '2016-11-27 00:27:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Marcelle', 'Ruecker', 'iblanda@example.net', '(344)622-0011', '1971-03-10 23:05:41', '2011-08-16 01:35:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Marcel', 'Miller', 'osmith@example.org', '(837)417-7110', '2014-11-18 14:19:21', '1978-10-15 04:43:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Jayson', 'Reichel', 'pierre.eichmann@example.com', '946-011-9924x779', '1988-01-19 05:42:49', '2004-08-03 04:04:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Bethany', 'Abbott', 'anibal.cormier@example.net', '+71(8)2098678944', '1974-02-27 23:36:52', '2003-09-09 21:56:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Dianna', 'Witting', 'malvina32@example.net', '(536)644-1752x751', '1995-01-24 16:48:39', '1975-06-03 19:26:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Hazel', 'Hoppe', 'zhahn@example.net', '098.846.0572x1406', '1985-03-07 13:22:01', '1987-03-26 16:47:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Brendon', 'Feil', 'janice.effertz@example.com', '1-029-454-7073', '2017-04-13 18:48:51', '2013-04-26 10:01:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Haven', 'Walter', 'elise01@example.org', '480-158-7234x6160', '2005-06-08 20:05:32', '1979-04-30 17:32:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Bryce', 'Reichel', 'rbogan@example.com', '225.027.8004', '1984-11-12 13:23:25', '2006-09-23 05:50:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Coy', 'Dickens', 'waltenwerth@example.net', '+65(1)7743913310', '2000-07-12 16:33:54', '1985-10-01 17:32:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Jeanne', 'O\'Hara', 'worn@example.org', '747.528.7823x0504', '2010-12-25 07:17:08', '2008-01-13 05:13:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Jane', 'Lueilwitz', 'schulist.coby@example.net', '(740)499-0936', '1976-09-21 01:36:54', '2008-03-17 15:50:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Giuseppe', 'Turner', 'eileen44@example.org', '+08(0)0964514741', '2020-09-23 01:11:05', '2013-05-30 00:30:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Rocky', 'Berge', 'wcremin@example.com', '442-511-9909x326', '1972-03-11 20:49:26', '1988-06-24 12:26:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Lacy', 'Schultz', 'raoul.roob@example.org', '070.588.2013x28381', '2009-10-21 07:01:25', '1987-05-23 05:37:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Kimberly', 'Huels', 'elvie.gleichner@example.com', '1-261-606-9170', '1986-12-30 03:48:45', '1987-03-22 14:59:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Royce', 'Beier', 'kromaguera@example.com', '344.895.9139x5577', '1982-04-26 02:47:43', '2002-11-25 23:37:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Leila', 'Hammes', 'volkman.sonya@example.net', '(444)593-2842x67491', '1998-08-04 19:34:58', '1990-03-11 17:27:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Lloyd', 'Langosh', 'naomi24@example.org', '07643205285', '1987-05-29 20:42:29', '1976-09-28 21:55:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Susana', 'Stoltenberg', 'crist.brandi@example.net', '+64(8)9910572191', '1995-10-01 05:59:45', '1976-03-28 05:07:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Camila', 'Schmitt', 'casimer.cronin@example.org', '660.667.7684x11953', '1987-03-24 15:44:25', '2015-11-21 05:45:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Antwan', 'Funk', 'noble.torp@example.org', '07800792392', '2000-03-08 17:15:55', '2000-07-01 22:22:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Eudora', 'Rolfson', 'egorczany@example.net', '+12(8)4298440154', '2015-03-07 04:03:28', '2010-12-12 19:38:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Ettie', 'Doyle', 'joaquin58@example.net', '(551)069-4363x28784', '2017-07-01 03:13:51', '2009-10-25 03:17:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Dustin', 'Bechtelar', 'ashleigh70@example.net', '272-667-3817x0581', '2000-06-12 14:19:11', '1998-03-18 08:48:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Wilfred', 'Kemmer', 'cronin.noemy@example.com', '480.983.1925', '1972-01-01 06:54:46', '2005-03-01 06:23:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Nickolas', 'Brakus', 'marlin.bogan@example.net', '826.492.5109', '1989-11-22 23:58:36', '2010-04-17 03:51:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Herminia', 'Kozey', 'bwalter@example.org', '169.044.8974', '2001-07-21 11:32:50', '1972-07-06 05:29:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Leonie', 'Streich', 'tyson64@example.com', '000-351-2469x900', '1988-07-10 12:26:45', '2015-01-19 16:50:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Lupe', 'Gleason', 'emelie.morissette@example.org', '1-189-696-3715x52311', '2017-05-06 18:40:40', '2004-09-01 02:21:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Alexandre', 'Wehner', 'konopelski.maud@example.org', '668.085.8751', '1991-02-19 00:35:57', '2007-09-23 05:34:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Cordie', 'Monahan', 'karelle.hayes@example.net', '696-879-8646x6134', '1999-03-30 14:41:23', '2000-03-03 17:50:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Jerome', 'Hudson', 'hodkiewicz.deanna@example.com', '1-356-514-3747', '2015-09-08 12:41:22', '1986-09-10 14:59:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Owen', 'Bins', 'bret.rau@example.net', '1-142-406-1784x5560', '1978-12-05 22:51:03', '2006-08-15 16:06:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Waldo', 'Nicolas', 'marques.wehner@example.org', '719.779.7612', '1995-05-07 13:09:26', '2007-10-31 12:42:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Annie', 'Jacobs', 'oswald17@example.com', '012.456.7238', '1981-08-06 17:01:32', '1970-11-03 09:10:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Nikko', 'Miller', 'hand.rene@example.com', '1-555-420-0409x1149', '2003-01-06 15:52:22', '1997-07-11 14:22:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Gretchen', 'Krajcik', 'friesen.joanny@example.com', '(227)968-8733x844', '2012-10-27 10:29:15', '2003-04-01 20:39:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Amaya', 'Hamill', 'stehr.garland@example.net', '1-699-360-2660x885', '1981-03-30 20:08:52', '2020-05-16 00:47:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Lonie', 'Koss', 'antonetta59@example.com', '+40(7)5384719712', '2017-03-05 01:29:56', '2020-09-29 03:56:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Trystan', 'Trantow', 'ward.vincenza@example.net', '1-635-516-6559x70691', '2008-05-03 17:25:06', '1981-04-18 21:23:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Ben', 'Hintz', 'xruecker@example.net', '(358)309-7902', '2011-03-07 06:43:30', '2010-09-17 08:03:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Abbie', 'Wiza', 'ryleigh12@example.com', '660-036-7605x681', '2004-12-11 10:27:10', '1994-12-03 09:42:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Rey', 'Reichert', 'welch.bernardo@example.org', '(119)799-5884', '1994-11-09 08:48:08', '1974-04-08 03:45:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Brian', 'Bashirian', 'jwolff@example.com', '1-435-171-7912x6652', '2014-08-10 11:50:01', '1997-05-09 16:19:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Linda', 'Klein', 'xbrown@example.net', '1-801-906-0982', '1993-06-04 20:25:26', '2020-10-13 22:28:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Ramon', 'Bauch', 'zackery.kiehn@example.com', '532.688.8023', '1977-11-24 16:36:01', '2011-07-15 17:42:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Nat', 'Renner', 'savanah74@example.com', '(421)944-0986x4482', '1980-05-23 15:00:15', '1974-12-17 14:08:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Chasity', 'Pouros', 'olson.cheyanne@example.net', '863.392.9802x362', '1995-05-28 11:39:45', '2002-06-08 14:19:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Andy', 'Parisian', 'maynard97@example.com', '+26(9)1052665176', '1972-10-10 03:31:49', '1997-03-19 09:51:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Ned', 'Goldner', 'russel.tito@example.com', '(911)916-4331', '1998-11-13 03:42:11', '2010-04-26 00:47:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Marcelina', 'Wunsch', 'gkohler@example.org', '052-919-1349x5405', '1991-07-12 17:44:43', '1992-07-01 03:06:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Lucile', 'Sipes', 'qkuhic@example.org', '(006)839-9580x802', '1980-03-03 15:33:03', '1980-06-03 15:22:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Felix', 'Bradtke', 'brakus.libby@example.org', '611.802.6356x32352', '2012-10-01 07:17:13', '1980-12-08 01:47:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Kylie', 'Koss', 'pattie78@example.net', '(057)024-1821x38884', '2001-01-03 19:43:37', '1971-10-11 05:10:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Emanuel', 'Bernier', 'liliane37@example.net', '08887555775', '2019-08-09 04:23:17', '1977-01-01 12:54:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Max', 'Pacocha', 'lennie.conroy@example.org', '214.523.1817', '2011-04-24 15:29:41', '1978-07-07 18:33:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Clementine', 'Harber', 'bspinka@example.org', '230-541-5390', '1982-09-11 11:39:38', '1976-03-04 18:29:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Justyn', 'Hane', 'graham.ashley@example.org', '+46(5)8698325662', '1989-10-14 20:16:39', '1990-10-21 14:21:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Odell', 'Weber', 'hortense49@example.org', '1-805-220-6302', '1976-04-26 04:16:49', '1970-06-25 01:24:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Zackary', 'Conn', 'hans.cremin@example.net', '663.613.3918x036', '2004-09-10 09:50:01', '2003-08-17 17:29:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Precious', 'Kohler', 'brohan@example.org', '1-385-299-8903', '1978-01-24 03:26:59', '2020-01-29 17:21:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Roman', 'Towne', 'eric.paucek@example.net', '07789423106', '1982-09-08 17:18:50', '2018-01-28 13:30:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Irving', 'O\'Hara', 'ibashirian@example.net', '155.550.0675', '1982-06-27 03:30:46', '1993-01-09 16:47:02');

-- заполнем часть профайлов

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`) values (11, 'm', '1975-01-09', 'Rome', 'Italy');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`) values (1, 'm', '1985-10-03', 'Moscow', 'Russia');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city`, `country`) values (86, 'f', '1979-09-21', 'London', 'Great Britain');

select * from `profiles`;


-- заполняем таблицу статусов дружбы

insert into `friendship_statuses` (`name`) values ('принял');
insert into `friendship_statuses` (`name`) values ('отказал');
insert into `friendship_statuses` (`name`) values ('подписчик');


-- заполняем таблицу дружбы

insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (5,11,1,'2020-03-29','2020-03-30');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (5,15,2,'2020-08-12','2020-08-15');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (45,14,2,'2020-05-08','2020-05-30');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (45,42,3,'2020-11-22','2020-11-22');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (88,8,1,'2020-12-01','2020-12-03');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (17,88,2,'2020-02-18','2020-02-19');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (12,3,1,'2020-02-23','2020-02-28');
insert into `friendship` (`user_id`, `friend_id`, `friendship_status_id`, `requested_at`, `confirmed_at`) values (12,5,2,'2020-01-17','2020-01-17');

-- Таблица сообщений
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";

-- звполняем таблицу сообщений

insert into `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) values (5,15,'Привет, Давай познакомимся?', 0,1);
insert into `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) values (18,43,'Привет, как дела', 0,1);
insert into `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) values (2,88,'Привет, я скучал', 0,1);
insert into `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) values (5,97,'Привет, почему ты меня игнорируешь?', 1,1);
insert into `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) values (5,3,'Привет, ты сделал домашку?', 1,0);



-- заполняем таблицу групп

insert into `communities` (`name`) values ('клуб любителей кошечек');
insert into `communities` (`name`) values ('прыжки с вышки');
insert into `communities` (`name`) values ('клуб путешественников');
insert into `communities` (`name`) values ('школа 1122');
insert into `communities` (`name`) values ('любители отечественных авто');
insert into `communities` (`name`) values ('отдых в России');

-- заполняем таблицу связей пользователей и групп

insert into `communities_users` (`community_id`, `user_id`) values (3,9);
insert into `communities_users` (`community_id`, `user_id`) values (3,74);
insert into `communities_users` (`community_id`, `user_id`) values (1,52);
insert into `communities_users` (`community_id`, `user_id`) values (1,12);
insert into `communities_users` (`community_id`, `user_id`) values (1,46);
insert into `communities_users` (`community_id`, `user_id`) values (2,67);
insert into `communities_users` (`community_id`, `user_id`) values (2,66);
insert into `communities_users` (`community_id`, `user_id`) values (4,23);
insert into `communities_users` (`community_id`, `user_id`) values (4,46);
insert into `communities_users` (`community_id`, `user_id`) values (4,80);
insert into `communities_users` (`community_id`, `user_id`) values (5,46);
insert into `communities_users` (`community_id`, `user_id`) values (6,74);


-- заполняем таблицу типов медиафайлов

INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'temporibus', '2014-02-15 09:35:30', '1983-11-19 13:31:41');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'doloribus', '1971-01-18 11:11:47', '2007-06-04 19:16:45');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'magni', '1978-10-12 07:27:25', '1994-09-19 16:20:11');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'debitis', '1982-06-16 11:49:29', '2017-10-02 15:50:32');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'autem', '1994-09-28 04:30:34', '1970-11-26 00:51:12');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (6, 'quasi', '1992-01-13 04:26:42', '2021-01-30 07:05:47');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (7, 'architecto', '2013-03-27 15:52:53', '1990-05-17 07:13:40');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (8, 'nobis', '2011-07-17 13:16:51', '2018-02-16 16:41:00');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (9, 'cupiditate', '2011-04-09 20:21:50', '1989-05-02 06:00:22');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (10, 'similique', '1977-11-18 00:10:35', '2018-12-08 15:47:00');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (11, 'ut', '2018-03-05 14:27:18', '1980-03-27 11:01:59');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (12, 'laborum', '2014-11-30 14:32:00', '2003-04-26 10:46:54');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (13, 'natus', '2001-10-11 23:42:02', '2005-04-29 17:50:57');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (14, 'voluptas', '2011-07-10 19:26:28', '2020-08-20 23:11:41');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (15, 'corporis', '1987-03-30 06:00:23', '1975-03-20 15:26:05');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (16, 'animi', '2001-06-10 00:18:06', '2000-12-22 10:57:51');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (17, 'quia', '1997-12-04 06:00:05', '1970-10-26 00:59:39');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (18, 'et', '2017-03-15 17:04:06', '2021-01-04 01:21:51');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (19, 'aspernatur', '1993-02-08 10:49:53', '2019-12-20 07:08:46');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (20, 'aut', '1999-01-15 10:43:30', '1991-03-12 14:14:07');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (21, 'rerum', '1990-03-13 23:29:19', '2011-02-21 16:17:11');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (22, 'officia', '1993-03-27 03:23:16', '2008-10-04 20:48:51');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (23, 'perferendis', '1994-06-23 23:30:38', '1991-01-16 04:54:51');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (24, 'repudiandae', '1997-01-09 13:28:44', '2015-07-22 17:57:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (25, 'alias', '1970-01-15 11:10:24', '2004-07-05 17:43:42');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (26, 'vero', '1975-10-17 00:55:10', '2011-10-21 15:44:16');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (27, 'aliquid', '2017-03-08 08:18:26', '1971-10-02 17:42:26');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (28, 'ea', '2012-09-24 11:41:58', '1994-09-21 16:31:32');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (29, 'labore', '1979-05-20 03:45:32', '2017-12-16 14:47:27');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (30, 'laboriosam', '1980-06-07 09:05:24', '2000-11-21 02:49:58');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (31, 'qui', '1988-11-09 08:03:48', '2000-11-07 11:20:28');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (32, 'sunt', '2016-04-06 18:33:33', '1972-03-26 00:30:52');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (33, 'odio', '2006-02-14 15:21:08', '1976-07-16 17:21:14');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (34, 'fuga', '1999-02-21 07:03:48', '2017-02-28 07:16:37');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (35, 'aperiam', '1982-05-01 04:48:35', '1978-07-20 06:41:45');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (36, 'est', '2010-09-08 23:54:14', '2009-09-24 00:00:30');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (37, 'ullam', '1974-09-05 03:58:18', '1980-11-13 00:00:34');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (38, 'velit', '2005-10-28 18:25:59', '2003-01-07 11:28:29');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (39, 'nihil', '1978-06-05 07:57:02', '2010-03-03 20:20:58');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (40, 'id', '2019-01-24 03:15:31', '1976-12-11 22:26:42');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (41, 'ratione', '1978-01-02 11:19:43', '1986-01-24 05:38:10');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (42, 'corrupti', '1995-01-09 12:38:39', '2008-04-21 19:07:29');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (43, 'doloremque', '1992-06-01 13:54:26', '2005-08-28 00:38:01');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (44, 'dolores', '1984-07-27 14:02:37', '2014-08-14 21:13:10');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (45, 'voluptatem', '1991-04-02 11:24:21', '1974-07-06 20:41:20');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (46, 'voluptate', '2007-10-11 16:14:18', '2006-11-04 15:32:17');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (47, 'ipsa', '2009-02-04 02:10:45', '2017-03-30 06:54:09');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (48, 'cum', '1993-11-14 05:49:43', '1979-02-27 22:12:51');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (49, 'neque', '1976-08-01 14:19:16', '1997-01-04 15:07:30');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (50, 'veniam', '1989-03-18 05:46:36', '2011-04-13 05:02:42');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (51, 'accusantium', '1973-12-26 04:29:56', '1998-06-21 06:46:45');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (52, 'consequatur', '1997-10-25 10:25:27', '2010-09-16 14:21:00');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (53, 'dolorem', '1990-01-27 00:32:34', '2012-03-28 07:52:03');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (54, 'in', '2003-11-27 21:38:33', '1995-06-10 05:04:44');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (55, 'deserunt', '2015-04-16 07:46:42', '2006-05-14 12:53:00');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (56, 'quas', '1994-08-09 21:46:45', '1981-10-17 18:07:01');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (57, 'perspiciatis', '1980-11-21 01:10:01', '1980-03-06 22:23:29');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (58, 'nostrum', '1985-11-13 10:15:35', '2006-05-13 07:32:11');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (59, 'inventore', '1986-05-03 02:22:17', '1984-01-12 11:51:17');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (60, 'iure', '1971-02-13 08:15:14', '1989-10-25 14:34:25');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (61, 'molestiae', '1995-07-14 19:17:14', '2010-03-22 10:35:44');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (62, 'quod', '2007-03-19 11:30:33', '2010-05-31 16:32:19');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (63, 'quaerat', '1982-05-21 10:15:12', '1973-02-12 22:39:47');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (64, 'quisquam', '2003-03-19 19:08:38', '1997-02-17 01:05:29');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (65, 'incidunt', '1979-01-20 02:21:52', '2015-03-05 09:17:40');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (66, 'a', '2009-12-19 06:06:25', '2020-06-14 05:19:19');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (67, 'nemo', '2009-08-25 19:15:34', '1987-01-01 00:33:31');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (68, 'beatae', '1974-08-11 05:59:36', '1996-04-21 23:42:41');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (69, 'non', '2004-11-24 00:22:11', '1980-06-24 01:37:54');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (70, 'facere', '1984-06-05 00:19:01', '2008-11-26 03:23:57');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (71, 'numquam', '1990-04-05 19:23:50', '1972-04-10 23:25:57');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (72, 'eligendi', '2016-05-31 16:40:20', '2004-01-17 01:49:50');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (73, 'porro', '2003-09-17 04:24:19', '2010-04-30 18:00:54');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (74, 'quo', '2016-06-13 09:53:26', '2010-11-07 17:05:09');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (75, 'magnam', '2018-03-04 23:55:40', '1983-01-09 01:51:34');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (76, 'veritatis', '1989-11-18 18:27:54', '2016-01-23 09:16:24');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (77, 'exercitationem', '1985-07-02 21:58:54', '2001-10-05 13:44:50');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (78, 'possimus', '1979-11-18 13:55:33', '1977-03-30 17:13:15');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (79, 'tempora', '2016-03-19 06:49:39', '1986-03-25 14:16:47');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (80, 'ad', '1970-01-23 00:08:10', '1998-10-31 14:19:27');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (81, 'distinctio', '1972-11-05 11:49:52', '2012-09-30 00:26:57');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (82, 'amet', '1983-08-16 02:24:16', '1989-01-21 19:35:04');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (83, 'quis', '1979-12-12 20:30:21', '1980-07-03 12:28:42');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (84, 'asperiores', '1971-08-08 11:18:12', '2013-08-20 12:17:55');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (85, 'dicta', '1987-07-28 13:00:15', '2017-10-16 13:46:25');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (86, 'sit', '1999-06-16 09:56:10', '2009-06-04 05:12:43');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (87, 'suscipit', '2012-05-23 02:22:15', '2018-01-12 11:50:00');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (88, 'accusamus', '1980-09-24 02:30:28', '2004-09-15 07:28:10');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (89, 'earum', '2014-04-29 05:07:42', '2002-02-08 06:08:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (90, 'facilis', '2014-06-07 00:41:37', '2001-09-17 15:36:55');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (91, 'optio', '2014-09-15 19:26:34', '1982-11-12 15:59:42');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (92, 'tenetur', '1992-03-21 21:40:27', '1992-08-14 20:53:03');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (93, 'sint', '2010-01-25 21:46:42', '1983-04-12 02:59:45');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (94, 'dolor', '1989-01-04 22:24:34', '1993-08-04 20:25:50');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (95, 'eum', '1984-02-29 00:01:35', '1999-10-13 16:20:38');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (96, 'impedit', '1998-12-02 14:11:04', '1986-06-06 17:39:28');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (97, 'quidem', '1978-02-09 18:04:54', '2003-06-13 17:05:24');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (98, 'eos', '2008-12-18 16:03:04', '1991-01-07 02:14:05');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (99, 'adipisci', '1971-06-23 02:23:23', '1983-12-27 16:21:47');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'itaque', '1989-03-28 03:59:36', '1978-04-08 08:15:05');



--  заполняем таблицу медиа

INSERT into `media` (`user_id`, `filename`, `size`, `media_type_id`) values (5,'Кошечка', 888, 18);
INSERT into `media` (`user_id`, `filename`, `size`, `media_type_id`) values (63,'Кошечка с тарелкой', 745, 77);
INSERT into `media` (`user_id`, `filename`, `size`, `media_type_id`) values (18,'Кошечка на столе', 1200, 18);
INSERT into `media` (`user_id`, `filename`, `size`, `media_type_id`) values (18,'Кошечка спит', 95, 32);

-- заполняем таблицу с лайками медиафайлов пользователями


INSERT into `likes_users` (`media_id`, `user_id`) values (4,5);
INSERT into `likes_users` (`media_id`, `user_id`) values (1,45);
INSERT into `likes_users` (`media_id`, `user_id`) values (1,12);
INSERT into `likes_users` (`media_id`, `user_id`) values (2,23);
INSERT into `likes_users` (`media_id`, `user_id`) values (2,58);
INSERT into `likes_users` (`media_id`, `user_id`) values (2,12);