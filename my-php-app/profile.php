<?php
require 'db.php';
include 'partials/header.php';

if (!isset($_SESSION['user_id'])) {
    echo "<main class='hero'><h1>Bitte einloggen</h1><p><a href='login.php'>Zum Login</a></p></main>";
    include 'partials/footer.php';
    exit;
}

$uid = (int)$_SESSION['user_id'];

/* Alle Schauspieler + Genres laden */
$actors = $pdo->query("SELECT Schauspieler_ID, Name FROM Schauspieler ORDER BY Name ASC")->fetchAll(PDO::FETCH_ASSOC);
$genres = $pdo->query("SELECT Genre_ID, Name FROM Genre ORDER BY Name ASC")->fetchAll(PDO::FETCH_ASSOC);

/* Aktuelle Favoriten laden */
$favActorsStmt = $pdo->prepare("SELECT Schauspieler_ID FROM Benutzer_mag_Schauspieler WHERE Benutzer_ID = :uid");
$favActorsStmt->execute(['uid' => $uid]);
$favActors = array_map('intval', array_column($favActorsStmt->fetchAll(PDO::FETCH_ASSOC), 'Schauspieler_ID'));

$favGenresStmt = $pdo->prepare("SELECT Genre_ID FROM Benutzer_mag_Genre WHERE Benutzer_ID = :uid");
$favGenresStmt->execute(['uid' => $uid]);
$favGenres = array_map('intval', array_column($favGenresStmt->fetchAll(PDO::FETCH_ASSOC), 'Genre_ID'));

$message = "";

/* Speichern */
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $selectedActors = isset($_POST['actors']) ? array_map('intval', $_POST['actors']) : [];
    $selectedGenres = isset($_POST['genres']) ? array_map('intval', $_POST['genres']) : [];

    // Alles löschen und neu setzen (einfach + korrekt)
    $pdo->prepare("DELETE FROM Benutzer_mag_Schauspieler WHERE Benutzer_ID = :uid")->execute(['uid' => $uid]);
    $pdo->prepare("DELETE FROM Benutzer_mag_Genre WHERE Benutzer_ID = :uid")->execute(['uid' => $uid]);

    if (!empty($selectedActors)) {
        $ins = $pdo->prepare("INSERT INTO Benutzer_mag_Schauspieler (Benutzer_ID, Schauspieler_ID) VALUES (:uid, :aid)");
        foreach ($selectedActors as $aid) {
            $ins->execute(['uid' => $uid, 'aid' => $aid]);
        }
    }

    if (!empty($selectedGenres)) {
        $ins = $pdo->prepare("INSERT INTO Benutzer_mag_Genre (Benutzer_ID, Genre_ID) VALUES (:uid, :gid)");
        foreach ($selectedGenres as $gid) {
            $ins->execute(['uid' => $uid, 'gid' => $gid]);
        }
    }

    $favActors = $selectedActors;
    $favGenres = $selectedGenres;
    $message = "✅ Profil gespeichert! Deine Startseite ist jetzt personalisiert.";
}
?>

<main class="profile-page">
    <h1>Profil</h1>

    <?php if ($message): ?>
        <p class="profile-success"><?= htmlspecialchars($message) ?></p>
    <?php endif; ?>

    <form method="post" class="profile-form">

      <div class="profile-block">
    <h2>Deine Favoriten</h2>

    <!-- Dropdown: Schauspieler -->
    <details class="profile-dropdown">
        <summary class="profile-dropdown-title">Lieblings-Schauspieler auswählen</summary>
        <div class="profile-grid profile-dropdown-content">
            <?php foreach ($actors as $a): ?>
                <label class="profile-item">
                    <input type="checkbox" name="actors[]"
                           value="<?= (int)$a['Schauspieler_ID'] ?>"
                           <?= in_array((int)$a['Schauspieler_ID'], $favActors, true) ? 'checked' : '' ?>>
                    <span><?= htmlspecialchars($a['Name']) ?></span>
                </label>
            <?php endforeach; ?>
        </div>
    </details>

    <!-- Dropdown: Genres -->
    <details class="profile-dropdown" style="margin-top:14px;">
        <summary class="profile-dropdown-title">Lieblings-Genres auswählen</summary>
        <div class="profile-grid profile-dropdown-content">
            <?php foreach ($genres as $g): ?>
                <label class="profile-item">
                    <input type="checkbox" name="genres[]"
                           value="<?= (int)$g['Genre_ID'] ?>"
                           <?= in_array((int)$g['Genre_ID'], $favGenres, true) ? 'checked' : '' ?>>
                    <span><?= htmlspecialchars($g['Name']) ?></span>
                </label>
            <?php endforeach; ?>
        </div>
    </details>
</div>
        <button type="submit" class="profile-save">Speichern</button>
    </form>
</main>

<?php include 'partials/footer.php'; ?>
