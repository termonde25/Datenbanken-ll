<?php
require_once 'db.php';
session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

$film_id = (int)$_POST['film_id'];
$user_id = $_SESSION['user_id'];

// Watchlist-ID holen
$stmt = $pdo->prepare("SELECT Beobachtungsliste_ID FROM Beobachtungsliste WHERE Benutzer_ID = :uid");
$stmt->execute(['uid' => $user_id]);
$wl = $stmt->fetch();
$watchlist_id = $wl['Beobachtungsliste_ID'];

// Entfernen
$stmt = $pdo->prepare("
    DELETE FROM Beobachtungsliste_enthaelt_Film
    WHERE Beobachtungsliste_ID = :wlid AND Film_ID = :fid
");
$stmt->execute([
    'wlid' => $watchlist_id,
    'fid'  => $film_id
]);

header("Location: watchlist.php");
exit;
