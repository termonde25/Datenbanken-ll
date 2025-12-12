<?php
require_once 'db.php';
require_once 'partials/header.php';

$term = trim($_GET['q'] ?? '');
$filme = [];

if ($term !== '') {
    $stmt = $pdo->prepare("
        SELECT Film_ID, Name, Bild, Beschreibung
        FROM Film
        WHERE Name LIKE :q
        ORDER BY Name ASC
    ");
    $stmt->execute(['q' => '%' . $term . '%']);
    $filme = $stmt->fetchAll();
}
?>

<main class="content">
    <section class="hero">
        <h1>Filmsuche</h1>

        <!-- Suchformular -->
        <form action="search.php" method="get" class="search-form">
            <input
                type="text"
                name="q"
                class="search-input"
                placeholder="Filmtitel eingeben, z. B. &quot;Harry&quot;..."
                value="<?= htmlspecialchars($term) ?>"
            >
            <button type="submit" class="search-button">🔍</button>
        </form>

        <?php if ($term === ''): ?>
            <p style="margin-top:30px;">
                Gib oben einen Suchbegriff ein.
            </p>
        <?php else: ?>

            <p style="margin-top:30px;">
                Suchergebnis für: <strong><?= htmlspecialchars($term) ?></strong>
            </p>

            <?php if (empty($filme)): ?>
                <p>Keine Filme gefunden.</p>
            <?php else: ?>
                <div class="film-grid" style="margin-top:20px;">
                    <?php foreach ($filme as $film): ?>
                        <a href="movie.php?id=<?= $film['Film_ID'] ?>" class="film-card">
                            <img
                                src="img/<?= htmlspecialchars($film['Bild']) ?>"
                                alt="<?= htmlspecialchars($film['Name']) ?>"
                                class="film-image"
                            >
                            <h3><?= htmlspecialchars($film['Name']) ?></h3>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

        <?php endif; ?>
    </section>
</main>

<?php require_once 'partials/footer.php'; ?>
