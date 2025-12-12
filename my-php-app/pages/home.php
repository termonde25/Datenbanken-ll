<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require 'db.php';

$uid = $_SESSION['user_id'] ?? null;

/*
  1) Wenn Nutzer eingeloggt:
     - Filme mit Lieblings-Schauspielern nach oben
     - danach Lieblings-Genres
     - danach Bewertung
  2) Wenn nicht eingeloggt:
     - Top Filme nach Bewertung
*/

if ($uid) {
    $stmt = $pdo->prepare("
        SELECT 
            f.Film_ID,
            f.Name,
            f.Bild,
            COALESCE(AVG(b.Bewertung), 0) AS avg_rating,

            (
                SELECT COUNT(*)
                FROM Schauspieler_spielt_in_Film sf
                JOIN Benutzer_mag_Schauspieler bs
                  ON bs.Schauspieler_ID = sf.Schauspieler_ID
                WHERE sf.Film_ID = f.Film_ID
                  AND bs.Benutzer_ID = :uid
            ) AS actor_match,

            (
                SELECT COUNT(*)
                FROM Genre_hat_Filme gf
                JOIN Benutzer_mag_Genre bg
                  ON bg.Genre_ID = gf.Genre_ID
                WHERE gf.Film_ID = f.Film_ID
                  AND bg.Benutzer_ID = :uid
            ) AS genre_match

        FROM Film f
        LEFT JOIN Bewertung b ON b.Film_ID = f.Film_ID
        GROUP BY f.Film_ID, f.Name, f.Bild
        ORDER BY (actor_match * 3 + genre_match * 2) DESC, avg_rating DESC
        LIMIT 6
    ");

    $stmt->execute(['uid' => (int)$uid]);
    $filme = $stmt->fetchAll(PDO::FETCH_ASSOC);

} else {
    // Nicht eingeloggt → klassische Top-Filme
    $stmt = $pdo->query("
        SELECT 
            f.Film_ID,
            f.Name,
            f.Bild,
            COALESCE(AVG(b.Bewertung), 0) AS avg_rating
        FROM Film f
        LEFT JOIN Bewertung b ON b.Film_ID = f.Film_ID
        GROUP BY f.Film_ID, f.Name, f.Bild
        ORDER BY avg_rating DESC
        LIMIT 6
    ");

    $filme = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>

<main>
    <section class="hero">
        <h1>Top Filme heute</h1>
    </section>

    <section>
        <div class="film-grid">
            <?php foreach ($filme as $film): ?>
                <a href="movie.php?id=<?= (int)$film['Film_ID'] ?>" class="film-card">
                    <img
                        src="img/<?= htmlspecialchars($film['Bild']) ?>"
                        alt="<?= htmlspecialchars($film['Name']) ?>"
                        class="film-image"
                    >
                    <h3><?= htmlspecialchars($film['Name']) ?></h3>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
</main>
