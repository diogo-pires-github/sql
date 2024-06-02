-- Inventory Management System for an Electronics Store

-- Creating a database

CREATE DATABASE eletronics_store;

-- Creating the tables

CREATE TABLE `branches` (
  `branch_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
   PRIMARY KEY (`branch_id`)
);


CREATE TABLE `categories` (
  `category_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL,
   PRIMARY KEY (`category_id`)
);


CREATE TABLE `customer_accounts` (
  `customer_account_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `family_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `account_creation_date` timestamp DEFAULT NOW(),
  `date_of_birth` datetime DEFAULT NULL,
   PRIMARY KEY (`customer_account_id`)
); 

CREATE TABLE `vendors` (
  `vendor_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(100) DEFAULT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `vendors_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  PRIMARY KEY (`vendor_id`)
);

CREATE TABLE `locations` (
  `location_id` bigint unsigned NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `post_code` varchar(100) DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `relation_type` varchar(100) DEFAULT NULL,
  `relation_id` bigint unsigned DEFAULT NULL,
   PRIMARY KEY (`location_id`)
); 

CREATE TABLE `products` (
  `product_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `quantity_available` int DEFAULT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
);


CREATE TABLE `orders` (
  `order_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_account_id` bigint unsigned DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_account_id` (`customer_account_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_account_id`) REFERENCES `customer_accounts` (`customer_account_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`)
);


CREATE TABLE `order_items` (
  `order_item_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
);

CREATE TABLE `reviews` (
  `review_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_account_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comments` text,
  `review_date` date DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `customer_account_id` (`customer_account_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`customer_account_id`) REFERENCES `customer_accounts` (`customer_account_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
);


CREATE TABLE `logs` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varchar(50) DEFAULT NULL,
  `log_description` text,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`)
);

-- Inserting data

INSERT INTO `categories` (`category_name`, `parent_id`)
VALUES
('Electronics', NULL), -- Parent category for electronics
('Phones', 1),         -- Subcategory under Electronics
('Laptops', 1),        -- Subcategory under Electronics
('Tablets', 1),        -- Subcategory under Electronics
('Accessories', 1),    -- Subcategory under Electronics
('Smartphones', 2),    -- Subcategory under Phones
('Feature Phones', 2), -- Subcategory under Phones
('Gaming Laptops', 3), -- Subcategory under Laptops
('Business Laptops', 3), -- Subcategory under Laptops
('Android Tablets', 4), -- Subcategory under Tablets
('iOS Tablets', 4),    -- Subcategory under Tablets
('Chargers', 5),       -- Subcategory under Accessories
('Cases', 5),          -- Subcategory under Accessories
('Headphones', 5),     -- Subcategory under Accessories
('Phone Mounts', 5),   -- Subcategory under Accessories
('Screen Protectors', 5), -- Subcategory under Accessories
('Earbuds', 14),       -- Subcategory under Headphones
('Over-ear Headphones', 14), -- Subcategory under Headphones
('Wireless Chargers', 12), -- Subcategory under Chargers
('Portable Chargers', 12);  -- Subcategory under Chargers
-- Add more subcategories as needed...


INSERT INTO `branches` (`branch_name`, `phone_number`, `email`) VALUES ('Baptista', '(351) 220894796', 'gomesjorge@example.org'),
('Ramos', '(351) 925 778 944', 'aliciamonteiro@example.com'),
('Lourenço', '(351) 910816155', 'pcarneiro@example.org'),
('Martins', '924 024 677', 'gustavorodrigues@example.net'),
('Domingues S/A', '+351930345538', 'kevim25@example.org'),
('Pacheco', '(351) 911 908 843', 'erica25@example.org'),
('Correia', '(351) 963270877', 'rvicente@example.org'),
('Ribeiro Pinto e Filhos', '(351) 926 286 534', 'machadolaura@example.org'),
('Oliveira', '964 330 710', 'helena38@example.net'),
('Magalhães S/A', '(351) 246693080', 'carminhorodrigues@example.org');



