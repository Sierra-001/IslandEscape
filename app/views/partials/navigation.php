<?php
declare(strict_types=1);

use Src\Database\Connection;

$isLoggedIn = !empty($_SESSION['user_id']);
$isAdmin    = ($_SESSION['user_role'] ?? '') === 'Admin';

$cartCount = 0;
if ($isLoggedIn) {
    $stmt = Connection::pdo()->prepare(
        'SELECT COALESCE(SUM(Quantity), 0) FROM CartItems WHERE UserId = ?'
    );
    $stmt->execute([$_SESSION['user_id']]);
    $cartCount = (int) $stmt->fetchColumn();
}
?>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="<?= url('/') ?>"><?= e(APP_NAME) ?></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="<?= url('/') ?>">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="<?= url('/packages') ?>">Packages</a></li>
                <li class="nav-item"><a class="nav-link" href="<?= url('/about') ?>">About</a></li>
                <li class="nav-item"><a class="nav-link" href="<?= url('/contact') ?>">Contact</a></li>
            </ul>
            <ul class="navbar-nav">
                <?php if ($isLoggedIn): ?>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/profile') ?>">Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/cart') ?>">
                        Cart <span class="badge bg-light text-dark"><?= $cartCount ?></span>
                    </a></li>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/purchase-history') ?>">History</a></li>
                    <?php if ($isAdmin): ?>
                        <li class="nav-item"><a class="nav-link" href="<?= url('/admin') ?>">Admin</a></li>
                    <?php endif; ?>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/logout') ?>">Logout</a></li>
                <?php else: ?>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/login') ?>">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="<?= url('/register') ?>">Register</a></li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>