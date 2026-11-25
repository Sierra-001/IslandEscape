<?php
declare(strict_types=1);

use Src\Database\Repositories\PackageRepository;

$pageTitle = 'Home';
$featured  = PackageRepository::featured(3);

require BASE_PATH . '/app/views/layouts/site-header.php';
?>

<section class="p-5 mb-4 bg-light rounded-3 text-center">
    <h1 class="display-5 fw-bold">Escape to Paradise</h1>
    <p class="lead">Handpicked hotels, dining, transfers, and adventures — all in one place.</p>
    <a href="<?= url('/packages') ?>" class="btn btn-primary btn-lg">Explore Packages</a>
</section>

<h2 class="mb-4">Featured Packages</h2>
<div class="row">
    <?php foreach ($featured as $pkg): ?>
        <?php $package = $pkg; include BASE_PATH . '/app/views/partials/package-card.php'; ?>
    <?php endforeach; ?>
</div>

<?php require BASE_PATH . '/app/views/layouts/site-footer.php'; ?>