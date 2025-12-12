<?php
require 'db.php';
include 'partials/header.php';

// Alle Genres laden
$genreStmt = $pdo->query("
    SELECT Genre_ID, Name
    FROM Genre
    ORDER BY Name ASC
");
$genres = $genreStmt->fetchAll();
?>

<main>
    <section class="genre-page">
        <h1>Genres</h1>

        <div class="genre-card-grid">
            <?php foreach ($genres as $genre): ?>
                <a href="genre.php?id=<?= $genre['Genre_ID'] ?>" class="genre-card-big">
                    <span><?= htmlspecialchars($genre['Name']) ?></span>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
</main>

<?php include 'partials/footer.php'; ?>
