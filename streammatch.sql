-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Erstellungszeit: 12. Dez 2025 um 13:00
-- Server-Version: 8.4.7
-- PHP-Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `streammatch`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Auszeichnung`
--

CREATE TABLE `Auszeichnung` (
  `Auszeichnung_ID` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Preistyp` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Auszeichnung`
--

INSERT INTO `Auszeichnung` (`Auszeichnung_ID`, `Name`, `Preistyp`) VALUES
(1, 'Bester Hauptdarsteller', 'Oscar'),
(2, 'Beste Hauptdarstellerin', 'Oscar'),
(3, 'Bester Nebendarsteller', 'Oscar'),
(4, 'Beste Nebendarstellerin', 'Oscar'),
(5, 'Bester Hauptdarsteller', 'Golden Globe'),
(6, 'Beste Hauptdarstellerin', 'Golden Globe'),
(7, 'Bester Hauptdarsteller', 'BAFTA'),
(8, 'Outstanding Actor', 'Emmy'),
(9, 'Best Actor', 'Saturn Award'),
(10, 'Best Actress', 'Saturn Award'),
(11, 'Best Actor', 'MTV Movie Award'),
(12, 'Best Actor', 'Tony Award'),
(13, 'Life Achievement', 'AFI Award'),
(14, 'Disney Legend', 'Disney'),
(15, 'Best Supporting Performance', 'Independent Spirit Award'),
(16, 'Best Ensemble', 'SAG Award'),
(17, 'Britannia Award', 'BAFTA Britannia');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Benutzer`
--

