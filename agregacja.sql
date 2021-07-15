-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 15 Lip 2021, 14:35
-- Wersja serwera: 10.4.20-MariaDB
-- Wersja PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `agregacja`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addLog` (IN `id_osoby` INT, IN `zmiana` VARCHAR(200), IN `data_zmiany` DATETIME)  NO SQL
INSERT INTO dziennik_zdarzen VALUES (NULL, id_osoby, zmiana, data_zmiany)$$

--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `dodajPromocje` (`cena_aktualna` FLOAT) RETURNS FLOAT NO SQL
BEGIN

SET @nowa_cena = cena_aktualna - (cena_aktualna * 0.1);

RETURN @nowa_cena;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `display_part`
--

CREATE TABLE `display_part` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_device` int(11) NOT NULL,
  `displayed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci
PARTITION BY RANGE (unix_timestamp(`displayed`))
(
PARTITION p0 VALUES LESS THAN (1577833200) ENGINE=InnoDB,
PARTITION p1 VALUES LESS THAN (1609455600) ENGINE=InnoDB,
PARTITION p2 VALUES LESS THAN MAXVALUE ENGINE=InnoDB
);

--
-- Zrzut danych tabeli `display_part`
--

INSERT INTO `display_part` (`id`, `id_user`, `id_device`, `displayed`) VALUES
(1, 1, 1, '2019-03-13 14:00:00'),
(2, 2, 2, '2020-03-12 23:00:00'),
(3, 3, 3, '2021-03-13 14:27:53'),
(4, 3, 1, '2021-03-13 14:28:46');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dziennik_zdarzen`
--

