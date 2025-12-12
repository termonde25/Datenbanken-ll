<?php
session_start();
require_once 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header("Location: index.php");
    exit;
}

$film_id = isset($_POST['film_id']) ? (int)$_POST['film_id'] : 0;
$rating  = isset($_POST['rating']) ? (int)$_POST['rating'] : 0;

if ($film_id <= 0 || $rating < 1 || $rating > 5) {
    header("Location: movie.php?id=" . $film_id);
    exit;
}

$user_id = $_SESSION['user_id'];

// Prüfen, ob der Benutzer diesen Film schon bewertet hat
$stmt = $pdo->prepare("
    SELECT * FROM Bewertung
    WHERE Benutzer_ID = :uid AND Film_ID = :fid
");
$stmt->execute([
    'uid' => $user_id,
    'fid' => $film_id
]);
$existing = $stmt->fetch(PDO::FETCH_ASSOC);

if ($existing) {
    // Vorhandene Bewertung updaten
    $stmt = $pdo->prepare("
        UPDATE Bewertung
        SET Bewertung = :rating, Zeitstempel = NOW()
        WHERE Benutzer_ID = :uid AND Film_ID = :fid
    ");
    $stmt->execute([
        'rating' => $rating,
        'uid'    => $user_id,
        'fid'    => $film_id
    ]);
} else {
    // Neue Bewertung einfügen
    $stmt = $pdo->prepare("
        INSERT INTO Bewertung (Benutzer_ID, Film_ID, Bewertung, Zeitstempel)
        VALUES (:uid, :fid, :rating, NOW())
    ");
    $stmt->execute([
        'uid'    => $user_id,
        'fid'    => $film_id,
        'rating' => $rating
    ]);
}

// Zurück zur Filmseite
header("Location: movie.php?id=" . $film_id);
exit;
