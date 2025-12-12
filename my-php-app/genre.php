<?php
require 'db.php';
include 'partials/header.php';

$genreId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Genre laden
$genreStmt = $pdo->prepare("
    SELECT Name, Beschreibung
    FROM Genre
    WHERE Genre_ID = :id
");
$genreStmt->execute(['id' => $genreId]);
$genre = $genreStmt->fetch();

if (!$genre) {
    ?>
    <main class="hero">
        <h1>Genre nicht gefunden</h1>
    </main>
    <?php
    include 'partials/footer.php';
    exit;
}

// Filme dieses Genres laden
$filmStmt = $pdo->prepare("
    SELECT f.Film_ID, f.Name, f.Bild
    FROM Film f
    INNER JOIN Genre_hat_Filme gf ON f.Film_ID = gf.Film_ID
    WHERE gf.Genre_ID = :id
    ORDER BY f.Name ASC
");
$filmStmt->execute(['id' => $genreId]);
$filme = $filmStmt->fetchAll();
?>

<main>
    <section class="hero">
        <h1><?= htmlspecialchars($genre['Name']) ?></h1>
        <p><?= htmlspecialchars($genre['Beschreibung']) ?></p>
    </section>

    <section>
        <div class="film-grid">
            <?php if (empty($filme)): ?>
                <p>Für dieses Genre sind noch keine Filme eingetragen.</p>
            <?php else: ?>
                <?php foreach ($filme as $film): ?>
                    <a href="movie.php?id=<?= $film['Film_ID'] ?>" class="film-card">
                        <img src="img/<?= htmlspecialchars($film['Bild']) ?>"
                             alt="<?= htmlspecialchars($film['Name']) ?>"
                             class="film-image">
                        <h3><?= htmlspecialchars($film['Name']) ?></h3>
                    </a>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </section>
</main>

<?php include 'partials/footer.php'; ?>
