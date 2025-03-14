<?php
// Подключение к базе данных PostgreSQL
$dsn = "pgsql:host=localhost;dbname=trade_org;port=5432";
$user = "trade_org";
$password = "1234";

try {
    $pdo = new PDO($dsn, $user, $password, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

    // Массив пользователей с ролями и паролями
    $users = [
        ["admin", "AdminPass123", "admin"],
        ["manager", "ManagerPass456", "manager"],
        ["accountant", "AccountantPass789", "accountant"],
        ["warehouse", "WarehousePass321", "warehouse"],
        ["sales", "SalesPass654", "sales"]
    ];

    // SQL-запрос на вставку пользователя
    $sql = "INSERT INTO trade_org.users (username, password, role, created_at) VALUES (:username, :password, :role, NOW())";

    $stmt = $pdo->prepare($sql);

    foreach ($users as $user) {
        $username = $user[0];
        $hashedPassword = password_hash($user[1], PASSWORD_BCRYPT);
        $role = $user[2];

        $stmt->execute([
            ":username" => $username,
            ":password" => $hashedPassword,
            ":role" => $role
        ]);

        echo "Пользователь $username создан успешно!<br>";
    }

} catch (PDOException $e) {
    die("Ошибка подключения или выполнения запроса: " . $e->getMessage());
}
?>