CREATE TABLE `dziennik_zdarzen` (
  `id` int(11) NOT NULL,
  `id_osoby` int(11) NOT NULL,
  `zmiana` varchar(400) COLLATE utf8_polish_ci NOT NULL,
  `data_zmiany` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci
PARTITION BY RANGE (`id`)
(
PARTITION p0 VALUES LESS THAN (2) ENGINE=InnoDB,
PARTITION p1 VALUES LESS THAN (3) ENGINE=InnoDB,
PARTITION p2 VALUES LESS THAN (4) ENGINE=InnoDB,
PARTITION p3 VALUES LESS THAN (5) ENGINE=InnoDB,
PARTITION p4 VALUES LESS THAN (6) ENGINE=InnoDB,
PARTITION p5 VALUES LESS THAN (7) ENGINE=InnoDB,
PARTITION p6 VALUES LESS THAN MAXVALUE ENGINE=InnoDB
);

--
-- Zrzut danych tabeli `dziennik_zdarzen`
--

INSERT INTO `dziennik_zdarzen` (`id`, `id_osoby`, `zmiana`, `data_zmiany`) VALUES
(1, 5, 'Zmiana1 -> Zmiana2', '2021-03-14 00:00:00'),
(2, 10, 'było1->jest2', '2021-03-14 09:30:00'),
(3, 14, 'USUNIĘCIE REKORDU', '2021-03-14 09:37:38'),
(4, 10, 'Nastąpiła zmiana imienia: Kamilo-->Kamil', '2021-03-14 09:42:11');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `osoby`
--

CREATE TABLE `osoby` (
  `id` int(11) NOT NULL,
  `imie` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  `nazwisko` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  `rok_urodzenia` year(4) DEFAULT NULL,
  `miejscowosc` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  `data_dodania` datetime NOT NULL DEFAULT current_timestamp(),
  `data_modyfikacji` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `osoby`
--

INSERT INTO `osoby` (`id`, `imie`, `nazwisko`, `rok_urodzenia`, `miejscowosc`, `data_dodania`, `data_modyfikacji`) VALUES
(1, 'Adam', 'Kowalski', 1984, 'Warszawa', '0000-00-00 00:00:00', '2021-03-13 14:05:47'),
(2, 'Adam', 'Nowak', 1982, 'Szczecin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Andrzej', 'Kowalski', 1995, 'Nidzica', '0000-00-00 00:00:00', '2021-03-13 12:02:20'),
(4, 'Arkadiusz', 'Malinowski', 1996, 'Kielce', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'Andrzej2', 'Malinowski2', 1976, 'Kielce', '0000-00-00 00:00:00', '2021-03-13 13:16:25'),
(6, 'Krzysztof', 'Nowicki', 1996, 'Bydgoszcz', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'Kacper', 'Adamkiewicz', 1984, 'Kielce', '0000-00-00 00:00:00', '2021-03-13 15:58:45'),
(8, 'Kamil', 'Andrzejczak', 1981, 'Kraków', '0000-00-00 00:00:00', '2021-03-13 12:39:52'),
(9, 'Krzysztof', 'Arkuszewski', 1978, 'Szczecin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 'Kamil', 'Borowicz', 1986, 'Skierniewice', '0000-00-00 00:00:00', '2021-03-14 09:42:11'),
(12, 'Jacek', 'Nowakowski', 2010, 'Kraków', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 'Paweł', 'Pacanowski', 2009, 'Warszawa', '2021-03-13 13:40:02', '2021-03-13 15:45:55');

--
-- Wyzwalacze `osoby`
--
DELIMITER $$
CREATE TRIGGER `osobyDel` BEFORE DELETE ON `osoby` FOR EACH ROW CALL addLog(OLD.id, ('USUNIĘCIE REKORDU'), now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `osobyMod` BEFORE UPDATE ON `osoby` FOR EACH ROW BEGIN

SET NEW.data_modyfikacji = now();

IF NEW.nazwisko != OLD.nazwisko
THEN
SET @zmiana1 = CONCAT('Nastąpiła zmiana nazwiska: ', OLD.nazwisko, '-->', NEW.nazwisko);
CALL addLog(OLD.id, @zmiana1, now());

END IF;

IF NEW.imie != OLD.imie
THEN
SET @zmiana2 = CONCAT('Nastąpiła zmiana imienia: ', OLD.imie, '-->', NEW.imie);
CALL addLog(OLD.id, @zmiana2, now());

END IF;

IF NEW.rok_urodzenia != OLD.rok_urodzenia
THEN
SET @zmiana3 = CONCAT('Nastąpiła zmiana daty: ', OLD.rok_urodzenia, '-->', NEW.imie);

CALL addLog(OLD.id, @zmiana3, now());

END IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  `opis` varchar(2000) COLLATE utf8_polish_ci NOT NULL,
  `cena` float NOT NULL,
  `termin_przydatnosci` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `produkty`
--

INSERT INTO `produkty` (`id`, `nazwa`, `opis`, `cena`, `termin_przydatnosci`) VALUES
(1, 'Produkt1', 'Opis1', 90, '2021-03-31'),
(2, 'Produkt2', 'Opis2', 180, '2021-03-31'),
(3, 'Produkt3', 'Opis3', 218.7, '2021-03-29'),
(4, 'Produkt4', 'Opis4', 291.6, '2021-03-23');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienia`
--

CREATE TABLE `zamowienia` (
  `id` int(11) NOT NULL,
  `klient_id` int(11) DEFAULT NULL,
  `towar_id` int(11) DEFAULT NULL,
  `data` datetime DEFAULT current_timestamp(),
  `wartosc` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `zamowienia`
--

INSERT INTO `zamowienia` (`id`, `klient_id`, `towar_id`, `data`, `wartosc`) VALUES
(1, 1, 2, '2010-01-01 00:00:00', 122.44),
(2, 1, 4, '2010-01-01 00:00:00', 100.22),
(3, 1, 2, '2010-02-12 00:00:00', 158.88),
(4, 2, 1, '2010-01-01 00:00:00', 224.35),
(5, 2, 1, '2010-02-12 00:00:00', 223.35),
(6, 2, 4, '2010-03-01 00:00:00', 267.28),
(7, 3, 1, '2010-02-11 00:00:00', 180.48),
(8, 3, 4, '2010-01-01 00:00:00', 120.44),
(9, 4, 1, '2010-03-11 00:00:00', 150.26),
(10, 5, 4, '2010-03-02 00:00:00', 60.11);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `display_part`
--
ALTER TABLE `display_part`
  ADD UNIQUE KEY `id` (`id`,`displayed`);

--
-- Indeksy dla tabeli `dziennik_zdarzen`
--
ALTER TABLE `dziennik_zdarzen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_osoby` (`id_osoby`);

--
-- Indeksy dla tabeli `osoby`
--
ALTER TABLE `osoby`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `klient_id` (`klient_id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `display_part`
--
ALTER TABLE `display_part`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `dziennik_zdarzen`
--
ALTER TABLE `dziennik_zdarzen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `osoby`
--
ALTER TABLE `osoby`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT dla tabeli `produkty`
--
ALTER TABLE `produkty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD CONSTRAINT `zamowienia_ibfk_1` FOREIGN KEY (`klient_id`) REFERENCES `osoby` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
