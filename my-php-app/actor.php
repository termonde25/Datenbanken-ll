<?php
require 'db.php';
include 'partials/header.php';

$actorId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($actorId <= 0) {
    echo "<main class='hero'><h1>Schauspieler nicht gefunden</h1></main>";
    include 'partials/footer.php';
    exit;
}

/* Schauspieler laden */
$actorStmt = $pdo->prepare("
    SELECT Schauspieler_ID, Name, Lebenslauf, Geb_Datum, Bild
    FROM Schauspieler
    WHERE Schauspieler_ID = :id
");
$actorStmt->execute(['id' => $actorId]);
$actor = $actorStmt->fetch(PDO::FETCH_ASSOC);

if (!$actor) {
    echo "<main class='hero'><h1>Schauspieler nicht gefunden</h1></main>";
    include 'partials/footer.php';
    exit;
}

/* Filme des Schauspielers */
$filmStmt = $pdo->prepare("
    SELECT f.Film_ID, f.Name, f.Bild
    FROM Film f
    INNER JOIN Schauspieler_spielt_in_Film sf ON sf.Film_ID = f.Film_ID
    WHERE sf.Schauspieler_ID = :id
    ORDER BY f.Name ASC
");
$filmStmt->execute(['id' => $actorId]);
$filme = $filmStmt->fetchAll(PDO::FETCH_ASSOC);

/* Auszeichnungen des Schauspielers */
$awardStmt = $pdo->prepare("
    SELECT a.Preistyp, a.Name
    FROM Auszeichnung a
    INNER JOIN Schauspieler_hat_Auszeichnung sa 
        ON sa.Auszeichnung_ID = a.Auszeichnung_ID
    WHERE sa.Schauspieler_ID = :id
    ORDER BY a.Preistyp ASC, a.Name ASC
");
$awardStmt->execute(['id' => $actorId]);
$awards = $awardStmt->fetchAll(PDO::FETCH_ASSOC);

/* Bild bestimmen */
$actorImage = !empty($actor['Bild'])
    ? 'img/actors/' . htmlspecialchars($actor['Bild'])
    : 'img/actors/default.png';
?>

<main>
    <section class="hero" style="text-align:center;">
        <h1><?= htmlspecialchars($actor['Name']) ?></h1>

        <div class="actor-profile">
            <img src="<?= $actorImage ?>"
                 alt="<?= htmlspecialchars($actor['Name']) ?>"
                 class="actor-image">
        </div>

        <?php if (!empty($actor['Geb_Datum'])): ?>
            <p style="color:#ccc; margin-top:5px;">
                Geboren am <?= date('d.m.Y', strtotime($actor['Geb_Datum'])) ?>
            </p>
        <?php endif; ?>

        <?php if (!empty($actor['Lebenslauf'])): ?>
            <p style="max-width:700px; margin:20px auto; font-size:18px;">
                <?= nl2br(htmlspecialchars($actor['Lebenslauf'])) ?>
            </p>
        <?php else: ?>
            <p style="color:#ccc;">Kein Lebenslauf hinterlegt.</p>
        <?php endif; ?>
    </section>

    <section>
        <h2 style="text-align:center;">Filme</h2>

        <div class="film-grid">
            <?php if (empty($filme)): ?>
                <p style="text-align:center; color:#ccc;">Keine Filme eingetragen.</p>
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

    <section class="genre-page">
        <h2>Auszeichnungen</h2>

        <?php if (empty($awards)): ?>
            <p style="color:#ccc;">Keine Auszeichnungen eingetragen.</p>
        <?php else: ?>
            <ul class="award-list">
                <?php foreach ($awards as $a): ?>
                    <li class="award-item">
                        🏆 <strong><?= htmlspecialchars($a['Preistyp']) ?></strong>
                        – <?= htmlspecialchars($a['Name']) ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>
    </section>
</main>

<?php include 'partials/footer.php'; ?>
