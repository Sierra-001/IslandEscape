<?php
declare(strict_types=1);
if (!defined('BASE_URL')) { exit; }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($pageTitle ?? 'Home') ?> — <?= e(APP_NAME) ?></title>
    <link href="<?= asset('css/bootstrap.min.css') ?>" rel="stylesheet">
    <link href="<?= asset('css/bootstrap-icons.min.css') ?>" rel="stylesheet">
    <link href="<?= asset('css/app.css') ?>" rel="stylesheet">
</head>
<body>
    <?php require BASE_PATH . '/app/views/partials/navigation.php'; ?>
    <main class="container py-4"></main>