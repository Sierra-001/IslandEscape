<?php
/**
 * Copy this file to config/app.php and edit if needed.
 * config/app.php is gitignored.
 */
return [
    'db' => [
        'host'    => '127.0.0.1',
        'port'    => 3306,
        'name'    => 'island_escape_v2',
        'user'    => 'root',
        'pass'    => '',          // blank in a fresh XAMPP install
        'charset' => 'utf8mb4',
    ],
    'app' => [
        'name'  => 'Island Escape Adventures',
        'debug' => true,          // set false when you're done testing
    ],
];