<?php
declare(strict_types=1);

/**
 * CLI-only: creates the default Admin and Customer users.
 * Run from the project root:  php scripts/seed-users.php
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("This script is CLI-only.\n");
}

require_once __DIR__ . '/../src/bootstrap.php';

use Src\Database\Connection;
use Src\Support\Security;

$defaults = [
    ['admin@islandescape.local',    'Admin@123',    'Administrator',   'Admin'],
    ['customer@islandescape.local', 'Customer@123', 'Sample Customer', 'Customer'],
];

$pdo = Connection::pdo();

foreach ($defaults as [$email, $password, $name, $role]) {
    $stmt = $pdo->prepare('SELECT UserId FROM Users WHERE Email = ?');
    $stmt->execute([$email]);
    if ($stmt->fetchColumn()) {
        echo "Exists: $email\n";
        continue;
    }

    $insert = $pdo->prepare(
        'INSERT INTO Users (Email, PasswordHash, FullName, Role, IsActive)
         VALUES (?, ?, ?, ?, 1)'
    );
    $insert->execute([$email, Security::hash($password), $name, $role]);
    echo "Created: $email  (password: $password)\n";
}

echo "\nDone. Change these passwords after first login.\n";