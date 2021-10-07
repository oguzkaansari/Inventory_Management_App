-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 07 Eki 2021, 14:44:38
-- Sunucu sürümü: 10.4.20-MariaDB
-- PHP Sürümü: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `depo_project`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `a_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_me` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`a_id`, `email`, `password`, `remember_me`) VALUES
(1, 'admin@mail.com', '58b1216b06850385d9a4eadbedc806c4 ', b'0');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `checkout`
--

CREATE TABLE `checkout` (
  `check_out_id` int(11) NOT NULL,
  `check_out_today_in` decimal(19,2) DEFAULT NULL,
  `check_out_today_out` decimal(19,2) DEFAULT NULL,
  `check_out_total` decimal(19,2) DEFAULT NULL,
  `check_out_total_in` decimal(19,2) DEFAULT NULL,
  `check_out_total_out` decimal(19,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `checkout`
--

INSERT INTO `checkout` (`check_out_id`, `check_out_today_in`, `check_out_today_out`, `check_out_total`, `check_out_total_in`, `check_out_total_out`) VALUES
(1, '0.00', '0.00', '163118000.00', '163130000.00', '12000.00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customer`
--

CREATE TABLE `customer` (
  `cu_id` int(11) NOT NULL,
  `cu_address` varchar(500) DEFAULT NULL,
  `cu_code` bigint(20) NOT NULL,
  `cu_company_title` varchar(255) DEFAULT NULL,
  `cu_email` varchar(500) DEFAULT NULL,
  `cu_mobile` varchar(255) DEFAULT NULL,
  `cu_name` varchar(255) DEFAULT NULL,
  `cu_password` varchar(32) DEFAULT NULL,
  `cu_phone` varchar(255) DEFAULT NULL,
  `cu_status` int(11) NOT NULL,
  `cu_surname` varchar(255) DEFAULT NULL,
  `cu_tax_administration` varchar(255) DEFAULT NULL,
  `cu_tax_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `customer`
--

INSERT INTO `customer` (`cu_id`, `cu_address`, `cu_code`, `cu_company_title`, `cu_email`, `cu_mobile`, `cu_name`, `cu_password`, `cu_phone`, `cu_status`, `cu_surname`, `cu_tax_administration`, `cu_tax_number`) VALUES
(1, '', 537131491, '', '', '5530589819', 'Oğuzkaan', '', NULL, 2, 'Sarı', '', 1645414),
(2, '', 537153848, '', '', '5555554444', 'Ahmet', '', NULL, 2, 'Çelik', '', 154456465);

--
-- Tetikleyiciler `customer`
--
DELIMITER $$
CREATE TRIGGER `dashboard_customer_decrease` AFTER DELETE ON `customer` FOR EACH ROW UPDATE dashboard 
SET cu_count = cu_count - 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dashboard_customer_increase` AFTER INSERT ON `customer` FOR EACH ROW UPDATE dashboard 
SET cu_count = cu_count + 1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dashboard`
--

CREATE TABLE `dashboard` (
  `d_id` int(11) NOT NULL,
  `cu_count` int(11) NOT NULL,
  `i_count` int(11) NOT NULL,
  `p_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `dashboard`
--

INSERT INTO `dashboard` (`d_id`, `cu_count`, `i_count`, `p_count`) VALUES
(1, 2, 9, 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `indent`
--

CREATE TABLE `indent` (
  `i_id` int(11) NOT NULL,
  `i_amount` double NOT NULL,
  `i_price` decimal(19,2) DEFAULT NULL,
  `product_p_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `indent`
--

INSERT INTO `indent` (`i_id`, `i_amount`, `i_price`, `product_p_id`) VALUES
(3, 20000, '40000.00', 4),
(4, 30000, '60000.00', 4),
(8, 100000, '1500000.00', 5),
(9, 20000, '160000000.00', 6),
(10, 20000, '40000.00', 4),
(11, 10000, '80000000.00', 6);

--
-- Tetikleyiciler `indent`
--
DELIMITER $$
CREATE TRIGGER `dashboard_indent_increase` AFTER INSERT ON `indent` FOR EACH ROW UPDATE dashboard 
SET i_count = i_count + 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `decrease_stock_trigger` AFTER INSERT ON `indent` FOR EACH ROW BEGIN
UPDATE product SET p_stock = p_stock - NEW.i_amount WHERE p_id = NEW.product_p_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `increase_stock_trigger` AFTER DELETE ON `indent` FOR EACH ROW BEGIN
UPDATE product SET p_stock = p_stock + OLD.i_amount WHERE p_id = OLD.product_p_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payout`
--

CREATE TABLE `payout` (
  `payout_id` int(11) NOT NULL,
  `payout_date` date DEFAULT NULL,
  `payout_detail` varchar(255) DEFAULT NULL,
  `payout_pay_method` int(11) NOT NULL,
  `payout_price` double NOT NULL,
  `payout_title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payout`
--

INSERT INTO `payout` (`payout_id`, `payout_date`, `payout_detail`, `payout_pay_method`, `payout_price`, `payout_title`) VALUES
(1, '2021-09-03', 'Plastik sandalye.', 1, 10000, 'Sandalye'),
(2, '2021-09-03', 'masa', 1, 2000, 'Masa');

--
-- Tetikleyiciler `payout`
--
DELIMITER $$
CREATE TRIGGER `checkout_decrease_trigger` AFTER INSERT ON `payout` FOR EACH ROW UPDATE checkout 
SET 
check_out_total = check_out_total - NEW.payout_price, 
check_out_total_out = check_out_total_out + NEW.payout_price
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product`
--

CREATE TABLE `product` (
  `p_id` int(11) NOT NULL,
  `p_buy_price` decimal(19,2) DEFAULT NULL,
  `p_code` bigint(20) DEFAULT NULL,
  `p_detail` varchar(255) DEFAULT NULL,
  `p_sell_price` decimal(19,2) DEFAULT NULL,
  `p_stock` double NOT NULL,
  `p_tax` double NOT NULL,
  `p_title` varchar(255) DEFAULT NULL,
  `p_unit` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `product`
--

INSERT INTO `product` (`p_id`, `p_buy_price`, `p_code`, `p_detail`, `p_sell_price`, `p_stock`, `p_tax`, `p_title`, `p_unit`) VALUES
(4, '1.00', 654029908, 'Sade gazoz.', '2.00', 130000, 1, 'Uludağ Gazoz', 'Adet'),
(5, '10.00', 669791688, '0.7 uçlu kalem.', '15.00', 0, 2, 'Rotring Kalem', 'Paket'),
(6, '5000.00', 673594202, 'iphone.', '8000.00', 20000, 2, 'İphone', 'Adet');

--
-- Tetikleyiciler `product`
--
DELIMITER $$
CREATE TRIGGER `dashboard_product_decrease` AFTER DELETE ON `product` FOR EACH ROW UPDATE dashboard 
SET p_count = p_count - 1
WHERE d_id = 1
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dashboard_product_increase` AFTER INSERT ON `product` FOR EACH ROW UPDATE dashboard 
SET p_count = p_count + 1 
WHERE d_id = 1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ticket`
--

CREATE TABLE `ticket` (
  `t_id` int(11) NOT NULL,
  `t_code` bigint(20) NOT NULL,
  `t_pay_method` int(11) NOT NULL,
  `t_price` double NOT NULL,
  `t_status` int(11) NOT NULL,
  `customer_cu_id` int(11) DEFAULT NULL,
  `t_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `ticket`
--

INSERT INTO `ticket` (`t_id`, `t_code`, `t_pay_method`, `t_price`, `t_status`, `customer_cu_id`, `t_date`) VALUES
(3, 658573019, 2, 100000, 1, 1, '2021-09-03'),
(5, 669834750, 2, 3000000, 1, 1, '2021-09-03'),
(6, 673645420, 4, 160000000, 1, 1, '2021-09-03'),
(7, 717556278, 0, 80040000, 0, 1, '1111-11-11');

--
-- Tetikleyiciler `ticket`
--
DELIMITER $$
CREATE TRIGGER `checkout_increase_trigger` AFTER UPDATE ON `ticket` FOR EACH ROW IF NEW.t_status = 1 THEN
UPDATE checkout 
SET 
check_out_total = check_out_total + NEW.t_price, 
check_out_total_in = check_out_total_in + NEW.t_price;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ticket_indent`
--

CREATE TABLE `ticket_indent` (
  `Ticket_t_id` int(11) NOT NULL,
  `indents_i_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `ticket_indent`
--

INSERT INTO `ticket_indent` (`Ticket_t_id`, `indents_i_id`) VALUES
(3, 3),
(3, 4),
(5, 8),
(6, 9),
(7, 10),
(7, 11);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`a_id`),
  ADD UNIQUE KEY `UK_jl20d0ecx48g7qwy1dxe2akre` (`email`);

--
-- Tablo için indeksler `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`check_out_id`);

--
-- Tablo için indeksler `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cu_id`);

--
-- Tablo için indeksler `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`d_id`);

--
-- Tablo için indeksler `indent`
--
ALTER TABLE `indent`
  ADD PRIMARY KEY (`i_id`),
  ADD KEY `FKgl1sumjf5xbkck1jcalvwkoy8` (`product_p_id`);

--
-- Tablo için indeksler `payout`
--
ALTER TABLE `payout`
  ADD PRIMARY KEY (`payout_id`);

--
-- Tablo için indeksler `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`p_id`);

--
-- Tablo için indeksler `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`t_id`),
  ADD KEY `FK72mr6y1v6wq7eccxlps1yquva` (`customer_cu_id`);

--
-- Tablo için indeksler `ticket_indent`
--
ALTER TABLE `ticket_indent`
  ADD PRIMARY KEY (`Ticket_t_id`,`indents_i_id`),
  ADD UNIQUE KEY `UK_tp0gkfg669gcwpuahvsm6aeng` (`indents_i_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `checkout`
--
ALTER TABLE `checkout`
  MODIFY `check_out_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `customer`
--
ALTER TABLE `customer`
  MODIFY `cu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `indent`
--
ALTER TABLE `indent`
  MODIFY `i_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Tablo için AUTO_INCREMENT değeri `payout`
--
ALTER TABLE `payout`
  MODIFY `payout_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `product`
--
ALTER TABLE `product`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `ticket`
--
ALTER TABLE `ticket`
  MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `indent`
--
ALTER TABLE `indent`
  ADD CONSTRAINT `FKgl1sumjf5xbkck1jcalvwkoy8` FOREIGN KEY (`product_p_id`) REFERENCES `product` (`p_id`);

--
-- Tablo kısıtlamaları `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `FK72mr6y1v6wq7eccxlps1yquva` FOREIGN KEY (`customer_cu_id`) REFERENCES `customer` (`cu_id`);

--
-- Tablo kısıtlamaları `ticket_indent`
--
ALTER TABLE `ticket_indent`
  ADD CONSTRAINT `FKoei9lsap6igo1b66hfy8oxqg6` FOREIGN KEY (`Ticket_t_id`) REFERENCES `ticket` (`t_id`),
  ADD CONSTRAINT `FKq8f5kbh73g99neb2bdtwkhl1u` FOREIGN KEY (`indents_i_id`) REFERENCES `indent` (`i_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