CREATE TABLE `Benutzer` (
  `Benutzer_ID` int NOT NULL,
  `Nutzername` varchar(50) NOT NULL,
  `E_Mail` varchar(100) NOT NULL,
  `Passwort` varchar(255) NOT NULL,
  `Erstellt_am` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Profilbild` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Benutzer`
--

INSERT INTO `Benutzer` (`Benutzer_ID`, `Nutzername`, `E_Mail`, `Passwort`, `Erstellt_am`, `Profilbild`) VALUES
(1, 'fritz', 'fritz@reb', '$2y$10$Mm7.CZiHcs49Rlqu7Qm/Q.M6gJYs63IeWlO6B1hy2/IU1yAR1a4Lq', '2025-12-11 15:51:09', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Benutzer_ist_Freund`
--

CREATE TABLE `Benutzer_ist_Freund` (
  `Benutzer_ID` int NOT NULL,
  `Freund_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Benutzer_mag_Genre`
--

CREATE TABLE `Benutzer_mag_Genre` (
  `Benutzer_ID` int NOT NULL,
  `Genre_ID` int NOT NULL,
  `Punkte` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Benutzer_mag_Genre`
--

INSERT INTO `Benutzer_mag_Genre` (`Benutzer_ID`, `Genre_ID`, `Punkte`) VALUES
(1, 1, NULL),
(1, 3, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Benutzer_mag_Schauspieler`
--

CREATE TABLE `Benutzer_mag_Schauspieler` (
  `Benutzer_ID` int NOT NULL,
  `Schauspieler_ID` int NOT NULL,
  `Punkte` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Benutzer_mag_Schauspieler`
--

INSERT INTO `Benutzer_mag_Schauspieler` (`Benutzer_ID`, `Schauspieler_ID`, `Punkte`) VALUES
(1, 2, NULL),
(1, 6, NULL),
(1, 8, NULL),
(1, 9, NULL),
(1, 12, NULL),
(1, 24, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Benutzer_sieht_Neuigkeit`
--

CREATE TABLE `Benutzer_sieht_Neuigkeit` (
  `Benutzer_ID` int NOT NULL,
  `Neuigkeit_ID` int NOT NULL,
  `Zeitstempel` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Beobachtungsliste`
--

CREATE TABLE `Beobachtungsliste` (
  `Beobachtungsliste_ID` int NOT NULL,
  `Benutzer_ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Erschein_Datum` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Beobachtungsliste`
--

INSERT INTO `Beobachtungsliste` (`Beobachtungsliste_ID`, `Benutzer_ID`, `Name`, `Erschein_Datum`) VALUES
(1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Beobachtungsliste_enthaelt_Film`
--

CREATE TABLE `Beobachtungsliste_enthaelt_Film` (
  `Beobachtungsliste_ID` int NOT NULL,
  `Film_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Beobachtungsliste_enthaelt_Film`
--

INSERT INTO `Beobachtungsliste_enthaelt_Film` (`Beobachtungsliste_ID`, `Film_ID`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Bewertung`
--

CREATE TABLE `Bewertung` (
  `Bewertung_ID` int NOT NULL,
  `Benutzer_ID` int NOT NULL,
  `Film_ID` int NOT NULL,
  `Bewertung` tinyint NOT NULL,
  `Zeitstempel` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Daten für Tabelle `Bewertung`
--

INSERT INTO `Bewertung` (`Bewertung_ID`, `Benutzer_ID`, `Film_ID`, `Bewertung`, `Zeitstempel`) VALUES
(1, 1, 5, 3, '2025-12-12 12:18:50'),
(2, 1, 3, 5, '2025-12-12 10:57:10');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Film`
--

CREATE TABLE `Film` (
  `Film_ID` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Bild` varchar(255) DEFAULT NULL,
  `Beschreibung` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Film`
--

INSERT INTO `Film` (`Film_ID`, `Name`, `Bild`, `Beschreibung`) VALUES
(1, 'Avatar', 'avatar.jpg', 'Ein gelähmter Ex-Marine nimmt auf dem Planeten Pandora am Avatar-Programm teil und gerät in einen Konflikt zwischen Menschen und Na’vi.'),
(2, 'The Dark Knight', 'dark_knight.jpg', 'Batman stellt sich dem Joker, einem anarchistischen Verbrecher, der Gotham ins Chaos stürzen will.'),
(3, 'Der Pate', 'godfather.jpg', 'Das Mafia-Epos über die Corleone-Familie – Macht, Loyalität und der Preis krimineller Entscheidungen.'),
(4, 'Harry Potter und der Stein der Weisen', 'harry_potter_1.jpg', 'Harry entdeckt seine magischen Fähigkeiten und beginnt sein erstes Jahr in Hogwarts.'),
(5, 'Inception', 'inception.jpg', 'Ein Dieb stiehlt Informationen, indem er in die Träume anderer eindringt – eine Mission in immer tieferen Traumebenen.'),
(6, 'Interstellar', 'interstellar.jpg', 'Eine Gruppe Astronauten reist durch ein Wurmloch, um eine neue Heimat für die Menschheit zu finden.'),
(7, 'Jurassic Park', 'jurassic_park.jpg', 'Ein Freizeitpark voller wiederbelebter Dinosaurier wird zur tödlichen Falle, als das Sicherheitssystem versagt.'),
(8, 'The Matrix', 'matrix.jpg', 'Ein Hacker entdeckt, dass seine Realität eine Computersimulation ist und schließt sich Rebellen an.'),
(9, 'Star Wars: Episode IV', 'star_wars_4.jpg', 'Luke Skywalker schließt sich der Rebellion an, um die Galaxis vom Imperium zu befreien.'),
(10, 'Titanic', 'titanic.jpg', 'Eine tragische Liebesgeschichte zwischen Jack und Rose an Bord der RMS Titanic.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Genre`
--

CREATE TABLE `Genre` (
  `Genre_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Beschreibung` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Genre`
--

INSERT INTO `Genre` (`Genre_ID`, `Name`, `Beschreibung`) VALUES
(1, 'Science-Fiction', 'Weltraum, Zukunft und Technologien'),
(2, 'Fantasy', 'Magische Welten und Zauberei'),
(3, 'Action', 'Spannende Action und Abenteuer'),
(4, 'Drama', 'Emotionale, tiefgründige Geschichten');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Genre_hat_Filme`
--

CREATE TABLE `Genre_hat_Filme` (
  `Genre_ID` int NOT NULL,
  `Film_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Genre_hat_Filme`
--

INSERT INTO `Genre_hat_Filme` (`Genre_ID`, `Film_ID`) VALUES
(2, 1),
(3, 2),
(4, 3),
(2, 4),
(3, 5),
(1, 6),
(1, 7),
(1, 8),
(3, 9),
(4, 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Neuigkeit`
--

CREATE TABLE `Neuigkeit` (
  `Neuigkeit_ID` int NOT NULL,
  `Typ` varchar(50) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Erschein_Datum` date DEFAULT NULL,
  `Teaser` varchar(300) DEFAULT NULL,
  `Inhalt` text,
  `Bild` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Neuigkeit`
--

INSERT INTO `Neuigkeit` (`Neuigkeit_ID`, `Typ`, `Name`, `Erschein_Datum`, `Teaser`, `Inhalt`, `Bild`) VALUES
(1, 'Kino', 'Diese Filme starten diese Woche im Kino', '2025-12-12', '„Zootopia 2“ und weitere Kinostarts dieser Woch', 'Berlin / Deutschland – Großes Kinovergnügen in den Kinosälen: Der heiß erwartete Animationsfilm „Zootopia 2“ (deutscher Titel: Zoomania 2) läuft seit Ende November in den Kinos und sorgt weiterhin für volle Säle. Die Fortsetzung des Disney-Hits von 2016 bringt die beliebten Figuren Judy Hopps und Nick Wilde zurück auf die Leinwand, die diesmal einem mysteriösen Reptil auf die Spur kommen und in neue, überraschende Teile der Stadt Zoomania vordringen müssen. Der Film startete am 26. November 2025 und begeistert Familien mit seiner Mischung aus Humor, Spannung und Botschaft über Vielfalt und Zusammenhalt.\r\n\r\nIn der aktuellen Kinowoche stehen aber noch weitere frische Filme auf dem Programm, so wie:\r\n\r\n\"Bibi Blocksberg – Das große Hexentreffen“ Der neue Live-Action-Kinderfilm um die beliebte Hexe startet diese Woche in den deutschen Kinos und verspricht magische Abenteuer für die ganze Familie. \r\n\r\n\r\n„Der Held vom Bahnhof Friedrichstraße“ Ein dramatischer deutscher Film über eine historische Massenflucht aus der DDR, der ebenfalls ab dieser Woche gezeigt wird.', 'zootopia.jpg'),
(2, 'Rekorde', 'Neuer Kino-Rekord: Dieser Film bricht alle Zahlen', '2025-12-12', 'Kino-Sensationen: „Das Kanu des Manitu“ bricht alle Rekorde', 'Mehr als zwei Jahrzehnte nach dem Kultstart von „Der Schuh des Manitu“ hat Regisseur Michael „Bully“ Herbig erneut einen Volltreffer gelandet: Die lang erwartete Fortsetzung „Das Kanu des Manitu“ schreibt derzeit deutsche Kino-Geschichte. \r\n\r\nBereits am Startwochenende strömten Hunderttausende Zuschauer in die Säle – rund 800.000 Kinogänger sahen den Film innerhalb der ersten Tage, ein Rekord, der seit Jahren nicht mehr erreicht wurde.\r\n\r\nUnd auch mehrere Monate nach dem Start hält der Erfolg unerwartet an: über 5 Millionen Tickets wurden allein in Deutschland verkauft, womit der Film nicht nur zum erfolgreichsten deutschen Kinofilm des Jahres geworden ist, sondern auch eine der größten Publikums-Resonanzen der letzten Jahre erzielt hat. \r\n\r\nDer Film vereint dabei bekannte Figuren aus dem Original mit neuen Abenteuern rund um Abahachi und Ranger – und trifft offenbar den Nerv von Jung und Alt gleichermaßen. Besonders bemerkenswert: „Das Kanu des Manitu“ blieb über Wochen in den Kinocharts präsent, kehrte mehrfach an die Spitzenposition zurück und setzte sich gegen internationale Konkurrenz durch.\r\n\r\n„Das Kanu des Manitu“ ist damit nicht nur ein großer kommerzieller Erfolg, sondern auch ein kulturelles Event – und zeigt, dass Klassiker-Humor auch 25 Jahre nach dem Original noch massenhaft Zuschauer in die Kinos lockt. \r\n\r\n', 'schuh-des-manitu.jpg'),
(3, 'Schauspieler', 'Schauspieler verletzt sich bei Dreharbeiten', '2025-12-12', 'Tom Holland verletzt sich am „Spider-Man“-Set – Produktion kurz unterbrochen', 'Los Angeles / London – Hollywood-Star Tom Holland hat sich während der Dreharbeiten zum kommenden Marvel-Blockbuster „Spider-Man: Brand New Day“ verletzt. Der britische Schauspieler, der seit 2016 regelmäßig als Peter Parker alias Spider-Man im Marvel Cinematic Universe (MCU) auftritt, erlitt am 19. September 2025 bei einem Stunt einen Schlag auf den Kopf und eine leichte Gehirnerschütterung, wie mehrere Branchen-Medien berichten. \r\n\r\nDer Vorfall ereignete sich auf dem Set in den Leavesden Studios im Vereinigten Königreich, als Holland eine Actionszene drehte. Sofort wurde er ins Krankenhaus gebracht und aus Vorsicht behandelt, anschließend erholte er sich zu Hause und legte eine mehrtägige Drehpause ein. \r\n\r\nTrotz des Unfalls gibt es positive Nachrichten: Holland postete später auf Instagram, dass es ihm besser gehe und er auf dem Weg der Besserung sei. Außerdem wurde er kurz nach dem Vorfall bei einem Wohltätigkeits-Event seiner Organisation The Brothers Trust mit seiner Verlobten Zendaya und Familienangehörigen gesehen – was bei Fans für Erleichterung sorgte. \r\n\r\nDie Produktion von Spider-Man: Brand New Day musste vorübergehend unterbrochen werden, und die Verantwortlichen berieten, wie der Drehplan angepasst werden kann. Aktuell wird erwartet, dass die Verzögerung keinen Einfluss auf den geplanten Kinostart am 31. Juli 2026 haben wird. \r\n\r\nDer Unfall erinnert daran, wie riskant Stunt-Dreharbeiten trotz sorgfältiger Vorbereitung sein können – auch für erfahrene Schauspieler wie Holland, der für seinen körperlichen Einsatz in Action-Rollen bekannt ist. ', 'tom-holland.jpg'),
(4, 'Verschiebung', 'Filmstart verschoben – Fans müssen warten', '2025-12-12', '„Peaky Blinders“: Verschiebung, Kino-Film und neue Serien-Pläne – Fans müssen Geduld haben', 'London / weltweit – Die britische Kultserie „Peaky Blinders“ sorgt erneut für Gesprächsstoff – diesmal wegen Verzögerungen und einer grundlegenden Neuplanung des Franchise. Ursprünglich lief die BBC-Serie über die kriminellen Shelby-Familie zwischen 2013 und 2022 über sechs Staffeln, die mittlerweile zum Serienklassiker geworden sind. \r\n\r\nVerzögerte Produktion und Serienende:\r\nDie Produktion der finalen sechsten Staffel war bereits mehrfach ins Stocken geraten, insbesondere wegen der Corona-Pandemie, die Dreharbeiten und Zeitpläne durcheinanderbrachte und zu Verzögerungen führte. \r\n\r\nUrsprünglich war sogar eine Fortsetzung der Serie über Staffel 6 hinaus geplant, doch man entschied sich schließlich, die klassische TV-Serie damit enden zu lassen und neue Wege zu gehen.\r\n\r\nNeuer Kinofilm statt siebter Staffel:\r\nAnstelle einer siebten TV-Staffel entsteht nun ein „Peaky Blinders“-Kinofilm mit dem Titel Peaky Blinders: The Immortal Man. Der Film soll am 6. März 2026 im Kino starten und am 20. März 2026 auf Netflix erscheinen. Die Geschichte setzt den beliebten Charakter Tommy Shelby (gespielt von Cillian Murphy) im Jahr 1940 während des Zweiten Weltkriegs fort, nachdem er sich aus dem Exil zurückmeldet, um dramatische neue Herausforderungen zu meistern. \r\n\r\nFortsetzung trotz Verschiebung:\r\nFans, die über das Filmprojekt hinaus mehr „Peaky Blinders“ sehen wollen, können aufatmen: Netflix und die BBC haben zwei neue Staffeln einer Fortsetzungs-Serie offiziell in Auftrag gegeben, die nach dem Film im Jahr 1953 spielen und eine neue Generation der Shelby-Familie ins Zentrum rücken werden. Diese Pläne bedeuten, dass das „Peaky Blinders“-Universum trotz der Serien-Verschiebungen und des langen Wartens weiterhin weiterlebt – nur in anderer Form als früher geplant.', 'peaky-blinders.jpg'),
(5, 'Awards', 'Große Erfolge bei der Preisverleihung.', '2025-12-12', '„One Battle After Another“ gewinnt bei den Gotham Awards – starker Saisonauftakt für Oscars', 'New York – Der hochgelobte Politthriller „One Battle After Another“ von Regisseur Paul Thomas Anderson hat bei den diesjährigen 35. Gotham Film Awards die wichtigste Auszeichnung des Abends gewonnen: den Preis als bester Film des Jahres. Die Gala gilt als traditioneller Auftakt der Awards-Saison und vielversprechender Wegweiser für kommende Preisverleihungen wie die Oscars. \r\n\r\nIn der mit international besetz­ten Hauptrolle ist Leonardo DiCaprio zu sehen, der einen Ex-Revolutionär und Familienvater spielt und dabei im Mittelpunkt der packenden Geschichte steht. Dass der Film nun bei den Gotham Awards als Best Feature ausgezeichnet wurde, macht ihn zu einem der größten Favoriten im bevorstehenden Oscar-Rennen. \r\n\r\nNeben dem Erfolg bei den Gotham Awards hat „One Battle After Another“ auch bei anderen wichtigen Kritikergruppen überzeugt: Der Film wurde etwa von der New York Film Critics Circle als bester Film des Jahres gefeiert und dominiert außerdem weitere Kritikerpreise.', 'onebattle.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Neuigkeit_sieht_man_Auszeichnung`
--

CREATE TABLE `Neuigkeit_sieht_man_Auszeichnung` (
  `Neuigkeit_ID` int NOT NULL,
  `Auszeichnung_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Schauspieler`
--

CREATE TABLE `Schauspieler` (
  `Schauspieler_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Geschlecht` enum('m','w','d') DEFAULT NULL,
  `Geb_Datum` date DEFAULT NULL,
  `Lebenslauf` text,
  `Bild` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Schauspieler`
--

INSERT INTO `Schauspieler` (`Schauspieler_ID`, `Name`, `Geschlecht`, `Geb_Datum`, `Lebenslauf`, `Bild`) VALUES
(1, 'Leonardo DiCaprio', 'm', '1974-11-11', 'Leonardo DiCaprio ist ein US-amerikanischer Schauspieler, bekannt aus Filmen wie Inception, Titanic und The Wolf of Wall Street.', 'leonardo_dicaprio.jpg'),
(2, 'Joseph Gordon-Levitt', 'm', '1981-02-17', 'Joseph Gordon-Levitt ist ein vielseitiger US-Schauspieler und Regisseur, bekannt aus Inception und 500 Days of Summer.', 'joseph_gordon_levitt.jpg'),
(3, 'Elliot Page', 'd', '1987-02-21', 'Elliot Page ist ein kanadischer Schauspieler, bekannt aus Inception, Juno und The Umbrella Academy.', 'elliot_page.jpg'),
(4, 'Matthew McConaughey', 'm', '1969-11-04', 'Matthew McConaughey ist ein Oscar-prämierter Schauspieler, bekannt aus Interstellar und Dallas Buyers Club.', 'matthew_mcconaughey.jpg'),
(5, 'Anne Hathaway', 'w', '1982-11-12', 'Anne Hathaway ist eine US-amerikanische Schauspielerin und Oscar-Preisträgerin.', 'anne_hathaway.jpg'),
(6, 'Jessica Chastain', 'w', '1977-03-24', 'Jessica Chastain ist eine US-amerikanische Schauspielerin, bekannt für starke Hauptrollen.', 'jessica_chastain.jpg'),
(7, 'Christian Bale', 'm', '1974-01-30', 'Christian Bale ist ein britischer Schauspieler, berühmt für seine intensiven Rollen.', 'christian_bale.jpg'),
(8, 'Heath Ledger', 'm', '1979-04-04', 'Heath Ledger war ein australischer Schauspieler, berühmt für seine Rolle als Joker.', 'heath_ledger.jpg'),
(9, 'Aaron Eckhart', 'm', '1968-03-12', 'Aaron Eckhart ist ein US-amerikanischer Schauspieler, bekannt aus The Dark Knight.', 'aaron_eckhart.jpg'),
(10, 'Sam Worthington', 'm', '1976-08-02', 'Sam Worthington ist ein australischer Schauspieler, bekannt aus Avatar.', 'sam_worthington.jpg'),
(11, 'Zoe Saldana', 'w', '1978-06-19', 'Zoe Saldana ist eine US-amerikanische Schauspielerin, bekannt aus Avatar und Guardians of the Galaxy.', 'zoe_saldana.jpg'),
(12, 'Sigourney Weaver', 'w', '1949-10-08', 'Sigourney Weaver ist eine US-amerikanische Schauspielerin und Science-Fiction-Ikone.', 'sigourney_weaver.jpg'),
(13, 'Keanu Reeves', 'm', '1964-09-02', 'Keanu Reeves ist ein kanadischer Schauspieler, bekannt aus The Matrix.', 'keanu_reeves.jpg'),
(14, 'Laurence Fishburne', 'm', '1961-07-30', 'Laurence Fishburne ist ein US-amerikanischer Schauspieler, bekannt aus Matrix und John Wick.', 'laurence_fishburne.jpg'),
(15, 'Carrie-Anne Moss', 'w', '1967-08-21', 'Carrie-Anne Moss ist eine kanadische Schauspielerin, bekannt aus The Matrix.', 'carrie_anne_moss.jpg'),
(16, 'Kate Winslet', 'w', '1975-10-05', 'Kate Winslet ist eine britische Schauspielerin und Oscar-Preisträgerin.', 'kate_winslet.jpg'),
(17, 'Billy Zane', 'm', '1966-02-23', 'Billy Zane ist ein US-amerikanischer Schauspieler, bekannt aus Titanic.', 'billy_zane.jpg'),
(18, 'Sam Neill', 'm', '1947-09-14', 'Sam Neill ist ein neuseeländischer Schauspieler, bekannt aus Jurassic Park.', 'sam_neill.jpg'),
(19, 'Laura Dern', 'w', '1967-02-10', 'Laura Dern ist eine US-amerikanische Schauspielerin und Oscar-Preisträgerin.', 'laura_dern.jpg'),
(20, 'Jeff Goldblum', 'm', '1952-10-22', 'Jeff Goldblum ist ein US-amerikanischer Schauspieler mit markantem Stil.', 'jeff_goldblum.jpg'),
(21, 'Mark Hamill', 'm', '1951-09-25', 'Mark Hamill ist ein US-amerikanischer Schauspieler, bekannt als Luke Skywalker.', 'mark_hamill.jpg'),
(22, 'Harrison Ford', 'm', '1942-07-13', 'Harrison Ford ist ein legendärer US-amerikanischer Schauspieler.', 'harrison_ford.jpg'),
(23, 'Carrie Fisher', 'w', '1956-10-21', 'Carrie Fisher war eine US-amerikanische Schauspielerin und Autorin.', 'carrie_fisher.jpg'),
(24, 'Marlon Brando', 'm', '1924-04-03', 'Marlon Brando war ein einflussreicher US-amerikanischer Schauspieler.', 'marlon_brando.jpg'),
(25, 'Al Pacino', 'm', '1940-04-25', 'Al Pacino ist ein US-amerikanischer Schauspieler und Oscar-Preisträger.', 'al_pacino.jpg'),
(26, 'James Caan', 'm', '1940-03-26', 'James Caan war ein US-amerikanischer Schauspieler, bekannt aus Der Pate.', 'james_caan.jpg'),
(27, 'Daniel Radcliffe', 'm', '1989-07-23', 'Daniel Radcliffe ist ein britischer Schauspieler, bekannt als Harry Potter.', 'daniel_radcliffe.jpg'),
(28, 'Emma Watson', 'w', '1990-04-15', 'Emma Watson ist eine britische Schauspielerin und Aktivistin.', 'emma_watson.jpg'),
(29, 'Rupert Grint', 'm', '1988-08-24', 'Rupert Grint ist ein britischer Schauspieler, bekannt aus Harry Potter.', 'rupert_grint.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Schauspieler_hat_Auszeichnung`
--

CREATE TABLE `Schauspieler_hat_Auszeichnung` (
  `Schauspieler_ID` int NOT NULL,
  `Auszeichnung_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Schauspieler_hat_Auszeichnung`
--

INSERT INTO `Schauspieler_hat_Auszeichnung` (`Schauspieler_ID`, `Auszeichnung_ID`) VALUES
(1, 1),
(4, 1),
(24, 1),
(25, 1),
(3, 2),
(6, 2),
(16, 2),
(7, 3),
(8, 3),
(5, 4),
(19, 4),
(2, 5),
(9, 5),
(26, 5),
(12, 6),
(18, 7),
(21, 7),
(14, 8),
(10, 9),
(20, 9),
(11, 10),
(13, 11),
(29, 11),
(27, 12),
(22, 13),
(23, 14),
(15, 15),
(17, 16),
(28, 17);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Schauspieler_spielt_in_Film`
--

CREATE TABLE `Schauspieler_spielt_in_Film` (
  `Schauspieler_ID` int NOT NULL,
  `Film_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `Schauspieler_spielt_in_Film`
--

INSERT INTO `Schauspieler_spielt_in_Film` (`Schauspieler_ID`, `Film_ID`) VALUES
(10, 1),
(11, 1),
(12, 1),
(7, 2),
(8, 2),
(9, 2),
(24, 3),
(25, 3),
(26, 3),
(27, 4),
(28, 4),
(29, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 6),
(5, 6),
(6, 6),
(18, 7),
(19, 7),
(20, 7),
(13, 8),
(14, 8),
(15, 8),
(21, 9),
(22, 9),
(23, 9),
(1, 10),
(16, 10),
(17, 10);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `Auszeichnung`
--
ALTER TABLE `Auszeichnung`
  ADD PRIMARY KEY (`Auszeichnung_ID`);

--
-- Indizes für die Tabelle `Benutzer`
--
ALTER TABLE `Benutzer`
  ADD PRIMARY KEY (`Benutzer_ID`),
  ADD UNIQUE KEY `Nutzername` (`Nutzername`),
  ADD UNIQUE KEY `E_Mail` (`E_Mail`);

--
-- Indizes für die Tabelle `Benutzer_ist_Freund`
--
ALTER TABLE `Benutzer_ist_Freund`
  ADD PRIMARY KEY (`Benutzer_ID`,`Freund_ID`),
  ADD KEY `fk_freund_friend` (`Freund_ID`);

--
-- Indizes für die Tabelle `Benutzer_mag_Genre`
--
ALTER TABLE `Benutzer_mag_Genre`
  ADD PRIMARY KEY (`Benutzer_ID`,`Genre_ID`),
  ADD KEY `fk_mag_genre_genre` (`Genre_ID`);

--
-- Indizes für die Tabelle `Benutzer_mag_Schauspieler`
--
ALTER TABLE `Benutzer_mag_Schauspieler`
  ADD PRIMARY KEY (`Benutzer_ID`,`Schauspieler_ID`),
  ADD KEY `fk_mag_schauspieler_schauspieler` (`Schauspieler_ID`);

--
-- Indizes für die Tabelle `Benutzer_sieht_Neuigkeit`
--
ALTER TABLE `Benutzer_sieht_Neuigkeit`
  ADD PRIMARY KEY (`Benutzer_ID`,`Neuigkeit_ID`),
  ADD KEY `fk_sieht_neuigkeit` (`Neuigkeit_ID`);

--
-- Indizes für die Tabelle `Beobachtungsliste`
--
ALTER TABLE `Beobachtungsliste`
  ADD PRIMARY KEY (`Beobachtungsliste_ID`),
  ADD KEY `fk_beobachtungsliste_benutzer` (`Benutzer_ID`);

--
-- Indizes für die Tabelle `Beobachtungsliste_enthaelt_Film`
--
ALTER TABLE `Beobachtungsliste_enthaelt_Film`
  ADD PRIMARY KEY (`Beobachtungsliste_ID`,`Film_ID`),
  ADD KEY `fk_bl_film_film` (`Film_ID`);

--
-- Indizes für die Tabelle `Bewertung`
--
ALTER TABLE `Bewertung`
  ADD PRIMARY KEY (`Bewertung_ID`),
  ADD KEY `fk_bewertung_benutzer` (`Benutzer_ID`),
  ADD KEY `fk_bewertung_film` (`Film_ID`);

--
-- Indizes für die Tabelle `Film`
--
ALTER TABLE `Film`
  ADD PRIMARY KEY (`Film_ID`);

--
-- Indizes für die Tabelle `Genre`
--
ALTER TABLE `Genre`
  ADD PRIMARY KEY (`Genre_ID`);

--
-- Indizes für die Tabelle `Genre_hat_Filme`
--
ALTER TABLE `Genre_hat_Filme`
  ADD PRIMARY KEY (`Genre_ID`,`Film_ID`),
  ADD KEY `fk_genre_hat_film` (`Film_ID`);

--
-- Indizes für die Tabelle `Neuigkeit`
--
ALTER TABLE `Neuigkeit`
  ADD PRIMARY KEY (`Neuigkeit_ID`);

--
-- Indizes für die Tabelle `Neuigkeit_sieht_man_Auszeichnung`
--
ALTER TABLE `Neuigkeit_sieht_man_Auszeichnung`
  ADD PRIMARY KEY (`Neuigkeit_ID`,`Auszeichnung_ID`),
  ADD KEY `fk_news_award_auszeichnung` (`Auszeichnung_ID`);

--
-- Indizes für die Tabelle `Schauspieler`
--
ALTER TABLE `Schauspieler`
  ADD PRIMARY KEY (`Schauspieler_ID`);

--
-- Indizes für die Tabelle `Schauspieler_hat_Auszeichnung`
--
ALTER TABLE `Schauspieler_hat_Auszeichnung`
  ADD PRIMARY KEY (`Schauspieler_ID`,`Auszeichnung_ID`),
  ADD KEY `fk_schauspieler_auszeichnung_auszeichnung` (`Auszeichnung_ID`);

--
-- Indizes für die Tabelle `Schauspieler_spielt_in_Film`
--
ALTER TABLE `Schauspieler_spielt_in_Film`
  ADD PRIMARY KEY (`Schauspieler_ID`,`Film_ID`),
  ADD KEY `fk_spielt_film` (`Film_ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `Auszeichnung`
--
ALTER TABLE `Auszeichnung`
  MODIFY `Auszeichnung_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `Benutzer`
--
ALTER TABLE `Benutzer`
  MODIFY `Benutzer_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `Beobachtungsliste`
--
ALTER TABLE `Beobachtungsliste`
  MODIFY `Beobachtungsliste_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `Bewertung`
--
ALTER TABLE `Bewertung`
  MODIFY `Bewertung_ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Film`
--
ALTER TABLE `Film`
  MODIFY `Film_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `Genre`
--
ALTER TABLE `Genre`
  MODIFY `Genre_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `Neuigkeit`
--
ALTER TABLE `Neuigkeit`
  MODIFY `Neuigkeit_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `Schauspieler`
--
ALTER TABLE `Schauspieler`
  MODIFY `Schauspieler_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `Benutzer_ist_Freund`
--
ALTER TABLE `Benutzer_ist_Freund`
  ADD CONSTRAINT `fk_freund_friend` FOREIGN KEY (`Freund_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_freund_user` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Benutzer_mag_Genre`
--
ALTER TABLE `Benutzer_mag_Genre`
  ADD CONSTRAINT `fk_mag_genre_genre` FOREIGN KEY (`Genre_ID`) REFERENCES `Genre` (`Genre_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mag_genre_user` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Benutzer_mag_Schauspieler`
--
ALTER TABLE `Benutzer_mag_Schauspieler`
  ADD CONSTRAINT `fk_mag_schauspieler_schauspieler` FOREIGN KEY (`Schauspieler_ID`) REFERENCES `Schauspieler` (`Schauspieler_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mag_schauspieler_user` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Benutzer_sieht_Neuigkeit`
--
ALTER TABLE `Benutzer_sieht_Neuigkeit`
  ADD CONSTRAINT `fk_sieht_neuigkeit` FOREIGN KEY (`Neuigkeit_ID`) REFERENCES `Neuigkeit` (`Neuigkeit_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sieht_user` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Beobachtungsliste`
--
ALTER TABLE `Beobachtungsliste`
  ADD CONSTRAINT `fk_beobachtungsliste_benutzer` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Beobachtungsliste_enthaelt_Film`
--
ALTER TABLE `Beobachtungsliste_enthaelt_Film`
  ADD CONSTRAINT `fk_bl_film_bl` FOREIGN KEY (`Beobachtungsliste_ID`) REFERENCES `Beobachtungsliste` (`Beobachtungsliste_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_bl_film_film` FOREIGN KEY (`Film_ID`) REFERENCES `Film` (`Film_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Bewertung`
--
ALTER TABLE `Bewertung`
  ADD CONSTRAINT `fk_bewertung_benutzer` FOREIGN KEY (`Benutzer_ID`) REFERENCES `Benutzer` (`Benutzer_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_bewertung_film` FOREIGN KEY (`Film_ID`) REFERENCES `Film` (`Film_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Genre_hat_Filme`
--
ALTER TABLE `Genre_hat_Filme`
  ADD CONSTRAINT `fk_genre_hat_film` FOREIGN KEY (`Film_ID`) REFERENCES `Film` (`Film_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_genre_hat_genre` FOREIGN KEY (`Genre_ID`) REFERENCES `Genre` (`Genre_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Neuigkeit_sieht_man_Auszeichnung`
--
ALTER TABLE `Neuigkeit_sieht_man_Auszeichnung`
  ADD CONSTRAINT `fk_news_award_auszeichnung` FOREIGN KEY (`Auszeichnung_ID`) REFERENCES `Auszeichnung` (`Auszeichnung_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_news_award_news` FOREIGN KEY (`Neuigkeit_ID`) REFERENCES `Neuigkeit` (`Neuigkeit_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Schauspieler_hat_Auszeichnung`
--
ALTER TABLE `Schauspieler_hat_Auszeichnung`
  ADD CONSTRAINT `fk_schauspieler_auszeichnung_auszeichnung` FOREIGN KEY (`Auszeichnung_ID`) REFERENCES `Auszeichnung` (`Auszeichnung_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_schauspieler_auszeichnung_schauspieler` FOREIGN KEY (`Schauspieler_ID`) REFERENCES `Schauspieler` (`Schauspieler_ID`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Schauspieler_spielt_in_Film`
--
ALTER TABLE `Schauspieler_spielt_in_Film`
  ADD CONSTRAINT `fk_spielt_film` FOREIGN KEY (`Film_ID`) REFERENCES `Film` (`Film_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_spielt_schauspieler` FOREIGN KEY (`Schauspieler_ID`) REFERENCES `Schauspieler` (`Schauspieler_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