INSERT INTO `vendors` (`vendor_name`, `contact_info`, `branch_id`) VALUES ('TechNova', 'Rua de Sá, S/N
3064-370 Vila Real', 1),
('FutureGizmos', 'Largo Miranda, 5
3707-140 Mêda', 1),
('EcoGadget Works', 'Alameda de Magalhães, 4
0355-741 Portalegre', 1),
('FutureGizmos', 'Travessa Pinho, S/N
2978-031 Montijo', 1),
('TechNova', 'Largo de Luís António Verney, S/N
5084-299 Macedo de Cavaleiros', 1),
('E-Savvy Solutions', 'Alameda Cardeal Cerejeira, 646
7775-251 Santa Comba Dão', 1),
('TechSavant Hub', 'Travessa Vaz, 7
6754-640 Póvoa de Santa Iria', 1),
('TechMart', 'Praça Kevin Gonçalves, 7
2834-259 Vale de Cambra', 1),
('ElectroByte', 'Avenida de Loureiro, 305
5386-007 Lagos', 1),
('QuantumGizmo', 'Avenida Moreira, 3
6926-297 Coimbra', 1),
('ElecTroop', 'Avenida de Silva, 82
9574-634 Leiria', 2),
('DigitalTech', 'Avenida do Castelo, 26
5439-304 Vila Nova de Santo André', 2),
('QuantumGizmo', 'Rua Carlos Abreu, 27
0336-487 Fundão', 2),
('DigitalTech', 'Praça de Castro, S/N
1254-485 Fafe', 2),
('NanoTech Empire', 'Alameda das Fontainhas, 58
2758-814 Lagoa', 2),
('FutureGizmos', 'Praça de Miranda, S/N
4449-286 Abrantes', 2),
('ElecTronics', 'Avenida Pinto, 990
2851-356 Moura', 2),
('ElectroSphere', 'R. dos Oceanos, S/N
4030-481 Peniche', 2),
('TechSavant Hub', 'Travessa de Henriques, 1
3733-294 Ermesinde', 2),
('QuantumGizmo', 'Largo Luísa Amorim, S/N
6839-447 Valbom', 2),
('NanoTech Empire', 'Avenida do Buraco, 7
3195-656 Tondela', 3),
('iDeviceHub', 'Travessa de Magalhães, 73
2069-570 Santana', 3),
('QuantumGizmo', 'Av Antunes, 574
4482-609 Tarouca', 3),
('DigitalDynamo', 'Av de Assunção, 8
3074-353 Cantanhede', 3),
('FutureGizmos', 'Travessa de Matos, 16
8062-030 Alverca do Ribatejo', 3),
('E-Savvy Solutions', 'Alameda Sandro Matos, 5
4094-874 Covilhã', 3),
('SmartTech Solutions', 'Praça Alves, S/N
7777-223 Barreiro', 3),
('iDeviceHub', 'Avenida Fernando Alves, 3
0770-003 Ílhavo', 3),
('SmartFuture Devices', 'Alameda do Meiral, S/N
1840-752 Felgueiras', 3),
('InnoGadgets', 'Alameda de Amaral, 80
3448-409 Portimão', 3),
('ElecTroop', 'Travessa de Alves, 46
3575-379 Montemor-o-Novo', 4),
('TechNova', 'Avenida Maria José Moura, 58
0515-693 São Mamede de Infesta', 4),
('TechGenius Inc.', 'Alameda Barbosa, 6
8198-361 Fafe', 4),
('GadgetZone', 'Praça Vitória Cruz, 26
8082-371 Figueira da Foz', 4),
('TechGenius Inc.', 'Rua Gaspar, S/N
5437-363 Gafanha da Nazaré', 4),
('EcoGadget Works', 'Avenida Dinis Teixeira, 10
0039-410 Lisboa', 4),
('FutureGizmos', 'Alameda Esteves, 6
9650-126 Peso da Régua', 4),
('DigitalTech', 'Rua da Beneditina, 6
1126-788 Ourém', 4),
('DigitalDynamo', 'Avenida Salvador Gonçalves, 3
1069-193 Bragança', 4),
('TechNova', 'Rua de Faria, S/N
9217-785 Quarteira', 4),
('iDeviceHub', 'Rua de Baptista, S/N
0160-474 Serpa', 5),
('E-World', 'Largo Garcia, 56
6595-828 Serpa', 5),
('E-Savvy Solutions', 'R. de Eça de Queirós, 57
6113-208 Vizela', 5),
('QuantumGizmo', 'Praça de Cruz, 876
4223-241 Freamunde', 5),
('ElectroSphere', 'Praça Rúben Mendes, 351
6571-337 Freamunde', 5),
('EcoGadget Works', 'Alameda de Monteiro, 241
1085-454 Horta', 5),
('EcoGadget Works', 'Avenida de Machado, 7
8791-802 Trancoso', 5),
('TechNova', 'Praça Tatiana Matias, 46
9716-328 Valpaços', 5),
('TechGenius Inc.', 'Praça Catarina Rocha, 46
0776-002 Portalegre', 5),
('EcoGadget Works', 'Avenida Rúben Castro, 79
8021-920 Vila Franca de Xira', 5),
('MegaGadget Store', 'R. da Fonte de Cima, 3
3140-810 Esmoriz', 6),
('TechNova', 'Rua Manuel Garcia, S/N
9880-678 Entroncamento', 6),
('ElectroByte', 'Praça de Neto, 64
4332-968 Fafe', 6),
('QuantumGizmo', 'Praça da Póvoa, 77
8355-154 Miranda do Douro', 6),
('FutureGizmos', 'Praça Nelson Mota, 662
0142-441 Gondomar', 6),
('TechGenius Inc.', 'Rua Rita Mota, 571
5230-484 Seixal', 6),
('ElecTroop', 'Travessa dos Navegadores, 72
8707-146 Lixa', 6),
('ElecTronics', 'Av de Antunes, 87
1589-585 Lamego', 6),
('SmartFuture Devices', 'Praça de Valente, 4
7280-125 Queluz', 6),
('NanoTech Empire', 'Avenida de Vicente, 7
3013-188 Fiães', 6),
('GigaGadget Co.', 'Avenida do Pimenta, 781
5473-751 Lisboa', 7),
('SmartFuture Devices', 'Largo Vieira, S/N
0728-421 Ribeira Grande', 7),
('TechNova', 'Travessa Alfredo Keil, 661
1892-365 Tavira', 7),
('FutureGizmos', 'R. de Morais, 490
9854-739 Cantanhede', 7),
('ElectroByte', 'Av das Naus, 22
1246-084 Pombal', 7),
('ElectroByte', 'Avenida de Soares, 95
4895-857 Póvoa de Varzim', 7),
('NanoTech Empire', 'Alameda Letícia Cardoso, 36
1995-700 Paços de Ferreira', 7),
('ElectroVision', 'Av de Melo, 1
5523-238 Chaves', 7),
('TechGenius Inc.', 'Largo do Longo, S/N
4748-525 Valbom', 7),
('FutureGizmos', 'Alameda de Figueiredo, S/N
5253-099 Caldas da Rainha', 7),
('ElectroByte', 'Av Micael Macedo, S/N
1584-950 Albufeira', 8),
('ElectroSphere', 'Largo de Valente, S/N
1484-280 Faro', 8),
('InnoGadgets', 'Rua Vaz, 2
4141-949 Rio Maior', 8),
('DigitalDynamo', 'Largo do Seminário, 34
7074-855 Santo Tirso', 8),
('TechSavant Hub', 'Avenida Maria Gomes, 79
9840-349 Estremoz', 8),
('DigitalTech', 'Rua Araújo, 3
1307-898 Covilhã', 8),
('E-Savvy Solutions', 'Largo de Gonçalves, 48
7955-975 Alverca do Ribatejo', 8),
('TechNova', 'Travessa Domingues, 71
8742-673 Vale de Cambra', 8),
('iDeviceHub', 'Alameda de Melo, 8
5048-117 Marco de Canaveses', 8),
('TechSavant Hub', 'Rua Salvador Moreira, 77
0672-598 Coimbra', 8),
('SmartFuture Devices', 'Rua de Neves, S/N
7141-705 Oliveira do Bairro', 9),
('ElecTroop', 'Largo Bernardo Pinto, 716
2729-108 Quarteira', 9),
('DigitalDynamo', 'Praça Barros, 12
5624-041 Leiria', 9),
('E-World', 'Av Ribeiro, 60
0941-522 Santiago do Cacém', 9),
('QuantumGizmo', 'Largo do Freixo, 9
7830-710 Gandra', 9),
('TechGenius Inc.', 'Largo do Forno Velho, 4
1842-224 Aveiro', 9),
('QuantumGizmo', 'Largo Gabriel Silva, 46
1493-240 Barreiro', 9),
('DigitalTech', 'Rua dos Bacalhoeiros, 780
7347-040 Porto', 9),
('SmartFuture Devices', 'R. Carminho Sá, 53
9795-199 Sabugal', 9),
('TechGenius Inc.', 'Largo Rita Loureiro, 61
6233-952 Vila Nova de Foz Côa', 9),
('iDeviceHub', 'Avenida de Barbosa, 4
2331-738 Santiago do Cacém', 10),
('E-World', 'R. Catarina Rocha, 796
8161-610 Alcobaça', 10),
('EcoGadget Works', 'Praça Teresa Castro, 34
3193-286 Paredes', 10),
('ElecTroop', 'Alameda de Mota, 83
1103-831 Sines', 10),
('DigitalDynamo', 'Alameda Andreia Assunção, 60
4421-585 Leiria', 10),
('ElectroByte', 'Rua Barbosa, 98
9051-668 Gandra', 10),
('ElecTronics', 'Rua Ângela Torres, 17
1303-151 Viseu', 10),
('DigitalDynamo', 'Praça Laura Coelho, 62
6803-352 Angra do Heroísmo', 10),
('TechNova', 'Travessa de Vicente, 71
3134-203 Torres Vedras', 10),
('InnoGadgets', 'Avenida de Antunes, 8
3867-795 Santo Tirso', 10);



INSERT INTO `customer_accounts` (`first_name`, `family_name`, `email`, `phone`, `date_of_birth`) VALUES ('Caetana', 'Carvalho', 'wreis@example.org', '(351) 928 204 500', '2001-08-22 01:17:40'),
('Márcio', 'Ferreira', 'mfonseca@example.org', '+351265428801', '2002-07-04 22:38:47'),
('Helena', 'Miranda', 'xpinheiro@example.net', '915 309 548', '2001-04-06 07:06:04'),
('Artur', 'Araújo', 'eferreira@example.org', '(351) 932597895', '1977-12-30 19:27:11'),
('Samuel', 'Azevedo', 'pereirafrancisca@example.org', '(351) 911 885 063', '1961-08-26 05:18:10'),
('Filipa', 'Anjos', 'rafaellopes@example.net', '(351) 915 801 325', '1984-08-07 23:34:35'),
('Raquel', 'Santos', 'vdomingues@example.com', '969 339 808', '1955-04-11 21:42:48'),
('Manuel', 'Cardoso', 'hborges@example.org', '968081567', '1970-07-25 14:14:24'),
('Noa', 'Costa', 'deborateixeira@example.com', '(351) 927 012 463', '1987-10-26 11:46:52'),
('Petra', 'Valente', 'dinis10@example.org', '(351) 912346598', '1991-07-25 02:42:17'),
('Wilson', 'Melo', 'gmacedo@example.org', '921 694 569', '1994-09-29 11:39:41'),
('Carlos', 'Batista', 'emiliaoliveira@example.com', '299946591', '1955-05-26 03:12:49'),
('Sérgio', 'Cardoso', 'luna09@example.com', '914496921', '1967-12-03 02:16:10'),
('Matilde', 'Barros', 'anitaantunes@example.net', '(351) 266 854 062', '1994-05-28 16:03:48'),
('Nádia', 'Moreira', 'maialisandro@example.com', '968751442', '1971-02-24 01:30:39'),
('Nádia', 'Ferreira', 'costadenis@example.com', '(351) 936 021 996', '1993-06-29 11:06:29'),
('Amélia', 'Silva', 'ufernandes@example.com', '(351) 911535717', '1986-09-04 14:36:01'),
('Amélia', 'Lima', 'jreis@example.org', '+351932048533', '1969-05-08 19:27:22'),
('Bruno', 'Brito', 'garciahelena@example.net', '924043356', '1967-02-04 11:00:04'),
('Luís', 'Matias', 'lourencolourenco@example.com', '911332923', '1963-10-06 17:32:46'),
('Francisca', 'Silva', 'eduardo24@example.net', '(351) 926955579', '1990-10-26 15:03:10'),
('Ema', 'Borges', 'sergio52@example.com', '(351) 921 990 039', '1977-11-12 00:36:55'),
('David', 'Esteves', 'pereiraleonardo@example.org', '(351) 923570899', '1973-02-25 22:55:54'),
('Pedro', 'Vaz', 'bpires@example.org', '(351) 934 483 000', '1983-12-26 08:45:16'),
('Eva', 'Neto', 'zcampos@example.com', '(351) 968296140', '1984-09-24 08:27:23'),
('Emanuel', 'Campos', 'evamiranda@example.org', '961 489 756', '1988-06-24 05:21:34'),
('Santiago', 'Henriques', 'xavieramorim@example.org', '(351) 910937549', '1965-11-14 11:54:34'),
('Luca', 'Pinheiro', 'salome87@example.com', '259 342 265', '1989-09-17 02:12:32'),
('João', 'Lourenço', 'angelo79@example.com', '+351934519547', '2001-06-28 01:46:35'),
('Vicente', 'Monteiro', 'fcoelho@example.org', '(351) 929562367', '1995-03-01 09:20:33'),
('Nuno', 'Neto', 'mouradaniel@example.net', '276 645 307', '1976-01-07 07:00:57'),
('Salomé', 'Martins', 'emanascimento@example.org', '252345362', '1991-05-07 10:22:34'),
('Emanuel', 'Branco', 'fsilva@example.org', '(351) 259094857', '1969-03-12 15:39:49'),
('Sofia', 'Moreira', 'pferreira@example.org', '+351910761628', '1984-06-14 18:15:38'),
('Erica', 'Domingues', 'pauloalmeida@example.com', '+351911850792', '1961-11-14 04:26:55'),
('Daniela', 'Cardoso', 'teresaazevedo@example.org', '(351) 923403401', '2001-10-10 14:42:48'),
('Márcio', 'Faria', 'dlima@example.com', '251 246 639', '1990-05-24 11:12:12'),
('Alexandre', 'Mota', 'dfernandes@example.com', '+351935877804', '1965-11-16 09:44:05'),
('Rafael', 'Anjos', 'gasparabreu@example.org', '(351) 935965457', '1958-07-30 21:34:53'),
('Daniel', 'Teixeira', 'melissaneves@example.com', '966 267 131', '1964-06-01 02:06:20'),
('Nair', 'Rodrigues', 'lucianareis@example.com', '(351) 259530293', '1974-07-19 02:18:03'),
('Marta', 'Jesus', 'victoriasilva@example.com', '(351) 919 210 491', '1986-04-15 11:21:09'),
('Clara', 'Nunes', 'emanuel07@example.net', '937 153 738', '1981-12-27 16:01:56'),
('Bianca', 'Faria', 'vicentevictoria@example.com', '256466549', '1967-08-20 09:38:02'),
('Iara', 'Sá', 'garciaflor@example.org', '(351) 921486284', '1958-11-20 14:15:46'),
('Alexandre', 'Andrade', 'magalhaesandreia@example.com', '(351) 922004456', '1993-09-25 12:29:07'),
('Santiago', 'Batista', 'camilagarcia@example.com', '(351) 921 945 165', '1963-03-20 05:57:59'),
('Iara', 'Loureiro', 'upires@example.org', '913 784 804', '1956-02-08 20:52:02'),
('Rafaela', 'Neto', 'rodrigoantunes@example.net', '(351) 225461454', '1960-11-21 21:22:04'),
('Kelly', 'Mendes', 'barbaramendes@example.org', '923752519', '1975-04-07 14:24:44'),
('Álvaro', 'Mendes', 'adrianamagalhaes@example.com', '(351) 938801710', '1972-03-04 19:06:38'),
('Margarida', 'Mota', 'asantos@example.org', '(351) 961952414', '1988-12-19 13:38:46'),
('Artur', 'Valente', 'sandromacedo@example.net', '(351) 924641932', '1987-04-09 15:14:49'),
('Rafaela', 'Paiva', 'renato26@example.org', '925108400', '1997-06-30 10:33:54'),
('Renata', 'Pinto', 'upaiva@example.net', '928 864 154', '2000-05-16 20:58:31'),
('Frederico', 'Reis', 'borgesivo@example.org', '(351) 938 353 941', '1992-11-01 01:39:03'),
('Filipa', 'Nunes', 'fmendes@example.com', '967961336', '1992-02-12 16:19:36'),
('Frederico', 'Sá', 'tiagosoares@example.net', '(351) 230429785', '1975-03-25 10:51:04'),
('Gabriela', 'Gomes', 'macedomelissa@example.net', '(351) 910 322 144', '1963-02-09 00:47:41'),
('Luís', 'Loureiro', 'danielanunes@example.net', '262901183', '1982-11-02 16:30:28'),
('Naiara', 'Rocha', 'kevim34@example.net', '+351918606689', '1983-12-25 22:55:09'),
('Iara', 'Campos', 'zbaptista@example.net', '(351) 261 677 712', '1969-02-24 17:34:51'),
('Miriam', 'Araújo', 'llopes@example.net', '(351) 912 213 709', '1993-08-29 07:08:22'),
('Lúcia', 'Carneiro', 'violetacastro@example.org', '928831895', '1969-04-19 08:54:48'),
('Luca', 'Nunes', 'gasparmagalhaes@example.net', '(351) 968156837', '2004-06-24 07:11:48'),
('Benedita', 'Batista', 'cunhateresa@example.com', '921557653', '2004-12-03 08:12:15'),
('Petra', 'Guerreiro', 'torresleonardo@example.org', '+351964470663', '1967-08-22 19:42:26'),
('Mário', 'Rodrigues', 'tatianabarbosa@example.net', '910989140', '1994-02-27 16:27:30'),
('Álvaro', 'Rocha', 'ramosluciana@example.com', '(351) 935851211', '1979-04-12 07:32:12'),
('Diana', 'Alves', 'larissa82@example.net', '(351) 938481485', '1966-05-28 03:12:24'),
('Alexandra', 'Coelho', 'iris12@example.org', '(351) 918 990 154', '2001-07-09 11:52:24'),
('Ivo', 'Sá', 'emmaazevedo@example.org', '(351) 283 248 284', '1973-10-15 13:00:14'),
('Bruna', 'Mendes', 'bvaz@example.com', '(351) 934749230', '1988-08-18 04:51:03'),
('Débora', 'Torres', 'lorenamachado@example.com', '(351) 935 647 669', '1995-06-16 12:18:04'),
('Luna', 'Campos', 'pedro65@example.net', '(351) 258923508', '1981-02-18 07:09:35'),
('Vitória', 'Castro', 'pereiraana@example.net', '219548100', '1954-03-24 22:12:58'),
('Flor', 'Marques', 'margarida53@example.org', '963 709 038', '1999-03-24 19:58:44'),
('Lisandro', 'Jesus', 'carlos06@example.org', '(351) 934 235 879', '1968-04-18 00:59:26'),
('Isabela', 'Nunes', 'alice10@example.com', '(351) 233 979 084', '1957-02-23 23:28:52'),
('Manuel', 'Costa', 'gferreira@example.org', '225 624 756', '1961-01-21 09:57:13'),
('Lorena', 'Pinheiro', 'correiagabriel@example.com', '(351) 921803708', '1998-11-08 10:18:15'),
('Jaime', 'Tavares', 'xdomingues@example.com', '914 297 830', '1967-03-05 02:34:59'),
('Filipa', 'Loureiro', 'inespinho@example.org', '(351) 910 617 450', '1963-09-22 13:01:09'),
('Joana', 'Gomes', 'andradekyara@example.com', '(351) 248962201', '1984-10-18 14:18:35'),
('Kyara', 'Monteiro', 'hreis@example.com', '(351) 964321922', '1961-08-27 07:55:54'),
('Melissa', 'Henriques', 'sawilson@example.org', '933 889 007', '1990-01-06 23:08:31'),
('Álvaro', 'Vaz', 'tavaresisabel@example.com', '+351297013435', '1970-10-25 22:13:28'),
('Manuel', 'Lourenço', 'varaujo@example.com', '(351) 927 109 074', '1965-01-16 15:18:59'),
('Valentim', 'Amorim', 'abreuismael@example.net', '932 768 954', '1973-07-13 08:36:58'),
('Carminho', 'Marques', 'carvalhokyara@example.org', '299 260 926', '1995-08-05 21:33:04'),
('Marco', 'Matias', 'matiasnuria@example.org', '(351) 961178867', '2002-06-28 02:59:19'),
('Larissa', 'Nogueira', 'denis53@example.com', '+351931519824', '1964-07-06 02:50:02'),
('Filipe', 'Loureiro', 'artur56@example.net', '(351) 961 374 264', '1973-12-23 23:19:10'),
('Filipe', 'Figueiredo', 'irodrigues@example.org', '933001486', '2005-01-14 19:33:39'),
('Nair', 'Sousa', 'assuncaoluca@example.org', '967509502', '2004-09-07 23:48:22'),
('Jaime', 'Simões', 'fmartins@example.net', '+351919768191', '1954-04-08 22:09:51'),
('Simão', 'Santos', 'pinheiromiriam@example.net', '939423981', '1958-07-24 01:04:26'),
('Xavier', 'Paiva', 'marta63@example.org', '+351919981521', '1996-01-15 17:56:56'),
('Irina', 'Anjos', 'micael53@example.com', '(351) 917 633 862', '1968-03-26 23:24:01'),
('Bárbara', 'Amaral', 'ybrito@example.net', '969 135 749', '1987-10-19 21:32:21');



INSERT INTO `locations` (`location_id`, `city`, `post_code`, `address`, `relation_type`, `relation_id`) VALUES 
(1, 'Albufeira', '3409-460', 'Largo Filipe Santos, 6', 'CustomerAccount', 1),
(2, 'Covilhã', '7910-839', 'R. Pinto, 378', 'CustomerAccount', 2),
(3, 'Lagoa', '4040-414', 'Av Pacheco, 479', 'CustomerAccount', 3),
(4, 'Valbom', '2323-586', 'Av Andrade, 606', 'CustomerAccount', 4),
(5, 'Sacavém', '8783-354', 'Praça do Evaristo, 64', 'CustomerAccount', 5),
(6, 'Caldas da Rainha', '5615-472', 'Rua do Bonjardim, S/N', 'CustomerAccount', 6),
(7, 'Vendas Novas', '5830-208', 'Praça de Melo, S/N', 'CustomerAccount', 7),
(8, 'Évora', '5496-346', 'Largo Irina Domingues, 90', 'CustomerAccount', 8),
(9, 'Esposende', '3368-581', 'Largo Ribeiro, 98', 'CustomerAccount', 9),
(10, 'Estremoz', '5148-557', 'Avenida Jorge Leal, 47', 'CustomerAccount', 10),
(11, 'Trancoso', '8059-719', 'Avenida Catarina Marques, 131', 'CustomerAccount', 11),
(12, 'Viseu', '4028-004', 'Rua Monteiro, 6', 'CustomerAccount', 12),
(13, 'Seixal', '9057-332', 'R. de Mota, 64', 'CustomerAccount', 13),
(14, 'Esposende', '7010-833', 'Praça do Cantábrico, 861', 'CustomerAccount', 14),
(15, 'Vizela', '3158-136', 'Praça Fernandes, 30', 'CustomerAccount', 15),
(16, 'Sacavém', '2471-801', 'Av Leal, 326', 'CustomerAccount', 16),
(17, 'Mirandela', '9111-874', 'Avenida Leonardo Oliveira, 31', 'CustomerAccount', 17),
(18, 'Elvas', '3825-378', 'Rua Filipe Henriques, 11', 'CustomerAccount', 18),
(19, 'Vila Nova de Santo André', '9672-933', 'Rua de Matias, 5', 'CustomerAccount', 19),
(20, 'Freamunde', '4061-733', 'Praça Victória Neves, 672', 'CustomerAccount', 20),
(21, 'Reguengos de Monsaraz', '8532-156', 'Av do Adamastor, 23', 'CustomerAccount', 21),
(22, 'São João da Madeira', '6881-624', 'Av do Calhau, 10', 'CustomerAccount', 22),
(23, 'Estarreja', '2435-379', 'R. Loureiro, S/N', 'CustomerAccount', 23),
(24, 'Ponte de Sor', '6448-266', 'Rua do Ródano, 58', 'CustomerAccount', 24),
(25, 'Viseu', '6105-064', 'Alameda Nunes, 52', 'CustomerAccount', 25),
(26, 'Trofa', '6395-589', 'Praça Alícia Moreira, 25', 'CustomerAccount', 26),
(27, 'Vale de Cambra', '9985-586', 'Praça Brito, 33', 'CustomerAccount', 27),
(28, 'Vila Franca de Xira', '5377-145', 'Av Ivo Machado, 555', 'CustomerAccount', 28),
(29, 'Chaves', '7517-058', 'Alameda Santos, 59', 'CustomerAccount', 29),
(30, 'Maia', '5151-556', 'Rua Simões, 1', 'CustomerAccount', 30),
(31, 'Covilhã', '6714-178', 'Av dos Melros, 71', 'CustomerAccount', 31),
(32, 'Porto Santo', '0186-489', 'Travessa de Sá, S/N', 'CustomerAccount', 32),
(33, 'Mealhada', '4006-742', 'Travessa de Pereira, 59', 'CustomerAccount', 33),
(34, 'Bragança', '8438-894', 'Alameda do Sequeiro, 55', 'CustomerAccount', 34),
(35, 'Vila Nova de Santo André', '3918-524', 'Avenida Maestro Ivo Cruz, 10', 'CustomerAccount', 35),
(36, 'Mealhada', '3223-098', 'Largo de Freitas, 73', 'CustomerAccount', 36),
(37, 'Serpa', '3348-647', 'Largo Paulo Gaspar, 9', 'CustomerAccount', 37),
(38, 'Viana do Castelo', '8120-030', 'Rua de Martins, 61', 'CustomerAccount', 38),
(39, 'Vale de Cambra', '6472-035', 'Avenida Professor José Conde, 4', 'CustomerAccount', 39),
(40, 'Amora', '9155-359', 'Praça de Valente, 60', 'CustomerAccount', 40),
(41, 'Loures', '6027-824', 'Avenida Torres, 20', 'CustomerAccount', 41),
(42, 'Valpaços', '5379-561', 'Alameda do Carvalhão, 78', 'CustomerAccount', 42),
(43, 'Almada', '5332-890', 'Av Igor Mota, 7', 'CustomerAccount', 43),
(44, 'Braga', '6704-781', 'Avenida Cardoso, S/N', 'CustomerAccount', 44),
(45, 'Póvoa de Varzim', '6412-769', 'Praça Rita Costa, 59', 'CustomerAccount', 45),
(46, 'Pinhel', '0117-205', 'Avenida Gomes, 1', 'CustomerAccount', 46),
(47, 'Trancoso', '3095-826', 'Alameda Abreu, 56', 'CustomerAccount', 47),
(48, 'Macedo de Cavaleiros', '8437-341', 'Praça do Sobreirinho, 512', 'CustomerAccount', 48),
(49, 'Caniço', '2151-849', 'Av de Ramos, 60', 'CustomerAccount', 49),
(50, 'Abrantes', '4352-270', 'Alameda Guerreiro, 80', 'CustomerAccount', 50),
(51, 'Figueira da Foz', '4471-373', 'Alameda da Conceição, 9', 'CustomerAccount', 51),
(52, 'Alcácer do Sal', '3866-726', 'Travessa Fernando Pessa, S/N', 'CustomerAccount', 52),
(53, 'Almeirim', '0350-706', 'Alameda Garcia, 74', 'CustomerAccount', 53),
(54, 'Ponta Delgada', '0481-254', 'Largo Daniel Leite, S/N', 'CustomerAccount', 54),
(55, 'Vila Nova de Foz Côa', '7647-214', 'Travessa Castro, S/N', 'CustomerAccount', 55),
(56, 'Portimão', '3559-130', 'Praça Paris (Nascente), 3', 'CustomerAccount', 56),
(57, 'Sintra', '1292-161', 'Largo de Teixeira, 76', 'CustomerAccount', 57),
(58, 'Freamunde', '2747-805', 'Av Rodrigues, 5', 'CustomerAccount', 58),
(59, 'Seia', '1410-660', 'R. Ribeiro, 83', 'CustomerAccount', 59),
(60, 'Santiago do Cacém', '0167-327', 'Travessa José Fernandes, 30', 'CustomerAccount', 60),
(61, 'Vila Real de Santo António', '7105-909', 'Av de Carneiro, 28', 'CustomerAccount', 61),
(62, 'Montemor-o-Novo', '3125-718', 'Avenida Lopes, 51', 'CustomerAccount', 62),
(63, 'Agualva-Cacém', '0894-653', 'Travessa Loureiro, 17', 'CustomerAccount', 63),
(64, 'Setúbal', '3317-882', 'R. Amélia Anjos, 19', 'CustomerAccount', 64),
(65, 'Caldas da Rainha', '6616-124', 'Rua de Passos Manuel, 53', 'CustomerAccount', 65),
(66, 'Estarreja', '8639-455', 'Travessa da Boa Viagem, 648', 'CustomerAccount', 66),
(67, 'Lagoa', '2106-013', 'Praça Ramos, 933', 'CustomerAccount', 67),
(68, 'Porto Santo', '8334-721', 'R. de Branco, S/N', 'CustomerAccount', 68),
(69, 'Ermesinde', '1169-137', 'Largo de S. Lázaro, 78', 'CustomerAccount', 69),
(70, 'Barreiro', '1742-825', 'R. de Viterbo de Campos, 489', 'CustomerAccount', 70),
(71, 'Pombal', '7157-631', 'Av Letícia Pinto, 57', 'CustomerAccount', 71),
(72, 'Costa da Caparica', '7705-616', 'R. Lucas Antunes, 45', 'CustomerAccount', 72),
(73, 'Peniche', '6695-412', 'Avenida Tomás Matias, 5', 'CustomerAccount', 73),
(74, 'Tarouca', '2207-387', 'Alameda Mário Andrade, 435', 'CustomerAccount', 74),
(75, 'Póvoa de Santa Iria', '1703-703', 'Rua Patrícia Ribeiro, 96', 'CustomerAccount', 75),
(76, 'Tarouca', '4350-974', 'Alameda das Tágides, 8', 'CustomerAccount', 76),
(77, 'Tarouca', '6918-248', 'R. do Forno Velho, 51', 'CustomerAccount', 77),
(78, 'Torres Vedras', '0404-574', 'Av Maestro Ivo Cruz, 52', 'CustomerAccount', 78),
(79, 'Ponta Delgada', '4932-697', 'Largo Fonseca, S/N', 'CustomerAccount', 79),
(80, 'Oliveira do Bairro', '9183-625', 'Alameda do Recanto, S/N', 'CustomerAccount', 80),
(81, 'Abrantes', '5256-356', 'Travessa da Música, 94', 'CustomerAccount', 81),
(82, 'Silves', '7712-893', 'Rua Daniela Sousa, 382', 'CustomerAccount', 82),
(83, 'Aveiro', '8212-183', 'Rua Fernanda de Castro, 52', 'CustomerAccount', 83),
(84, 'Santa Maria da Feira', '9300-506', 'Travessa Mota, S/N', 'CustomerAccount', 84),
(85, 'Gondomar', '4540-757', 'Alameda de Moura, 70', 'CustomerAccount', 85),
(86, 'Silves', '4815-145', 'Alameda Campos, 82', 'CustomerAccount', 86),
(87, 'Rio Maior', '8039-846', 'Av de Francisco Borges, 5', 'CustomerAccount', 87),
(88, 'Peso da Régua', '4481-697', 'Alameda Brito, 38', 'CustomerAccount', 88),
(89, 'Santana', '9992-963', 'Alameda Francisca Cardoso, 61', 'CustomerAccount', 89),
(90, 'Vila Nova de Santo André', '5465-361', 'Travessa de Magalhães, 38', 'CustomerAccount', 90),
(91, 'Anadia', '1673-558', 'Rua Fernanda de Castro, 96', 'CustomerAccount', 91),
(92, 'Beja', '8804-706', 'Avenida Anjos, 261', 'CustomerAccount', 92),
(93, 'Lourosa', '2509-101', 'Travessa de Sá, 13', 'CustomerAccount', 93),
(94, 'Freamunde', '5397-263', 'Travessa de Mota, 384', 'CustomerAccount', 94),
(95, 'Sintra', '7260-685', 'Avenida Carolina Figueiredo, S/N', 'CustomerAccount', 95),
(96, 'Viana do Castelo', '8592-003', 'Travessa Costa, S/N', 'CustomerAccount', 96),
(97, 'Gouveia', '8688-240', 'R. de Pinheiro, 85', 'CustomerAccount', 97),
(98, 'Ílhavo', '7413-203', 'Rua Edgar Torres, 38', 'CustomerAccount', 98),
(99, 'Agualva-Cacém', '2539-541', 'Avenida Santiago Cruz, 51', 'CustomerAccount', 99),
(100, 'Póvoa de Santa Iria', '9210-083', 'Travessa Sá, 1', 'CustomerAccount', 100),
(101, 'Vila Real de Santo António', '7202-317', 'Avenida Caetana Amaral, 12', 'Branch', 1),
(102, 'Abrantes', '5137-712', 'Largo Yasmin Paiva, 203', 'Branch', 2),
(103, 'Tavira', '7091-781', 'Avenida Manuel Cunha, 80', 'Branch', 3),
(104, 'Chaves', '1814-304', 'R. do Pimenta, 878', 'Branch', 4),
(105, 'Marinha Grande', '5860-411', 'Largo da Sé, 3', 'Branch', 5),
(106, 'Felgueiras', '0720-554', 'Praça Mariana Brito, 676', 'Branch', 6),
(107, 'Beja', '1977-659', 'R. Francisca Monteiro, 66', 'Branch', 7),
(108, 'Setúbal', '6931-383', 'Largo Valentina Valente, 51', 'Branch', 8),
(109, 'Penafiel', '8315-355', 'Travessa de Magalhães, 88', 'Branch', 9),
(110, 'Santa Comba Dão', '3105-357', 'Largo Moreira, 48', 'Branch', 10);




INSERT INTO `products` (`name`, `description`, `price`, `quantity_available`, `vendor_id`, `category_id`) VALUES ('Davidson LLC one', 'Plant responsibility everyone blood able.', 762.18, 48, 25, 7),
('TechMaster Pro 2000', 'Experience cutting-edge technology with the TechMaster Pro 2000. Elevate your digital lifestyle.', 762.18, 48, 25, 7),
('SmartGadget X3', 'Unlock the future with the SmartGadget X3. A revolutionary device that redefines smart living.', 670.64, 35, 30, 16),
('InnoTech PowerHub', 'Discover the InnoTech PowerHub, your all-in-one solution for powering up your electronic devices.', 812.82, 90, 35, 16),
('Digital Living Assistant', 'Enhance your daily routine with the Digital Living Assistant. A smart companion for a connected lifestyle.', 503.0, 14, 16, 6),
('QuantumLight LED Strips', 'Illuminate your space with QuantumLight LED Strips. Create a vibrant and dynamic atmosphere at the touch of a button.', 464.16, 57, 79, 18),
('TechFlow Wireless Charger', 'Cut the cords with TechFlow Wireless Charger. Experience seamless charging for your devices without the hassle of cables.', 197.52, 51, 76, 5),
('SmartKitchen Appliance Set', 'Transform your kitchen into a smart cooking space with the SmartKitchen Appliance Set. Embrace the future of culinary innovation.', 294.95, 37, 70, 13),
('StellarVR Virtual Reality Kit', 'Immerse yourself in a new reality with StellarVR Virtual Reality Kit. Explore virtual worlds and unleash your imagination.', 991.13, 45, 48, 2),
('EcoTech Solar Panels', 'Harness the power of the sun with EcoTech Solar Panels. Take a step towards sustainable energy and a greener future.', 152.29, 22, 80, 14),
('FutureTech AI Assistant', 'Meet your personal assistant from the future, FutureTech AI Assistant. Simplify tasks and get things done with advanced AI capabilities.', 792.82, 17, 86, 19),
('SmartHome Security System', 'Protect your home with the SmartHome Security System. Stay connected and keep your loved ones safe with smart security features.', 28.58, 49, 11, 20),
('QuantumSound Wireless Speakers', 'Experience the next level of audio with QuantumSound Wireless Speakers. Enjoy crystal-clear sound and wireless convenience.', 783.57, 16, 77, 3),
('RoboClean Smart Vacuum', 'Leave the cleaning to technology with the RoboClean Smart Vacuum. Effortlessly maintain a spotless home with robotic efficiency.', 533.78, 81, 45, 8),
('SmartFit Fitness Tracker', 'Achieve your fitness goals with the SmartFit Fitness Tracker. Monitor your activity, sleep, and health with smart precision.', 415.41, 49, 42, 4),
('TechArt Smart Canvas', 'Transform your living space with the TechArt Smart Canvas. A customizable digital canvas that brings art and technology together.', 631.47, 85, 75, 2),
('HoverDrive Electric Scooter', 'Glide through the city with the HoverDrive Electric Scooter. Experience eco-friendly transportation with futuristic style.', 330.52, 51, 80, 2),
('PixelPerfect 4K Monitor', 'Immerse yourself in stunning visuals with the PixelPerfect 4K Monitor. Elevate your viewing experience with high-resolution clarity.', 546.12, 34, 64, 4),
('QuantumSpeed Gaming Laptop', 'Unleash the power of gaming with QuantumSpeed Gaming Laptop. Dominate virtual worlds with cutting-edge technology and performance.', 949.32, 94, 9, 14),
('ConnectX Smart Home Hub', 'Create a connected home with ConnectX Smart Home Hub. Control your devices seamlessly and enhance your home automation experience.', 687.49, 71, 37, 17),
('BioTech Health Monitor', 'Prioritize your health with the BioTech Health Monitor. Monitor vital signs and stay proactive about your well-being.', 119.08, 10, 64, 6),
('FutureVision AR Glasses', 'See the future with FutureVision AR Glasses. Augmented reality experiences right before your eyes for a truly immersive world.', 960.62, 14, 13, 6),
('SmartGear Fitness Smartwatch', 'Elevate your fitness journey with SmartGear Fitness Smartwatch. Track workouts, monitor health, and stay stylish on the go.', 10.62, 29, 43, 3),
('QuantumDrive External SSD', 'Experience lightning-fast storage with QuantumDrive External SSD. Transfer data at quantum speed and enhance your workflow.', 971.93, 20, 82, 8),
('VisionX Smart Surveillance', 'Secure your surroundings with VisionX Smart Surveillance. Keep an eye on your property with intelligent video monitoring.', 146.55, 53, 32, 6),
('CyberLink Smart Office Kit', 'Transform your workspace with CyberLink Smart Office Kit. Boost productivity and efficiency with smart office solutions.', 614.29, 96, 4, 4),
('EcoCharge Sustainable Batteries', 'Power your devices sustainably with EcoCharge Sustainable Batteries. Reduce environmental impact without compromising performance.', 880.96, 68, 49, 6),
('FutureConnect 5G Router', 'Experience the future of connectivity with FutureConnect 5G Router. Enjoy ultra-fast internet speeds and seamless networking.', 843.35, 48, 11, 2),
('TechTrouble Resolver', 'Tackle technical challenges with the TechTrouble Resolver. Your go-to solution for smooth technology operations.', 288.95, 68, 73, 9),
('CityOrder Smart Delivery', 'Efficiently manage citywide orders with CityOrder Smart Delivery. A smart system designed to streamline delivery operations.', 501.51, 5, 8, 8),
('LanguageCut Precision Tool', 'Achieve precision in language processing with LanguageCut. An advanced tool for linguistic analysis and enhancement.', 809.14, 99, 57, 11),
('TechTeach Gun-Free Learning', 'Revolutionize education with TechTeach. A gun-free learning environment with short, impactful teaching methods.', 665.92, 5, 70, 14),
('SpaceArtist Cultural Canvas', 'Express your creativity with SpaceArtist Cultural Canvas. A platform that blends art, culture, and technology for a unique experience.', 139.27, 88, 42, 8),
('PicturePerfect Thousand-Eye Camera', 'Capture every detail with PicturePerfect Thousand-Eye Camera. An advanced imaging solution for professional photographers.', 370.75, 16, 41, 20),
('FutureCorp Heavy Air Drone', 'Dominate the skies with FutureCorp Heavy Air Drone. A single heavy air owner for aerial exploration and surveillance.', 911.81, 17, 55, 18),
('DiscussionStyle Market Revealer', 'Navigate business discussions with DiscussionStyle Market Revealer. Unlock insights into market trends and reveal hidden opportunities.', 499.26, 78, 18, 11),
('LetterScene Seasonal Journal', 'Document every scene with LetterScene Seasonal Journal. A unique journal capturing the essence of each season through words and images.', 835.19, 59, 24, 3),
('MessageRecognizer Conference Assistant', 'Efficiently manage conferences with MessageRecognizer Conference Assistant. Recognize and respond to messages, ensuring a seamless event.', 565.02, 44, 42, 20),
('ResponseHospital Emergency Kit', 'Be prepared for emergencies with ResponseHospital Emergency Kit. From poor situations to hospitals, respond effectively and swiftly.', 217.0, 90, 46, 20),
('RockPartner Federal Stage', 'RockPartner Federal Stage - your partner on each stage of federal activities. A solution for efficient and cooperative government operations.', 490.88, 50, 52, 11),
('DiscoveryManager Hot Surface Monitor', 'Uncover hidden issues with DiscoveryManager Hot Surface Monitor. Effectively manage and monitor hot surfaces for a safe environment.', 111.67, 99, 56, 15),
('KnowProduct Land Transformer', 'KnowProduct Land Transformer - transforming product land within. Embrace change and innovation in the electronic product landscape.', 162.63, 87, 8, 5),
('StartSpace Cell Explorer', 'Embark on a journey with StartSpace Cell Explorer. Allow your tech ambitions to step into unexplored space and innovation.', 673.54, 72, 98, 5),
('TechComfort Relaxation Hub', 'Indulge in the TechComfort Relaxation Hub. Charge up your senses and relax with the latest in electronic comfort technology.', 47.42, 34, 40, 15),
('InnoSync Connectivity Suite', 'Experience seamless connectivity with the InnoSync Connectivity Suite. Break free from common connectivity issues and stay linked effortlessly.', 709.3, 75, 30, 3),
('EcoWear Sustainable Wearables', 'Embrace sustainable tech with EcoWear Sustainable Wearables. Common break from traditional wearables and tread lightly on the planet.', 578.03, 52, 78, 15),
('FutureFlavor Culinary Tech', 'Explore the FutureFlavor Culinary Tech. Eat how technology transforms the culinary experience, reflecting on taste and innovation.', 283.66, 6, 69, 9),
('EcoTechRun Eco-Friendly Sneakers', 'Step into the future with EcoTechRun Eco-Friendly Sneakers. Run with purpose and reflect on an environmentally conscious journey.', 420.66, 4, 49, 6),
('QuantumEntertain Immersive Entertainment', 'Immerse yourself in QuantumEntertain Immersive Entertainment. Forget traditional TV with a new era of captivating and decision-making content.', 109.92, 89, 50, 17),
('PixelJoy E-Reader Bliss', 'Discover reading with PixelJoy E-Reader Bliss. Make the decision to embrace a moment of image solitude and happiness with every book.', 23.13, 42, 4, 19),
('StyleTech Wearable Fashion', 'Define your style with StyleTech Wearable Fashion. Now, make important fashion statements that reflect your unique taste and treatment.', 724.69, 37, 90, 15),
('SyncMeet Digital Meeting Hub', 'Conduct meetings seamlessly with SyncMeet Digital Meeting Hub. Interest attendees with born virtual records and efficient meeting spaces.', 327.18, 20, 61, 15),
('BlueGlow Nighttime Tech Companion', 'Enhance your nights with BlueGlow Nighttime Tech Companion. Sign up for a night of person comfort and hold onto the soothing blue light.', 321.43, 43, 60, 19),
('TechFocus Health Monitor', 'Stay focused on health with the TechFocus Health Monitor. Impact your overall well-being, particularly for those in officer roles and hotel industries.', 959.87, 70, 27, 8),
('Rocha SmartBelieve Smartphone', 'Believe in the power of technology with the Rocha SmartBelieve Smartphone. Experience high-quality performance and a responsive sing experience.', 152.91, 86, 93, 1),
('Silva-Bryan SmartSimilar Phone', 'Make your smartphone experience significant with the Silva-Bryan SmartSimilar Phone. Indeed a heavy-duty device for all your communication needs.', 735.6, 100, 14, 11),
('TechResponse Political Laptop', 'Take charge with the TechResponse Political Laptop. Buy into a political and national response with a large and efficient computing experience.', 219.08, 86, 47, 15),
('Wolf-Dickerson RedList Tablet', 'Stay organized with the Wolf-Dickerson RedList Tablet. Establish and manage your to-do list outside, whether at home or on the go.', 720.69, 39, 96, 9),
('Patterson-Taylor CultureTree Laptop', 'Immerse yourself in the Patterson-Taylor CultureTree Laptop. Experience a new tree of possibilities with a glass-clear and nearly effortless computing experience.', 980.71, 10, 50, 11),
('Reynolds-Miller SmartOrder Smartphone', 'Effortlessly produce orders with the Reynolds-Miller SmartOrder Smartphone. Bring your investment ideas to life with an able and responsive mobile device.', 903.97, 70, 84, 4),
('Marks TechTrouble Tablet', 'Navigate tech challenges with the Marks TechTrouble Tablet', 931.85, 75, 45, 20),
('Hines and Sons SmartForm Computer', 'Formulate ideas with the Hines and Sons SmartForm Computer. Experience the loss of wish for traditional computing with a half-us computing solution.', 402.53, 42, 69, 11),
('Barrett HeadTech Headset', 'Immerse yourself in the Barrett HeadTech Headset. Today reality demands a headset that figures into your network, providing an audio experience like never before.', 711.37, 37, 18, 11),
('Chandler SmartForget Laptop', 'Forget the ordinary with the Chandler SmartForget Laptop. Down the path of college and finish tasks with a must-have computing companion.', 625.36, 37, 38, 18),
('Cooper BloodTech Monitor', 'Monitor your health with the Cooper BloodTech Monitor. Notice changes in your blood pressure, taking care of your government land.', 220.85, 29, 12, 14),
('Garcia WaterTech Report', 'Report water usage with the Garcia WaterTech Report. Stay informed about water consumption, promoting a sustainable environment.', 770.95, 95, 15, 5),
('Young TechMethod Desktop', 'Develop your methods with the Young TechMethod Desktop. Behind every Republican wonder is a service plant ready to bloom.', 263.0, 70, 70, 5),
('Mays and Sons SmartOne Smartphone', 'Own the future with Mays and Sons SmartOne Smartphone. Analyze events, coach your team, and meet all your communication needs in one device.', 95.27, 69, 4, 2),
('Flores-Anderson SportsTech Laptop', 'Stay active with the Flores-Anderson SportsTech Laptop. Order social experiences, whether gaming or social media, on a laptop built for the active lifestyle.', 461.46, 84, 87, 18),
('Lee SmartInvolve Computer', 'Involve yourself in smart computing with the Lee SmartInvolve Computer. Add a Republican touch to cold and traditional computing projects.', 541.03, 58, 26, 4),
('Henderson-Hancock LeadSound Speaker', 'Lead the sound with Henderson-Hancock LeadSound Speaker. Tax everybody attention with clear and vibrant audio for any occasion.', 574.4, 79, 35, 5),
('Kelly TechProcess Desktop', 'Process your tasks efficiently with the Kelly TechProcess Desktop. Call across training or meetings with a reliable and powerful computing solution.', 646.48, 54, 18, 17),
('Phillips, Walker and Taylor SmartAccept Smartphone', 'Accept the future with Phillips, Walker and Taylor SmartAccept Smartphone. Ever prepare for a defense that treats you to a never-before-seen smartphone experience.', 974.36, 76, 73, 9),
('Ross TechFeel Laptop', 'Feel the technology with Ross TechFeel Laptop. Teach yourself to forget the ordinary and embrace a sister-like relationship with your laptop.', 680.68, 20, 18, 8),
('Young Forward Coffee Maker', 'Prepare your morning brew until the five-letter boy is ready with the Young Forward Coffee Maker. Majority of coffee lovers will appreciate the simplicity and efficiency of this kitchen essential.', 571.01, 38, 26, 9),
('Hernandez, Rosales and Hicks SmartArticle Blender', 'Enhance your kitchen security with the Hernandez, Rosales and Hicks SmartArticle Blender. Probably our go-to solution for smoothies, shakes, and more.', 821.24, 62, 40, 10),
('Novak, Proctor and Oneal MaybeToaster', 'Forget about burnt toast with the Novak, Proctor and Oneal MaybeToaster. Wife, writer, sound—everything is in sync for a perfect breakfast.', 467.1, 60, 56, 8),
('Howard, Garrett and Watson BuildMixer', 'Build up your culinary skills with the Howard, Garrett and Watson BuildMixer. Nearly remain a consumer of pre-packaged goods as you nearly master the art of mixing.', 227.8, 38, 23, 7),
('Fernandez Group SmartDegree Oven', 'Degree by degree, rise to the occasion with the Fernandez Group SmartDegree Oven. Stop wondering if your roast is done—this oven will find the right temperature for you.', 404.22, 91, 88, 3),
('Wood Inc ReligiousJuicer', 'Juice like you are in a cathedral with the Wood Inc ReligiousJuicer. Everyone will wonder how you got that vibrant, water-like juice from your favorite fruits.', 457.87, 57, 77, 11),
('Robinson Group PoliticsAir Fryer', 'Get political about your snacks with the Robinson Group PoliticsAir Fryer. Kid-approved, it records every concern about those crispy fries and modern snacks.', 367.19, 68, 93, 15),
('Houston, Garcia and Craig MorningGriddle', 'Wake up to a delicious morning with the Houston, Garcia and Craig MorningGriddle. An example of west-coast cooking that plays well with your morning routine.', 482.98, 27, 56, 5),
('Peterson and Sons MessageSlow Cooker', 'Send a message to your taste buds with the Peterson and Sons MessageSlow Cooker. Explain to them the theory of slow-cooked perfection through every meal.', 623.01, 70, 66, 3),
('Duarte Inc AnythingToaster Oven', 'Toast anything you desire with the Duarte Inc AnythingToaster Oven. This deep garden of possibilities identifies with your desire for a quick, beat-ready snack.', 41.09, 81, 65, 10),
('Wilson-Jones SpecialCoffee Grinder', 'Grind your coffee beans with the Wilson-Jones SpecialCoffee Grinder. A chair by the window is the perfect spot to savor the mean flavors of freshly ground coffee.', 890.42, 5, 55, 20),
('Rice, Hines and Wilson AudienceKettle', 'Address your thirst with the Rice, Hines and Wilson AudienceKettle. Tonight, cover your cup and let the agreement of hot water and knowledge unfold.', 73.86, 30, 50, 8),
('Jimenez Ltd CheckMicrowave', 'Check off your list with the Jimenez Ltd CheckMicrowave. Tonight, cover your leftovers and let the agreement of quick, convenient heating take center stage.', 481.3, 68, 70, 13),
('Fox Inc CitizenFood Processor', 'Be a citizen of culinary delight with the Fox Inc CitizenFood Processor. Laugh, share, and mean serious business in the kitchen as a professional member of the culinary arts.', 811.44, 14, 37, 12),
('Jones LLC SeasonDigital Scale', 'Season your dishes to perfection with the Jones LLC SeasonDigital Scale. Threaten blandness with a front-row seat to the energy of precise measurements.', 60.22, 33, 33, 17),
('Jones, Mason and Taylor Gaming Approach', 'Approach your gaming with style using the Jones, Mason and Taylor Gaming Approach. Later, room life will find new dimensions as you delve into computer evenings and exciting gaming subjects.', 305.92, 16, 54, 15),
('Garcia-Lopez Future Console', 'Embark on a journey to the future with the Garcia-Lopez Future Console. Recently, evidence suggests that your gaming experience will keep you on the edge, like a valuable bank stock.', 166.13, 51, 97, 1),
('Martinez, Lamb and Rodriguez Mrs Entertainment System', 'Transform your living room with the Martinez, Lamb and Rodriguez Mrs Entertainment System. Reflect on the couples resourceful design that brings long-lasting joy, like a wife, a sports lover, and a mother combined.', 895.55, 53, 62, 16),
('Rowe and Sons Society TV', 'Immerse yourself in the Rowe and Sons Society TV. Another level of hair-raising experiences awaits as you compare, apply, and make calls with crystal-clear visuals and sound.', 493.3, 50, 39, 4),
('Stout-Brown Word Gaming Headset', 'Hear every single word in your gaming adventures with the Stout-Brown Word Gaming Headset. From art to international travel, this headset asks the right questions and guides you through the gaming world.', 355.11, 75, 2, 1),
('Williams Group Behind Smart TV', 'Get behind the scenes with the Williams Group Behind Smart TV. This smart TV has exactly what you need to fulfill its purpose, delivering a ball-like speech with stunning visuals.', 754.67, 21, 28, 7),
('Holmes and Sons Dream Virtual Reality Kit', 'Turn your dreams into reality with the Holmes and Sons Dream Virtual Reality Kit. This defense show for your senses provides a company experience that feels actually radio-like.', 163.22, 49, 13, 10),
('Bautista Inc Yard Console Stand', 'Take your gaming experience to the next level with the Bautista Inc Yard Console Stand. End strong, take control of your gaming setup, and enjoy specific, party-like moments.', 723.6, 3, 28, 12),
('Parsons, Hill and Franco Himself VR Headset', 'Immerse yourself in virtual reality with the Parsons, Hill and Franco Himself VR Headset. Let the mother of views attack your senses as you say yes to hard-to-believe experiences.', 373.76, 81, 89, 19),
('Wilson Group Clearly Gaming Monitor', 'See clearly with the Wilson Group Clearly Gaming Monitor. Born Democrat or not, this monitor ensures the best visuals for none other than the surest gaming experiences.', 883.68, 11, 42, 10),
('Kim-Jackson Eye Gaming Camera', 'Capture every gaming moment with the Kim-Jackson Eye Gaming Camera. Recognize, teach, and share your gaming skills with the nation of fellow gamers.', 454.84, 79, 9, 9),
('Knight, Lawson and Wade Long TV Stand', 'Embark on a long journey of entertainment with the Knight, Lawson and Wade Long TV Stand. Begin to write your story as you staff it with all the necessary components for a great TV experience.', 705.06, 91, 36, 8);


INSERT INTO `orders` (`customer_account_id`, `order_date`, `total_amount`, `branch_id`) VALUES (54, '2022-08-28', 287.26, 3),
(51, '2023-10-19', 382.59, 3),
(47, '2022-05-11', 388.18, 4),
(21, '2023-07-16', 116.19, 5),
(16, '2023-07-19', 397.99, 10),
(34, '2022-09-14', 113.42, 6),
(80, '2021-10-07', 229.53, 3),
(27, '2021-11-21', 210.33, 9),
(84, '2021-12-04', 447.3, 6),
(18, '2023-09-10', 438.96, 10),
(52, '2021-11-14', 345.09, 3),
(18, '2023-02-23', 17.83, 2),
(55, '2022-06-13', 293.96, 7),
(76, '2021-04-16', 102.08, 6),
(45, '2021-09-11', 324.19, 1),
(73, '2022-09-26', 234.48, 6),
(95, '2023-11-07', 323.71, 1),
(89, '2022-09-24', 370.05, 5),
(51, '2021-05-27', 450.39, 1),
(32, '2023-05-17', 334.5, 7),
(54, '2022-10-10', 454.45, 7),
(88, '2021-04-04', 484.28, 4),
(3, '2022-09-27', 64.8, 3),
(78, '2022-03-12', 295.78, 10),
(54, '2021-08-27', 126.82, 5),
(4, '2023-04-19', 376.44, 10),
(93, '2022-05-22', 388.13, 3),
(53, '2021-08-26', 174.99, 7),
(33, '2023-04-15', 461.22, 10),
(46, '2022-02-05', 330.43, 10),
(93, '2023-04-24', 319.52, 1),
(1, '2021-10-26', 444.95, 7),
(17, '2021-03-10', 32.18, 6),
(50, '2023-09-18', 84.5, 5),
(40, '2022-12-15', 108.02, 10),
(41, '2023-06-01', 118.52, 3),
(63, '2021-04-14', 170.07, 8),
(61, '2021-07-07', 144.53, 7),
(76, '2023-06-03', 135.52, 10),
(9, '2023-06-01', 19.85, 7),
(64, '2021-06-17', 269.29, 7),
(25, '2021-01-28', 372.95, 7),
(40, '2021-01-25', 294.57, 1),
(45, '2022-12-21', 306.71, 9),
(23, '2023-10-01', 239.66, 10),
(92, '2021-07-04', 346.87, 7),
(50, '2023-10-24', 140.04, 6),
(78, '2022-10-16', 451.24, 5),
(5, '2022-02-20', 19.0, 4),
(11, '2021-09-10', 493.88, 1),
(10, '2021-07-20', 390.49, 9),
(1, '2023-01-03', 321.76, 10),
(43, '2021-06-22', 124.2, 2),
(84, '2021-07-20', 436.44, 5),
(97, '2022-05-12', 383.84, 1),
(37, '2023-04-22', 303.48, 9),
(44, '2022-11-04', 213.94, 2),
(84, '2021-09-07', 471.24, 4),
(34, '2023-09-17', 184.37, 3),
(57, '2021-09-08', 462.48, 5),
(39, '2021-04-08', 311.8, 9),
(22, '2023-02-03', 418.49, 5),
(58, '2023-11-12', 378.29, 8),
(22, '2023-08-24', 337.91, 4),
(89, '2021-02-23', 301.76, 6),
(74, '2022-11-24', 328.63, 10),
(66, '2023-01-15', 435.23, 3),
(51, '2023-10-02', 128.05, 6),
(45, '2021-10-18', 69.08, 6),
(64, '2022-02-16', 242.57, 9),
(59, '2023-06-18', 28.46, 2),
(91, '2023-05-17', 320.51, 4),
(18, '2021-07-01', 266.21, 6),
(25, '2021-02-03', 382.55, 2),
(54, '2021-02-22', 253.38, 1),
(98, '2022-08-05', 460.25, 8),
(76, '2021-11-12', 395.42, 10),
(14, '2022-12-25', 59.8, 6),
(80, '2021-08-06', 206.99, 8),
(84, '2023-08-31', 358.21, 7),
(12, '2022-02-22', 389.38, 6),
(9, '2022-10-31', 495.07, 8),
(79, '2021-12-23', 36.92, 9),
(63, '2021-02-08', 132.28, 6),
(63, '2021-05-04', 111.42, 1),
(83, '2021-05-29', 434.41, 10),
(11, '2021-03-27', 425.0, 2),
(45, '2021-08-27', 213.82, 8),
(54, '2021-06-04', 233.27, 1),
(16, '2022-03-30', 55.67, 4),
(89, '2021-09-01', 87.93, 2),
(94, '2022-03-03', 443.19, 3),
(11, '2023-07-22', 243.74, 4),
(56, '2022-08-31', 422.79, 9),
(49, '2022-01-24', 447.13, 4),
(99, '2023-05-24', 253.65, 4),
(80, '2023-10-29', 257.48, 8),
(96, '2023-01-01', 139.25, 2),
(98, '2023-05-23', 255.69, 7),
(75, '2023-07-30', 41.12, 7);




INSERT INTO `order_items` (`order_id`, `product_id`, `quantity`, `price`) VALUES (4, 38, 9, 202.25),
(36, 27, 10, 413.68),
(40, 52, 1, 261.48),
(26, 67, 2, 348.72),
(94, 9, 9, 421.29),
(80, 98, 2, 499.02),
(44, 52, 7, 421.86),
(53, 47, 1, 361.39),
(11, 95, 10, 247.64),
(63, 22, 3, 313.2),
(93, 52, 9, 341.5),
(66, 62, 10, 44.71),
(66, 21, 2, 465.57),
(75, 81, 5, 460.29),
(59, 54, 9, 430.04),
(31, 81, 3, 270.33),
(22, 79, 10, 74.05),
(18, 32, 2, 241.48),
(72, 22, 10, 44.91),
(69, 96, 8, 170.94),
(16, 15, 6, 297.51),
(13, 24, 3, 239.41),
(70, 76, 8, 407.96),
(36, 57, 1, 276.73),
(30, 97, 4, 376.04),
(76, 5, 1, 240.47),
(34, 28, 2, 70.47),
(78, 4, 10, 498.19),
(14, 21, 7, 169.67),
(51, 63, 6, 401.37),
(87, 48, 2, 303.46),
(79, 40, 3, 104.55),
(32, 74, 5, 369.05),
(40, 88, 7, 234.16),
(85, 12, 6, 199.82),
(50, 85, 1, 139.43),
(77, 90, 6, 123.97),
(49, 65, 6, 163.09),
(93, 71, 6, 56.02),
(64, 52, 9, 429.7),
(16, 56, 1, 208.47),
(11, 97, 8, 336.57),
(50, 62, 10, 307.74),
(3, 53, 8, 244.99),
(46, 46, 10, 140.18),
(30, 89, 4, 66.45),
(94, 95, 3, 260.54),
(86, 78, 2, 394.76),
(70, 94, 4, 178.58),
(57, 48, 4, 190.76),
(29, 57, 2, 313.33),
(62, 1, 8, 316.0),
(45, 61, 6, 109.53),
(41, 4, 1, 275.18),
(24, 32, 6, 350.04),
(65, 41, 7, 296.74),
(80, 88, 5, 384.34),
(67, 38, 3, 31.58),
(31, 80, 4, 145.51),
(3, 69, 1, 184.91),
(31, 91, 1, 466.94),
(92, 100, 6, 235.9),
(66, 97, 1, 16.83),
(56, 39, 1, 382.23),
(38, 64, 2, 114.54),
(93, 15, 1, 202.9),
(85, 57, 2, 139.98),
(13, 44, 3, 351.84),
(100, 94, 3, 302.79),
(70, 57, 2, 424.05),
(80, 73, 5, 452.0),
(14, 52, 5, 89.8),
(32, 44, 4, 199.19),
(97, 84, 6, 124.64),
(97, 33, 3, 246.55),
(95, 74, 1, 484.08),
(73, 60, 6, 73.05),
(6, 56, 5, 449.76),
(26, 91, 4, 366.52),
(82, 30, 9, 127.87),
(68, 63, 8, 143.79),
(51, 78, 9, 141.55),
(66, 94, 2, 225.42),
(57, 22, 9, 62.72),
(23, 9, 1, 131.76),
(26, 29, 1, 471.28),
(64, 98, 7, 465.18),
(70, 90, 3, 415.34),
(71, 4, 10, 219.84),
(48, 23, 10, 416.85),
(98, 12, 5, 214.71),
(72, 15, 6, 483.73),
(62, 71, 1, 191.49),
(74, 92, 1, 405.29),
(45, 45, 5, 246.01),
(55, 13, 8, 290.06),
(100, 42, 3, 346.15),
(31, 4, 4, 256.7),
(17, 88, 9, 95.23),
(48, 56, 1, 493.72),
(82, 2, 5, 492.62),
(11, 40, 10, 97.39),
(64, 34, 4, 457.2),
(89, 86, 3, 481.94),
(21, 26, 6, 446.95),
(86, 37, 5, 464.75),
(97, 52, 3, 411.37),
(50, 50, 3, 389.56),
(12, 68, 3, 434.33),
(60, 25, 3, 465.89),
(54, 94, 5, 474.04),
(12, 10, 3, 363.01),
(27, 41, 4, 258.73),
(64, 100, 8, 282.16),
(16, 86, 5, 111.76),
(2, 13, 6, 108.55),
(22, 49, 7, 430.0),
(31, 96, 10, 492.3),
(79, 35, 3, 240.62),
(74, 64, 4, 187.92),
(1, 29, 3, 139.3),
(9, 62, 6, 232.73),
(84, 53, 1, 98.05),
(42, 10, 2, 97.75),
(31, 61, 2, 180.79),
(5, 92, 10, 130.39),
(73, 86, 7, 105.81),
(27, 70, 7, 315.32),
(85, 75, 4, 214.0),
(69, 1, 4, 229.34),
(50, 100, 9, 50.77),
(77, 7, 1, 380.14),
(83, 96, 8, 40.42),
(50, 84, 5, 173.73),
(3, 49, 2, 175.75),
(14, 38, 2, 299.89),
(15, 64, 8, 442.71),
(19, 32, 5, 407.25),
(58, 48, 9, 14.09),
(33, 45, 5, 372.22),
(86, 54, 2, 409.57),
(27, 23, 7, 382.72),
(4, 92, 7, 398.52),
(98, 4, 8, 412.14),
(87, 66, 5, 447.34),
(12, 21, 2, 310.22),
(16, 63, 1, 262.47),
(100, 99, 3, 26.37),
(20, 19, 9, 60.23),
(23, 30, 6, 424.1),
(47, 12, 9, 299.98),
(93, 59, 5, 114.85),
(83, 25, 3, 13.41),
(2, 23, 6, 335.44),
(57, 37, 1, 15.67),
(47, 59, 8, 337.8),
(7, 72, 2, 458.44),
(54, 7, 2, 426.09),
(13, 87, 1, 381.53),
(49, 85, 4, 126.66),
(29, 37, 9, 369.16),
(64, 74, 5, 253.4),
(4, 43, 9, 310.56),
(68, 53, 6, 159.46),
(45, 86, 2, 274.11),
(65, 26, 10, 35.48),
(69, 25, 7, 372.35),
(85, 56, 5, 28.3),
(61, 20, 6, 190.18),
(79, 28, 5, 156.83),
(51, 68, 9, 277.1),
(56, 83, 9, 232.39),
(28, 71, 1, 28.37),
(60, 63, 1, 434.08),
(80, 70, 5, 465.14),
(56, 52, 8, 377.42),
(38, 4, 2, 276.37),
(62, 59, 10, 498.32),
(86, 90, 4, 337.67),
(8, 13, 6, 429.57),
(91, 58, 7, 204.39),
(82, 86, 3, 225.29),
(5, 65, 9, 66.45),
(72, 37, 10, 274.46),
(33, 94, 8, 422.3),
(61, 11, 3, 451.66),
(35, 17, 6, 210.61),
(1, 79, 5, 42.61),
(34, 17, 3, 127.55),
(29, 32, 10, 168.12),
(23, 9, 9, 317.24),
(2, 21, 5, 378.2),
(39, 58, 10, 270.81),
(50, 14, 2, 280.93),
(3, 36, 5, 374.14),
(7, 26, 3, 491.54),
(15, 82, 8, 152.36),
(11, 37, 9, 278.01),
(26, 73, 10, 441.6),
(20, 2, 7, 203.37),
(78, 38, 5, 185.68),
(92, 98, 1, 54.74),
(19, 27, 2, 340.72),
(49, 74, 4, 432.73),
(58, 13, 9, 285.33),
(55, 40, 8, 486.31),
(65, 5, 6, 442.39),
(71, 34, 5, 188.28),
(42, 63, 8, 254.26),
(12, 56, 5, 131.12),
(12, 93, 2, 356.62),
(18, 40, 4, 494.08),
(45, 97, 7, 230.3),
(56, 94, 1, 272.53),
(60, 78, 1, 191.96),
(59, 43, 2, 493.87),
(7, 93, 2, 80.61),
(15, 14, 9, 336.08),
(7, 91, 2, 348.5),
(60, 25, 9, 116.8),
(5, 17, 9, 188.48),
(37, 33, 7, 187.81),
(27, 64, 8, 386.8),
(29, 95, 5, 70.41),
(57, 88, 9, 270.42),
(89, 4, 1, 231.84),
(79, 84, 5, 152.76),
(67, 47, 2, 143.89),
(8, 20, 10, 418.6),
(82, 60, 6, 34.96),
(82, 5, 9, 37.32),
(40, 8, 6, 214.48),
(73, 53, 8, 340.03),
(14, 7, 9, 460.83),
(26, 74, 6, 399.37),
(27, 22, 9, 299.98),
(25, 96, 7, 475.22),
(94, 36, 9, 163.54),
(94, 79, 1, 366.43),
(76, 49, 2, 224.15),
(17, 73, 1, 441.47),
(72, 88, 4, 93.07),
(97, 40, 7, 93.93),
(38, 58, 1, 352.18),
(94, 100, 7, 418.1),
(3, 15, 7, 40.83),
(74, 12, 9, 21.05),
(19, 41, 3, 256.34),
(51, 31, 10, 190.96),
(42, 55, 1, 395.21),
(44, 89, 2, 411.02),
(56, 99, 10, 138.45),
(47, 45, 1, 456.05),
(42, 57, 1, 138.47),
(17, 96, 1, 473.69),
(49, 27, 3, 453.44),
(86, 25, 5, 245.35),
(42, 38, 9, 281.02),
(30, 34, 4, 219.89),
(4, 75, 10, 83.84),
(14, 57, 10, 18.32),
(58, 74, 8, 336.59),
(84, 30, 3, 291.52),
(50, 94, 7, 20.79),
(81, 93, 9, 111.55),
(37, 94, 2, 262.41),
(70, 17, 8, 492.34),
(65, 41, 4, 471.43),
(47, 60, 7, 75.49),
(61, 56, 5, 20.67),
(23, 24, 6, 60.35),
(18, 96, 1, 224.4),
(35, 43, 1, 280.67),
(66, 60, 8, 295.61),
(91, 39, 8, 349.33),
(75, 56, 1, 123.75),
(96, 75, 2, 138.68),
(42, 30, 10, 11.38),
(44, 37, 2, 64.25),
(51, 25, 6, 434.62),
(34, 82, 10, 479.22),
(64, 65, 4, 124.17),
(56, 43, 4, 83.18),
(54, 71, 2, 357.23),
(33, 35, 4, 12.71),
(90, 14, 5, 485.61),
(52, 39, 8, 451.23),
(69, 85, 10, 362.38),
(74, 75, 4, 155.48),
(70, 21, 1, 30.57),
(70, 64, 7, 409.24),
(88, 92, 9, 423.31),
(38, 47, 4, 173.34),
(15, 1, 8, 414.46),
(92, 41, 10, 196.75),
(25, 55, 2, 223.1),
(62, 37, 2, 157.06),
(76, 7, 1, 488.27),
(51, 23, 7, 326.83),
(93, 67, 4, 94.88);


INSERT INTO `reviews` (`customer_account_id`, `product_id`, `rating`, `comments`, `review_date`, `order_id`) VALUES
(4, 5, 4, 'Satisfied with the purchase, good value', '2023-03-15', 4),
(17, 18, 5, 'Impressive product, exceeded expectations', '2022-05-22', 17),
(8, 9, 2, 'Disappointed with the quality, expected better', '2023-07-08', 8),
(92, 63, 1, 'Terrible experience, product never arrived', '2022-09-18', 92),
(55, 42, 3, 'Average product, nothing extraordinary', '2023-11-30', 55),
(21, 32, 4, 'Excellent customer service, quick issue resolution', '2022-12-05', 21),
(36, 74, 3, 'Product meets expectations, decent quality', '2023-02-10', 36),
(68, 12, 1, 'Not recommended, poor customer support', '2023-01-25', 68),
(43, 87, 5, 'Fantastic service, highly recommended', '2022-04-14', 43),
(79, 55, 2, 'Issues with shipping, delayed delivery', '2022-10-03', 79),
(14, 27, 4, 'Impressed with the features, good value', '2023-08-20', 14),
(97, 91, 3, 'Average product, needs improvement', '2022-11-15', 97),
(26, 46, 5, 'Outstanding quality, exceeded expectations', '2023-09-05', 26),
(61, 29, 2, 'Disappointed with the purchase, defective item', '2023-06-18', 61),
(93, 13, 4, 'Great value for the price, fast shipping', '2023-04-30', 93),
(48, 79, 1, 'Worst experience ever, damaged product', '2022-12-22', 48),
(32, 64, 5, 'Excellent product, no issues whatsoever', '2022-08-08', 32),
(85, 38, 3, 'Satisfactory performance, nothing exceptional', '2023-07-02', 85),
(7, 82, 4, 'Quality product, but delivery took longer than expected', '2023-05-12', 7),
(19, 50, 2, 'Not as described, disappointed with the features', '2023-03-26', 19),
(72, 20, 5, 'Amazing customer service, resolved my issue promptly', '2022-07-15', 72),
(54, 80, 3, 'Average experience, could be better', '2023-01-28', 54),
(10, 58, 4, 'Happy with the purchase, good value for money', '2022-06-10', 10),
(84, 7, 1, 'Terrible product, avoid at all costs', '2022-02-16', 84),
(25, 97, 5, 'Highly satisfied with the product and service', '2023-10-08', 25),
(67, 21, 3, 'Decent quality, but expected more features', '2023-11-18', 67),
(39, 96, 4, 'Good product, reliable performance', '2022-09-30', 39),
(11, 43, 2, 'Poor customer support, unresolved issue', '2022-05-05', 11),
(69, 2, 5, 'Outstanding purchase, exceeded my expectations', '2023-04-14', 69),
(31, 89, 3, 'Average service, product arrived as expected', '2022-08-20', 31),
(76, 59, 4, 'Solid product, no complaints', '2023-03-05', 76),
(44, 16, 1, 'Defective item received, seeking replacement', '2023-07-22', 44),
(83, 93, 5, 'Fantastic product, worth every penny', '2022-11-28', 83),
(16, 41, 3, 'Decent purchase, but had some issues', '2023-10-15', 16),
(28, 84, 4, 'Reliable product, would recommend', '2023-01-12', 28),
(59, 56, 2, 'Disappointed with the quality, not durable', '2022-06-25', 59),
(95, 24, 5, 'Exceptional product, flawless performance', '2023-05-30', 95),
(22, 76, 3, 'Average product, meets basic requirements', '2022-12-10', 22),
(64, 3, 4, 'Happy with the purchase, good customer support', '2023-09-02', 64),
(37, 85, 2, 'Not as expected, would not recommend', '2023-08-15', 37),
(71, 45, 5, 'Outstanding quality, exceeded my expectations', '2023-04-28', 71),
(49, 92, 3, 'Decent product, average service', '2022-07-05', 49),
(17, 70, 4, 'Good value for money, reliable product', '2023-02-18', 17),
(81, 8, 1, 'Terrible experience, poor product quality', '2023-01-05', 81),
(15, 34, 5, 'Extremely satisfied, great product and service', '2022-04-22', 15),
(98, 61, 3, 'Average performance, expected better', '2022-10-10', 98),
(30, 19, 4, 'Impressed with the features, good purchase', '2023-11-25', 30),
(74, 98, 2, 'Disappointed with the service, product issues', '2022-05-30', 74),
(56, 22, 5, 'Exceptional product, exceeded my expectations', '2022-09-12', 56),
(9, 77, 3, 'Decent product, but could be improved', '2023-08-25', 9),
(80, 4, 4, 'Good service, reliable product', '2023-03-08', 80),
(45, 65, 2, 'Not satisfied with the product, poor quality', '2022-12-22', 45),
(24, 88, 5, 'Absolutely satisfied with the purchase', '2022-06-10', 24),
(70, 23, 3, 'Average product, met my basic requirements', '2023-05-15', 70),
(47, 82, 4, 'Happy with the service, product as expected', '2023-01-28', 47),
(79, 36, 2, 'Disappointed with the purchase, expected more', '2022-07-02', 79),
(4, 5, 4, 'Satisfied with the purchase; convinced my pet parrot to become a tech geek!', '2023-03-15', 4),
(17, 18, 5, 'Bought this to communicate with aliens - they love it!', '2022-05-22', 17),
(8, 9, 2, 'Expected this to transform into a robot, but sadly it just beeped angrily.', '2023-07-08', 8),
(92, 63, 1, 'Turns out the product was a portal to another dimension. Would not recommend for daily use.', '2022-09-18', 92),
(55, 42, 3, 'This product is like my ex—looks good but disappoints in the long run.', '2023-11-30', 55),
(21, 32, 4, 'Customer service was so good; they sent me a singing telegram to apologize for any inconvenience!', '2022-12-05', 21),
(36, 74, 3, 'Product started singing the national anthem at 3 AM. Would be cool if it wasn’t so creepy.', '2023-02-10', 36),
(68, 12, 1, 'Ordered a tech gadget, got a rubber chicken instead. Customer support just laughed. Literally.', '2023-01-25', 68),
(43, 87, 5, 'Not sure if the product is haunted, but the ghost seems to be friendly and tech-savvy!', '2022-04-14', 43),
(79, 55, 2, 'This product is more high-maintenance than my last relationship. Needs constant attention.', '2022-10-03', 79),
(14, 27, 4, 'Bought this for my cat; now he thinks he is the CEO of a tech company #CatCEO!!', '2023-08-20', 14),
(97, 91, 3, 'Product tried to order pizza without my permission. A for effort, but that’s not cool, bro.', '2022-11-15', 97),
(26, 46, 5, 'Product gave me fashion advice. Now I’m the most stylish person in my living room.', '2023-09-05', 26),
(61, 29, 2, 'Product speaks only in Shakespearean English. I just wanted it to turn on the lights, not recite Hamlet!', '2023-06-18', 61),
(93, 13, 4, 'Ordered a tech gadget, got a personalized lullaby. My new sleep aid!', '2023-04-30', 93),
(48, 79, 1, 'This product identifies as a plant. It insists I water it daily and talk to it about my feelings.', '2022-12-22', 48),
(32, 64, 5, 'Bought this to impress my houseplants. They seem indifferent, but I think they secretly love it.', '2022-08-08', 32),
(85, 38, 3, 'Product started making coffee for me. I never programmed it to do that, but I’m not complaining!', '2023-07-02', 85),
(7, 82, 4, 'Ordered a tech gadget, got a mystery novel. The plot thickens...', '2023-05-12', 7),
(19, 50, 2, 'Product has a British accent. Now I feel like I’m in a tech version of Downton Abbey.', '2023-03-26', 19),
(72, 20, 5, 'My product started rapping. Now were dropping a mixtape together. #TechRapDuo', '2022-07-15', 72),
(54, 80, 3, 'Product learned to breakdance. I didn’t teach it. Not sure how to feel about this.', '2023-01-28', 54);

-- Trigger implementation

-- The first trigger updates product stock after an order is placed, ensuring that inventory levels are accurate

DELIMITER //

CREATE TRIGGER update_quantity_available
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  UPDATE products
  SET quantity_available = quantity_available - NEW.quantity
  WHERE product_id = NEW.product_id;
END;
//

DELIMITER ;

SELECT name , quantity_available  from products p WHERE product_id =2;

-- Simulating an order being placed
INSERT INTO orders (customer_account_id, order_date, total_amount, branch_id)
VALUES (1, '2023-12-06', 499.99, 1);

-- Simulating an item being sold (order_items)
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (LAST_INSERT_ID(), 2, 1, 499.99);

SELECT name , quantity_available from products p WHERE product_id =2;

-- The second trigger inserts a log entry after a customer adds a review, helping us track customer interactions and improve our services

DELIMITER //

CREATE TRIGGER log_order_placed
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  INSERT INTO logs (log_type, log_description, timestamp)
  VALUES ('Order Placed', CONCAT('Order with ID ', NEW.order_id, ' placed by customer ', NEW.customer_account_id, '.'), NOW());
END;
//

DELIMITER ;

INSERT INTO orders (customer_account_id, order_date, total_amount, branch_id)
VALUES (1, '2023-12-06', 499.99, 1);


-- Listing all the customer’s names, dates, and products bought by these customers in a range of two dates
SELECT 
  CONCAT(ca.first_name,' ', ca.family_name)  AS customer_name,
  o.order_date AS order_date,
  p.name AS product_name
FROM 
  customer_accounts ca
JOIN 
  orders o ON ca.customer_account_id = o.customer_account_id
JOIN 
  order_items oi ON o.order_id = oi.order_id
JOIN 
  products p ON oi.product_id = p.product_id
WHERE 
  o.order_date BETWEEN '2020-01-01' AND  NOW();
 
 -- Listing the best three customers
SELECT 
  CONCAT(ca.first_name,' ', ca.family_name)  AS customer_name,
  SUM(o.total_amount) AS total_spent
FROM 
  customer_accounts ca
JOIN 
  orders o ON ca.customer_account_id = o.customer_account_id
GROUP BY 
  ca.customer_account_id 
ORDER BY 
  total_spent DESC
LIMIT 3;

-- Getting the average amount of sales for a given period
SELECT 
  CONCAT(MIN(YEAR(order_date)), '-', MAX(YEAR(order_date))) AS PeriodOfSales,
  SUM(total_amount) AS TotalSales,
  SUM(total_amount) / (MAX(YEAR(order_date)) - MIN(YEAR(order_date)) + 1) AS YearlyAverage,
  SUM(total_amount) / ((MAX(YEAR(order_date)) - MIN(YEAR(order_date)) + 1) * 12) AS MonthlyAverage
FROM 
  orders
WHERE 
  YEAR(order_date) >= YEAR(CURDATE()) - 2;

-- Getting the total sales for each location
SELECT 
  l.city AS location,
  SUM(
    oi.price
  ) AS total_sales
FROM 
  order_items oi
JOIN 
  orders o ON oi.order_id = o.order_id
JOIN 
  locations l ON o.branch_id = l.relation_id AND l.relation_type = 'Branch'
GROUP BY 
  l.city;

 -- Listing all the locations where products have been sold and reviewed
SELECT DISTINCT
  l.city AS location
FROM 
  orders o
JOIN 
  order_items oi ON o.order_id = oi.order_id
JOIN 
  products p ON oi.product_id = p.product_id
JOIN 
  reviews r ON p.product_id = r.product_id
JOIN 
  branches b ON o.branch_id = b.branch_id
JOIN 
  locations l ON b.branch_id = l.relation_id AND l.relation_type = 'Branch';


-- Creating Views

-- The 'InvoiceHead' view summarizes the head and totals information for invoices
CREATE VIEW InvoiceHead AS
SELECT 
  o.order_id AS invoice_number,
  CONCAT(ca.first_name,' ', ca.family_name)  AS customer_name,
  ca.email AS customer_email,
  o.total_amount AS total_amount
FROM 
  orders o
JOIN 
  customer_accounts ca ON o.customer_account_id = ca.customer_account_id
GROUP BY 
  o.order_id, ca.first_name, ca.family_name, ca.email; -- Group by invoice/order and customer details

-- The 'InvoiceDetails' view provides detailed information on items included in each invoice
CREATE VIEW InvoiceDetails AS
SELECT 
  o.order_id AS invoice_number,
  p.product_id AS item_id,
  p.name AS DESCRIPTION,
  oi.price AS 'UNIT COST',
  oi.quantity AS QTY,
  oi.price * oi.quantity AS AMOUNT
FROM 
  orders o
JOIN 
  order_items oi ON o.order_id = oi.order_id
JOIN 
  products p ON oi.product_id = p.product_id;


SELECT * from InvoiceHead;

SELECT * from InvoiceDetails;