<?php
declare(strict_types=1);

namespace Src\Database\Repositories;

use PDO;
use Src\Database\Connection;

final class PackageRepository
{
    public static function allActive(): array
    {
        $sql = "SELECT p.*, c.CategoryName
                FROM Packages p
                INNER JOIN PackageCategories c ON c.CategoryId = p.CategoryId
                WHERE p.IsActive = 1
                ORDER BY p.PackageId";
        return Connection::pdo()->query($sql)->fetchAll();
    }

    public static function featured(int $limit = 3): array
    {
        $stmt = Connection::pdo()->prepare(
            "SELECT p.*, c.CategoryName
             FROM Packages p
             INNER JOIN PackageCategories c ON c.CategoryId = p.CategoryId
             WHERE p.IsActive = 1
             ORDER BY p.PackageId
             LIMIT :lim"
        );
        $stmt->bindValue(':lim', $limit, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public static function find(int $id): ?array
    {
        $stmt = Connection::pdo()->prepare(
            "SELECT p.*, c.CategoryName
             FROM Packages p
             INNER JOIN PackageCategories c ON c.CategoryId = p.CategoryId
             WHERE p.PackageId = ? LIMIT 1"
        );
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        return $row ?: null;
    }
}