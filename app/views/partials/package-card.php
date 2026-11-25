<?php
/**
 * Expects: $package (array).
 *
 * Usage:
 *   $package = $pkg;
 *   include BASE_PATH . '/app/views/partials/package-card.php';
 */
?>
<div class="col-md-4 mb-4">
    <div class="card h-100 shadow-sm">
        <div class="card-body d-flex flex-column">
            <span class="badge bg-secondary mb-2 align-self-start">
                <?= e($package['CategoryName'] ?? '') ?>
            </span>
            <h5 class="card-title"><?= e($package['Name']) ?></h5>
            <p class="card-text flex-grow-1"><?= e($package['Description']) ?></p>
            <p class="fw-bold text-primary mb-2">$<?= number_format((float) $package['Price'], 2) ?></p>
            <a href="<?= url('/package?id=' . (int) $package['PackageId']) ?>"
               class="btn btn-primary">View Details</a>
        </div>
    </div>
</div>