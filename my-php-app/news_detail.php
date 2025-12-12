<?php
require 'db.php';
include 'partials/header.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

$stmt = $pdo->prepare("
    SELECT Neuigkeit_ID, Typ, Name, Erschein_Datum, Teaser, Inhalt, Bild
    FROM Neuigkeit
    WHERE Neuigkeit_ID = :id
");
$stmt->execute(['id' => $id]);
$news = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$news) {
    echo "<main class='hero'><h1>Neuigkeit nicht gefunden</h1></main>";
    include 'partials/footer.php';
    exit;
}
?>

<main class="news-detail">
    <a href="news.php">← Zurück zu Neuigkeiten</a>

    <h1><?= htmlspecialchars($news['Name']) ?></h1>

    <p>
        <strong><?= htmlspecialchars($news['Typ']) ?></strong> |
        <?= date('d.m.Y', strtotime($news['Erschein_Datum'])) ?>
    </p>

    <img src="img/news/<?= htmlspecialchars($news['Bild'] ?? 'default.jpg') ?>"
         style="width:100%; max-width:900px; border-radius:15px; margin:20px 0;">

    <?php if (!empty($news['Teaser'])): ?>
        <p style="font-size:18px; color:#ccc;">
            <?= htmlspecialchars($news['Teaser']) ?>
        </p>
    <?php endif; ?>

    <div style="margin-top:20px; line-height:1.6;">
        <?= nl2br(htmlspecialchars($news['Inhalt'] ?? '')) ?>
    </div>
</main>

<?php include 'partials/footer.php'; ?>
