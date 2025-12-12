<?php
require_once 'db.php';
require_once 'partials/header.php';

if (!isset($_SESSION['user_id'])) {
    echo "<main class='content'><p>Bitte erst einloggen.</p></main>";
    require_once 'partials/footer.php';
    exit;
}

$user_id = $_SESSION['user_id'];

// Watchlist-ID holen
$stmt = $pdo->prepare("SELECT Beobachtungsliste_ID FROM Beobachtungsliste WHERE Benutzer_ID = :uid");
$stmt->execute(['uid' => $user_id]);
$wl = $stmt->fetch();
$wlid = $wl['Beobachtungsliste_ID'];

// Filme holen
$stmt = $pdo->prepare("
    SELECT f.*
    FROM Film f
    JOIN Beobachtungsliste_enthaelt_Film bef
      ON f.Film_ID = bef.Film_ID
    WHERE bef.Beobachtungsliste_ID = :wlid
");
$stmt->execute(['wlid' => $wlid]);
$filme = $stmt->fetchAll();
?>

<main class="content">
    <section class="hero">
        <h1>Meine Watchlist</h1>

        <div class="film-grid">
            <?php foreach ($filme as $film): ?>
                <div class="film-card">
                    <img src="img/<?= htmlspecialchars($film['Bild']) ?>"
                         alt="<?= htmlspecialchars($film['Name']) ?>"
                         class="film-image">

                    <h3><?= htmlspecialchars($film['Name']) ?></h3>

                    <form action="watchlist_remove.php" method="post">
                        <input type="hidden" name="film_id" value="<?= $film['Film_ID'] ?>">
                        <button type="submit" 
                                style="padding:5px 15px; margin-top:10px; border:none; background-color:#e74c3c; color:white; border-radius:5px;">
                            ❌ Entfernen
                        </button>
                    </form>
                </div>
            <?php endforeach; ?>
        </div>
    </section>
</main>

<?php require_once 'partials/footer.php'; ?>
