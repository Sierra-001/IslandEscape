<?php
declare(strict_types=1);

define('BASE_PATH', dirname(__DIR__));

// Auto-detect base URL. Works with or without a vhost.
$scriptName = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '/index.php');
$scriptDir  = rtrim(dirname($scriptName), '/');
define('BASE_URL', $scriptDir === '/' ? '' : $scriptDir);

// Config
$configFile = BASE_PATH . '/config/app.php';
if (!is_file($configFile)) {
    http_response_code(500);
    exit('Missing config/app.php — copy config/app.example.php and edit it.');
}
$config = require $configFile;

define('APP_DEBUG', (bool) ($config['app']['debug'] ?? false));
define('APP_NAME',  (string) ($config['app']['name'] ?? 'Island Escape'));
define('DB_CONFIG', $config['db']);

// Simple PSR-4 autoloader for Src\ and App\
spl_autoload_register(function (string $class): void {
    $map = ['Src\\' => 'src/', 'App\\' => 'app/'];
    foreach ($map as $prefix => $dir) {
        if (str_starts_with($class, $prefix)) {
            $path = BASE_PATH . '/' . $dir
                  . str_replace('\\', '/', substr($class, strlen($prefix)))
                  . '.php';
            if (is_file($path)) {
                require $path;
            }
            return;
        }
    }
});

// Errors
if (APP_DEBUG) {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    error_reporting(E_ALL);
    ini_set('log_errors', '1');
    ini_set('error_log', BASE_PATH . '/storage/logs/app.log');
}

// Session
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start([
        'cookie_httponly' => true,
        'cookie_samesite' => 'Lax',
    ]);
}

// Guest session id for the cart
if (empty($_SESSION['guest_session_id'])) {
    $_SESSION['guest_session_id'] = bin2hex(random_bytes(16));
}

// Global view helpers
function url(string $path = '/'): string
{
    return BASE_URL . ($path === '/' ? '/' : '/' . ltrim($path, '/'));
}

function asset(string $path): string
{
    return BASE_URL . '/assets/' . ltrim($path, '/');
}

function e(?string $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}