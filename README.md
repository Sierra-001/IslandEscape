# Island Escape Adventures

Local PHP + MySQL implementation of the Island Escape Adventures site,
refactored from the original ASP.NET Web Forms project.

Requires **XAMPP** (Apache on port 81, PHP 8.x, MySQL/MariaDB).

## 1. Place the project

Copy the project folder to:

```
C:\xampp\htdocs\island-escape
```

## 2. Start XAMPP

Start **Apache** and **MySQL** from the XAMPP Control Panel.

## 3. Create the database

Open `http://localhost:81/phpmyadmin`:

1. Create a database named `island_escape` with collation `utf8mb4_unicode_ci`.
2. Select it → **Import** → `database/migrations/001_create_tables.sql`.
3. **Import** again → `database/seeders/001_seed_data.sql`.

## 4. Configure

```bash
copy config\app.example.php config\app.php
```

Defaults match a fresh XAMPP install (`root` / blank password).

## 5. Seed default users

From the project root:

```bash
php scripts/seed-users.php
```

| Email                            | Password       | Role     |
|----------------------------------|----------------|----------|
| `admin@islandescape.local`       | `Admin@123`    | Admin    |
| `customer@islandescape.local`    | `Customer@123` | Customer |

Change both passwords after first login.

## 6. Choose a URL

### Option A — vhost (recommended)

`C:\Windows\System32\drivers\etc\hosts` (edit as Admin):

```
127.0.0.1    islandescape.local
```

`C:\xampp\apache\conf\extra\httpd-vhosts.conf`:

```apache
# Default catch-all — must be FIRST
<VirtualHost *:81>
    ServerName localhost
    DocumentRoot "C:/xampp/htdocs"
    <Directory "C:/xampp/htdocs">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

# Island Escape
<VirtualHost *:81>
    ServerName islandescape.local
    DocumentRoot "C:/xampp/htdocs/island-escape"
    <Directory "C:/xampp/htdocs/island-escape">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

Restart Apache. Visit **http://islandescape.local:81/**

### Option B — no vhost

Visit **http://localhost:81/island-escape/**

`BASE_URL` auto-detects either scheme — no code change needed.

## Directory overview

| Path        | Purpose                               | Web-reachable |
|-------------|---------------------------------------|---------------|
| `index.php` | Front controller                      | ✅            |
| `assets/`   | CSS, JS, images, fonts                | ✅            |
| `config/`   | Config (private)                      | ❌ 403        |
| `src/`      | Application logic                     | ❌ 403        |
| `app/`      | Pages, layouts, partials              | ❌ 403        |
| `database/` | SQL scripts                           | ❌ 403        |
| `scripts/`  | CLI utilities                         | ❌ 403        |
| `storage/`  | Logs                                  | ❌ 403        |

## Status

- ✅ Step 1 — Foundation (bootstrap, DB, security, layouts, home page)
- ⏳ Step 2 — Auth + packages listing + package details
- ⏳ Step 3 — Cart + checkout + purchase history + invoice
- ⏳ Step 4 — Profile + password + queries + contact
- ⏳ Step 5 — Admin (dashboard, packages CRUD, users, bookings, queries, reports)