<?php
require_once __DIR__ . '/../db.php';

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $email    = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $password2 = $_POST['password2'] ?? '';

    if ($username === '' || $email === '' || $password === '' || $password2 === '') {
        $error = 'Bitte alle Felder ausfüllen.';
    } elseif ($password !== $password2) {
        $error = 'Die Passwörter stimmen nicht überein.';
    } else {
        // Prüfen, ob Nutzername oder E-Mail schon existieren
        $stmt = $pdo->prepare("
            SELECT * FROM Benutzer
            WHERE Nutzername = :username OR E_Mail = :email
            LIMIT 1
        ");
        $stmt->execute([
            'username' => $username,
            'email'    => $email
        ]);
        $existing = $stmt->fetch();

        if ($existing) {
            $error = 'Nutzername oder E-Mail ist bereits vergeben.';
        } else {
            // Passwort hashen
            $hash = password_hash($password, PASSWORD_DEFAULT);

            $stmt = $pdo->prepare("
                INSERT INTO Benutzer (Nutzername, E_Mail, Passwort)
                VALUES (:username, :email, :passwort)
            ");
            $stmt->execute([
                'username' => $username,
                'email'    => $email,
                'passwort' => $hash
            ]);

            $success = 'Registrierung erfolgreich. Du kannst dich jetzt einloggen.';
        }
    }
}
?>

<main class="content">
    <section class="hero">
        <h1>Registrierung</h1>

        <?php if ($error): ?>
            <p style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>

        <?php if ($success): ?>
            <p style="color: lightgreen;"><?= htmlspecialchars($success) ?></p>
        <?php endif; ?>

        <form method="post" class="auth-form">
            <label>
                Nutzername:
                <input type="text" name="username">
            </label>
            <br><br>
            <label>
                E-Mail:
                <input type="email" name="email">
            </label>
            <br><br>
            <label>
                Passwort:
                <input type="password" name="password">
            </label>
            <br><br>
            <label>
                Passwort wiederholen:
                <input type="password" name="password2">
            </label>
            <br><br>
            <button type="submit">Registrieren</button>
        </form>
    </section>
</main>
