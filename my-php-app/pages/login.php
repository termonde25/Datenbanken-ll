<main class="content">
    <section class="hero">
        <h1>Login</h1>

        <?php if (!empty($error)): ?>
            <p style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>

        <form method="post">
            <label>
                Nutzername oder E-Mail:
                <input type="text" name="login">
            </label>
            <br><br>
            <label>
                Passwort:
                <input type="password" name="password">
            </label>
            <br><br>
            <button type="submit">Einloggen</button>
        </form>

        <p>Noch kein Konto? <a href="register.php">Registrieren</a></p>
    </section>
</main>
