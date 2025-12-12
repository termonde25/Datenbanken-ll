<?php
require 'db.php';
include 'partials/header.php';

$stmt = $pdo->query("
    SELECT Neuigkeit_ID, Typ, Name, Erschein_Datum, Teaser, Bild
    FROM Neuigkeit
    ORDER BY Erschein_Datum DESC, Neuigkeit_ID DESC
");
$news = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<main class="news-page">
    <h1>Neuigkeiten</h1>

    <?php if (empty($news)): ?>
        <p style="text-align:center; color:#ccc;">Noch keine Neuigkeiten vorhanden.</p>
    <?php else: ?>
        <div class="news-grid">
            <?php foreach ($news as $n): ?>
                <a href="news_detail.php?id=<?= (int)$n['Neuigkeit_ID'] ?>" class="news-card">
                    <div class="news-image"
                         style="background-image:url('img/news/<?= htmlspecialchars($n['Bild'] ?? 'default.jpg') ?>');">
                    </div>

                    <div class="news-content">
                        <span class="news-category"><?= htmlspecialchars($n['Typ']) ?></span>
                        <h3><?= htmlspecialchars($n['Name']) ?></h3>
                        <p><?= htmlspecialchars($n['Teaser'] ?? '') ?></p>
                        <small><?= date('d.m.Y', strtotime($n['Erschein_Datum'])) ?></small>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</main>

<?php include 'partials/footer.php'; ?>
