<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StreamMatch</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
    <!-- Logo links -->
    <div class="logo">
        <a href="index.php">StreamMatch</a>
    </div>

    <!-- Suchleiste in der Mitte -->
    <form action="search.php" method="get" class="search-form" autocomplete="off">
        <div class="search-container">
            <input
                type="text"
                name="q"
                id="main-search-input"
                class="search-input"
                placeholder="Film suchen..."
            >
            <button type="submit" class="search-button">🔍</button>

            <!-- Live-Vorschläge -->
            <div class="search-suggestions" id="search-suggestions"></div>
        </div>
    </form>

    <!-- Navigation rechts -->
    <nav class="nav-links">
        <a href="index.php">Start</a>
        <a href="genres.php">Genres</a>
        <a href="watchlist.php">Watchlist</a>
        <a href="news.php">Neuigkeiten</a>

        <?php if (isset($_SESSION['user_id'])): ?>
            
           <a href="profile.php" class="user-icon">Profil</a>
            <a href="logout.php" class="user-icon">Logout</a>

        <?php else: ?>
            <a href="login.php" class="user-icon">Login</a>
        <?php endif; ?>
    </nav>
</header>
