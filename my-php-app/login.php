<?php
session_start();
require_once 'db.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $login = trim($_POST['login'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($login === '' || $password === '') {
        $error = 'Bitte alle Felder ausfüllen.';
    } else {
        $stmt = $pdo->prepare("
            SELECT * FROM Benutzer
            WHERE Nutzername = :login OR E_Mail = :login
            LIMIT 1
        ");
        $stmt->execute(['login' => $login]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['Passwort'])) {
            // Benutzer in Session speichern
            $_SESSION['user_id'] = $user['Benutzer_ID'];
            $_SESSION['username'] = $user['Nutzername'];

            // Watchlist des Benutzers prüfen / erstellen
            $stmtW = $pdo->prepare("SELECT * FROM Beobachtungsliste WHERE Benutzer_ID = :uid");
            $stmtW->execute(['uid' => $user['Benutzer_ID']]);
            $wl = $stmtW->fetch();

            if (!$wl) {
                // Watchlist anlegen
                $pdo->prepare("
                    INSERT INTO Beobachtungsliste (Benutzer_ID) 
                    VALUES (:uid)
                ")->execute(['uid' => $user['Benutzer_ID']]);
            }

            // Zur Startseite
            header("Location: index.php");
            exit;
        } else {
            $error = 'Login fehlgeschlagen.';
        }
    }
}

require 'partials/header.php';
require 'pages/login.php';
require 'partials/footer.php';
