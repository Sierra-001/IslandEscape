<?php
declare(strict_types=1);

$pageTitle = 'Not Found';
require BASE_PATH . '/app/views/layouts/site-header.php';
?>
<div class="text-center py-5">
    <h1 class="display-4">404</h1>
    <p class="lead">The page you're looking for doesn't exist.</p>
    <a href="<?= url('/') ?>" class="btn btn-primary">Back to Home</a>
</div>
<?php require BASE_PATH . '/app/views/layouts/site-footer.php'; ?>