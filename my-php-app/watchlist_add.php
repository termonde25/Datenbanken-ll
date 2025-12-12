<?php
session_start();
require_once 'db.php';

// Antwort wird nur Text, kein HTML
header('Content-Type: text/plain; charset=utf-8');

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo "Nicht eingeloggt";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo "Nur POST erlaubt";
    exit;
}

$film_id = isset($_POST['film_id']) ? (int)$_POST['film_id'] : 0;
if ($film_id <= 0) {
    http_response_code(400);
    echo "Ungültige Film-ID";
    exit;
}

$user_id = $_SESSION['user_id'];

// Watchlist-ID des Benutzers holen
$stmt = $pdo->prepare("
    SELECT Beobachtungsliste_ID 
    FROM Beobachtungsliste 
    WHERE Benutzer_ID = :uid
");
$stmt->execute(['uid' => $user_id]);
$wl = $stmt->fetch(PDO::FETCH_ASSOC);

// Falls noch keine Watchlist existiert: anlegen
if (!$wl) {
    $insert = $pdo->prepare("
        INSERT INTO Beobachtungsliste (Benutzer_ID) 
        VALUES (:uid)
    ");
    $insert->execute(['uid' => $user_id]);

    $stmt = $pdo->prepare("
        SELECT Beobachtungsliste_ID 
        FROM Beobachtungsliste 
        WHERE Benutzer_ID = :uid
    ");
    $stmt->execute(['uid' => $user_id]);
    $wl = $stmt->fetch(PDO::FETCH_ASSOC);
}

if (!$wl) {
    http_response_code(500);
    echo "Watchlist konnte nicht erstellt werden";
    exit;
}

$watchlist_id = (int)$wl['Beobachtungsliste_ID'];

// Film in die Watchlist eintragen (falls noch nicht vorhanden)
$stmt = $pdo->prepare("
    INSERT IGNORE INTO Beobachtungsliste_enthaelt_Film (Beobachtungsliste_ID, Film_ID)
    VALUES (:wlid, :fid)
");
$stmt->execute([
    'wlid' => $watchlist_id,
    'fid'  => $film_id
]);

echo "OK";
exit;
