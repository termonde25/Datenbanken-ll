-- Datenbank anlegen
CREATE DATABASE IF NOT EXISTS streammatch
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE streammatch;

-- ===================
-- Entität: Benutzer
-- ===================
CREATE TABLE Benutzer (
    Benutzer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nutzername   VARCHAR(50)  NOT NULL UNIQUE,
    E_Mail       VARCHAR(100) NOT NULL UNIQUE,
    Passwort     VARCHAR(255) NOT NULL,    -- Passwort-Hash
    Erstellt_am  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    Profilbild   VARCHAR(255) NULL         -- z.B. URL oder Dateiname
) ENGINE=InnoDB;

-- ===================
-- Entität: Schauspieler
-- ===================
CREATE TABLE Schauspieler (
    Schauspieler_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Geschlecht  ENUM('m','w','d') NULL,
    Geb_Datum   DATE NULL
) ENGINE=InnoDB;

-- ===================
-- Entität: Film
-- ===================
CREATE TABLE Film (
    Film_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(255) NOT NULL,
    Bild        VARCHAR(255) NULL,       -- Poster / Bildpfad
    Beschreibung TEXT NULL
) ENGINE=InnoDB;

-- ===================
-- Entität: Genre
-- ===================
CREATE TABLE Genre (
    Genre_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Beschreibung TEXT NULL
) ENGINE=InnoDB;

-- ===================
-- Entität: Neuigkeit
-- ===================
CREATE TABLE Neuigkeit (
    Neuigkeit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Typ            VARCHAR(50)  NULL,
    Name           VARCHAR(255) NOT NULL,
    Erschein_Datum DATE NULL
) ENGINE=InnoDB;

-- ===================
-- Entität: Auszeichnung
-- ===================
CREATE TABLE Auszeichnung (
    Auszeichnung_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name      VARCHAR(255) NOT NULL,
    Preistyp  VARCHAR(100) NULL
) ENGINE=InnoDB;

-- ===================
-- Entität: Beobachtungsliste
-- ===================
CREATE TABLE Beobachtungsliste (
    Beobachtungsliste_ID INT AUTO_INCREMENT PRIMARY KEY,
    Benutzer_ID   INT NOT NULL,
    Name          VARCHAR(255) NOT NULL,
    Erschein_Datum DATE NULL,
    CONSTRAINT fk_beobachtungsliste_benutzer
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Entität: Bewertung (1–5 Sterne)
-- ===================
CREATE TABLE Bewertung (
    Bewertung_ID INT AUTO_INCREMENT PRIMARY KEY,
    Benutzer_ID INT NOT NULL,
    Film_ID     INT NOT NULL,
    Bewertung   TINYINT NOT NULL CHECK (Bewertung BETWEEN 1 AND 5),
    Zeitstempel TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bewertung_benutzer
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_bewertung_film
        FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Benutzer_ist_Freund
-- ===================
CREATE TABLE Benutzer_ist_Freund (
    Benutzer_ID INT NOT NULL,
    Freund_ID   INT NOT NULL,
    PRIMARY KEY (Benutzer_ID, Freund_ID),
    CONSTRAINT fk_freund_user
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_freund_friend
        FOREIGN KEY (Freund_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Benutzer_sieht_Neuigkeit
-- ===================
CREATE TABLE Benutzer_sieht_Neuigkeit (
    Benutzer_ID  INT NOT NULL,
    Neuigkeit_ID INT NOT NULL,
    Zeitstempel  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Benutzer_ID, Neuigkeit_ID),
    CONSTRAINT fk_sieht_user
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_sieht_neuigkeit
        FOREIGN KEY (Neuigkeit_ID) REFERENCES Neuigkeit(Neuigkeit_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Benutzer_mag_Genre
-- ===================
CREATE TABLE Benutzer_mag_Genre (
    Benutzer_ID INT NOT NULL,
    Genre_ID    INT NOT NULL,
    Punkte      TINYINT NULL,
    PRIMARY KEY (Benutzer_ID, Genre_ID),
    CONSTRAINT fk_mag_genre_user
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_mag_genre_genre
        FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Benutzer_mag_Schauspieler
-- ===================
CREATE TABLE Benutzer_mag_Schauspieler (
    Benutzer_ID     INT NOT NULL,
    Schauspieler_ID INT NOT NULL,
    Punkte          TINYINT NULL,
    PRIMARY KEY (Benutzer_ID, Schauspieler_ID),
    CONSTRAINT fk_mag_schauspieler_user
        FOREIGN KEY (Benutzer_ID) REFERENCES Benutzer(Benutzer_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_mag_schauspieler_schauspieler
        FOREIGN KEY (Schauspieler_ID) REFERENCES Schauspieler(Schauspieler_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Schauspieler_spielt_in_Film
-- ===================
CREATE TABLE Schauspieler_spielt_in_Film (
    Schauspieler_ID INT NOT NULL,
    Film_ID         INT NOT NULL,
    PRIMARY KEY (Schauspieler_ID, Film_ID),
    CONSTRAINT fk_spielt_schauspieler
        FOREIGN KEY (Schauspieler_ID) REFERENCES Schauspieler(Schauspieler_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_spielt_film
        FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Genre_hat_Filme
-- ===================
CREATE TABLE Genre_hat_Filme (
    Genre_ID INT NOT NULL,
    Film_ID  INT NOT NULL,
    PRIMARY KEY (Genre_ID, Film_ID),
    CONSTRAINT fk_genre_hat_genre
        FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_genre_hat_film
        FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Beobachtungsliste_enthält_Film
-- ===================
CREATE TABLE Beobachtungsliste_enthaelt_Film (
    Beobachtungsliste_ID INT NOT NULL,
    Film_ID              INT NOT NULL,
    PRIMARY KEY (Beobachtungsliste_ID, Film_ID),
    CONSTRAINT fk_bl_film_bl
        FOREIGN KEY (Beobachtungsliste_ID) REFERENCES Beobachtungsliste(Beobachtungsliste_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_bl_film_film
        FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- ===================
-- Beziehung: Schauspieler_hat_Auszeichnung
-- ===================
CREATE TABLE Schauspieler_hat_Auszeichnung (
    Schauspieler_ID INT NOT NULL,
    Auszeichnung_ID INT NOT NULL,
    PRIMARY KEY (Schauspieler_ID, Auszeichnung_ID),
    CONSTRAINT fk_schauspieler_auszeichnung_schauspieler
        FOREIGN KEY (Schauspieler_ID) REFERENCES Schauspieler(Schauspieler_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_schauspieler_auszeichnung_auszeichnung
        FOREIGN KEY (Auszeichnung_ID) REFERENCES Auszeichnung(Auszeichnung_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================
-- Beziehung: Neuigkeit_sieht_man_Auszeichnung
-- ===================
CREATE TABLE Neuigkeit_sieht_man_Auszeichnung (
    Neuigkeit_ID    INT NOT NULL,
    Auszeichnung_ID INT NOT NULL,
    PRIMARY KEY (Neuigkeit_ID, Auszeichnung_ID),
    CONSTRAINT fk_news_award_news
        FOREIGN KEY (Neuigkeit_ID) REFERENCES Neuigkeit(Neuigkeit_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_news_award_auszeichnung
        FOREIGN KEY (Auszeichnung_ID) REFERENCES Auszeichnung(Auszeichnung_ID)
        ON DELETE CASCADE
) ENGINE=InnoDB;
