<?php
require_once 'db.php';
require_once 'partials/header.php';

// Prüfen, ob ID vorhanden ist
if (!isset($_GET['id'])) {
    echo "<main class='content'><p style='text-align:center;'>Film nicht gefunden.</p></main>";
    require_once 'partials/footer.php';
    exit;
}

$id = (int)$_GET['id'];

// Film laden
$stmt = $pdo->prepare("SELECT * FROM Film WHERE Film_ID = :id");
$stmt->execute(['id' => $id]);
$film = $stmt->fetch();

if (!$film) {
    echo "<main class='content'><p style='text-align:center;'>Film nicht gefunden.</p></main>";
    require_once 'partials/footer.php';
    exit;
}

// Schauspieler laden
$stmtActors = $pdo->prepare("
    SELECT s.*
    FROM Schauspieler s
    JOIN Schauspieler_spielt_in_Film sf
      ON s.Schauspieler_ID = sf.Schauspieler_ID
    WHERE sf.Film_ID = :id
");
$stmtActors->execute(['id' => $id]);
$schauspieler = $stmtActors->fetchAll();

// Bewertungs-Statistik laden
$stmtRating = $pdo->prepare("
    SELECT AVG(Bewertung) AS avg_rating, COUNT(*) AS rating_count
    FROM Bewertung
    WHERE Film_ID = :id
");
$stmtRating->execute(['id' => $id]);
$ratingData   = $stmtRating->fetch(PDO::FETCH_ASSOC);
$avgRating    = $ratingData['avg_rating'];
$ratingCount  = (int)$ratingData['rating_count'];

// Eigene Bewertung des Benutzers (falls eingeloggt)
$userRating = null;
if (isset($_SESSION['user_id'])) {
    $stmtUserRating = $pdo->prepare("
        SELECT Bewertung 
        FROM Bewertung 
        WHERE Benutzer_ID = :uid AND Film_ID = :fid
    ");
    $stmtUserRating->execute([
        'uid' => $_SESSION['user_id'],
        'fid' => $id
    ]);
    $ur = $stmtUserRating->fetch(PDO::FETCH_ASSOC);
    if ($ur) {
        $userRating = (int)$ur['Bewertung'];
    }
}
?>

<main class="content">
    <section class="hero">
        <h1><?= htmlspecialchars($film['Name']) ?></h1>

        <img src="img/<?= htmlspecialchars($film['Bild']) ?>" 
             alt="<?= htmlspecialchars($film['Name']) ?>" 
             style="width: 300px; border-radius: 10px; margin-top:20px;">

        <p style="margin-top:20px; font-size:18px; width: 60%; margin-left:auto; margin-right:auto;">
            <?= nl2br(htmlspecialchars($film['Beschreibung'])) ?>
        </p>

        <?php if (isset($_SESSION['user_id'])): ?>
    <div style="margin-top:20px;">
        <button id="watchlistButton"
                type="button"
                onclick="addToWatchlist(<?= (int)$film['Film_ID'] ?>)"
                style="padding:10px 20px; border:none; background-color:#f39c12; color:white; border-radius:5px; cursor:pointer;">
            ➕ Zur Watchlist hinzufügen
        </button>
        <p id="watchlistMessage" style="margin-top:8px; font-size:14px; color:#2ecc71; display:none;">
            ✔️ Zur Watchlist hinzugefügt
        </p>
        <p id="watchlistError" style="margin-top:8px; font-size:14px; color:#e74c3c; display:none;">
            Es ist ein Fehler aufgetreten.
        </p>
    </div>

    <script>
        function addToWatchlist(filmId) {
            const btn = document.getElementById('watchlistButton');
            const msg = document.getElementById('watchlistMessage');
            const err = document.getElementById('watchlistError');

            msg.style.display = 'none';
            err.style.display = 'none';
            btn.disabled = true;

            fetch('watchlist_add.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'film_id=' + encodeURIComponent(filmId)
            })
            .then(response => {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.text();
            })
            .then(text => {
                if (text.trim() === 'OK') {
                    msg.style.display = 'block';
                } else {
                    err.textContent = 'Fehler: ' + text;
                    err.style.display = 'block';
                }
            })
            .catch(e => {
                err.textContent = 'Fehler beim Hinzufügen zur Watchlist.';
                err.style.display = 'block';
            })
            .finally(() => {
                btn.disabled = false;
            });
        }
    </script>

<?php else: ?>
    <p style="margin-top:20px;">
        Bitte <a href="login.php">einloggen</a>, um Filme zur Watchlist hinzuzufügen.
    </p>
<?php endif; ?>


        <!-- SCHAUSPIELER -->
        <h2 style="margin-top:40px;">Schauspieler</h2>

        <?php if (!empty($schauspieler)): ?>
            <ul style="list-style:none; padding:0; font-size:18px;">
    <?php foreach ($schauspieler as $sp): ?>
        <li style="margin-bottom:6px;">
            <a href="actor.php?id=<?= (int)$sp['Schauspieler_ID'] ?>"
               style="color:#f1c40f; text-decoration:none;">
                <?= htmlspecialchars($sp['Name']) ?>
            </a>
        </li>
    <?php endforeach; ?>
</ul>
        <?php else: ?>
            <p>Zu diesem Film sind noch keine Schauspieler eingetragen.</p>
        <?php endif; ?>

        <!-- BEWERTUNG -->
        <h2 style="margin-top:40px;">Bewertung</h2>

        <?php if (isset($_SESSION['user_id'])): ?>
            <form action="rate_movie.php" method="post" id="ratingForm" style="margin-top: 10px;">
                <input type="hidden" name="film_id" value="<?= $film['Film_ID'] ?>">
                <input type="hidden" name="rating" id="ratingInput" value="<?= $userRating ?? 0 ?>">

                <div id="ratingStars" 
                     data-current="<?= $userRating ?? 0 ?>" 
                     style="font-size:32px; cursor:pointer;">
                    <?php for ($i = 1; $i <= 5; $i++): ?>
                        <span class="rating-star" data-value="<?= $i ?>" style="padding:0 5px;">★</span>
                    <?php endfor; ?>
                </div>

                <button type="submit"
                        style="padding:8px 18px; border:none; background-color:#3498db; color:white; border-radius:5px; cursor:pointer; margin-top:10px;">
                    Bewerten
                </button>
            </form>

            <?php if ($userRating !== null): ?>
                <p style="margin-top:10px; font-size:14px;">
                    Deine Bewertung: <?= $userRating ?> / 5
                </p>
            <?php endif; ?>

            <!-- kleines JS für die Sterne -->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const starsContainer = document.getElementById('ratingStars');
                    const stars = document.querySelectorAll('#ratingStars .rating-star');
                    const ratingInput = document.getElementById('ratingInput');
                    let current = parseInt(starsContainer.dataset.current) || 0;

                    function updateStars(value) {
                        stars.forEach(star => {
                            const v = parseInt(star.dataset.value);
                            star.style.color = v <= value ? '#f1c40f' : '#444';
                        });
                    }

                    // initialer Zustand (eigene Bewertung)
                    updateStars(current);

                    // Klick-Handler auf die Sterne
                    stars.forEach(star => {
                        star.addEventListener('click', function () {
                            const value = parseInt(this.dataset.value);
                            ratingInput.value = value;
                            updateStars(value);
                        });
                    });
                });
            </script>

        <?php else: ?>
            <p>Bitte <a href="login.php">einloggen</a>, um diesen Film zu bewerten.</p>
        <?php endif; ?>

        <!-- DURCHSCHNITTLICHE BEWERTUNG -->
<div style="margin-top:20px; font-size:18px; text-align:center;">
    <?php if ($ratingCount > 0): ?>
        <?php 
            $rounded = round($avgRating, 1); // z.B. 3.5
            $formatted = str_replace('.', ',', (string)$rounded); // 3,5
        ?>
        <p style="display:flex; align-items:center; justify-content:center; gap:8px;">
            <span style="color:#f1c40f; font-size:28px;">★</span>
            <span>
                <strong><?= $formatted ?> / 5</strong>
                (<?= $ratingCount ?> Bewertung<?= $ratingCount === 1 ? '' : 'en' ?>)
            </span>
        </p>
    <?php else: ?>
        <p>Dieser Film wurde noch nicht bewertet.</p>
    <?php endif; ?>
</div>


    </section>
</main>

<?php require_once 'partials/footer.php'; ?>
