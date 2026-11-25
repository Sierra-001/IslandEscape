<?php
declare(strict_types=1);

namespace Src\Support;

final class Url
{
    public static function to(string $path): string
    {
        return url($path);
    }

    public static function redirect(string $path): void
    {
        header('Location: ' . self::to($path));
        exit;
    }

    public static function query(string $key, ?string $default = null): ?string
    {
        $v = $_GET[$key] ?? null;
        return is_string($v) ? $v : $default;
    }
}