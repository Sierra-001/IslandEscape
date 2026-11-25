<?php
declare(strict_types=1);

namespace App\Http;

final class Router
{
    public static function dispatch(): void
    {
        $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';

        if (BASE_URL !== '' && str_starts_with($uri, BASE_URL)) {
            $uri = substr($uri, strlen(BASE_URL));
        }

        $path = trim($uri, '/');
        if ($path === 'index.php') {
            $path = '';
        }

        $routes = require BASE_PATH . '/config/routes.php';
        $target = $routes[$path] ?? null;

        if ($target === null) {
            http_response_code(404);
            $target = 'app/pages/Public/NotFound.php';
        }

        require BASE_PATH . '/' . $target;
    }
}