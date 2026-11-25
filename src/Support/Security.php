<?php
declare(strict_types=1);

namespace Src\Support;

final class Security
{
    public static function hash(string $password): string
    {
        return password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);
    }

    public static function verify(string $password, string $hash): bool
    {
        return password_verify($password, $hash);
    }

    public static function csrfToken(): string
    {
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }

    public static function csrfField(): string
    {
        return '<input type="hidden" name="_csrf" value="' . self::csrfToken() . '">';
    }

    public static function verifyCsrf(): void
    {
        $token = $_POST['_csrf'] ?? '';
        if (!is_string($token) || !hash_equals(self::csrfToken(), $token)) {
            http_response_code(419);
            exit('Invalid CSRF token. Reload the page and try again.');
        }
    }

    public static function requireAuth(): void
    {
        if (empty($_SESSION['user_id'])) {
            header('Location: ' . url('/login'));
            exit;
        }
    }

    public static function requireAdmin(): void
    {
        self::requireAuth();
        if (($_SESSION['user_role'] ?? '') !== 'Admin') {
            http_response_code(403);
            exit('Forbidden.');
        }
    }
}