<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

$user_id = $_GET['id'];

// Получаем данные пользователя
$stmt = $pdo->prepare("SELECT * FROM trade_org.users WHERE user_id = :user_id");
$stmt->execute(['user_id' => $user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $role = $_POST['role'];

    // Обновляем данные пользователя
    $stmt = $pdo->prepare("UPDATE trade_org.users SET username = :username, password = :password, role = :role WHERE user_id = :user_id");
    $stmt->execute([
        'username' => $username,
        'password' => $password,
        'role' => $role,
        'user_id' => $user_id
    ]);

    header("Location: users.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактировать пользователя</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Редактировать пользователя</h1>
    <form method="POST">
        <label for="username">Логин:</label>
        <input type="text" id="username" name="username" value="<?= $user['username'] ?>" required>
        <br>
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password" value="<?= $user['password'] ?>" required>
        <br>
        <label for="role">Роль:</label>
        <select id="role" name="role" required>
            <option value="admin" <?= $user['role'] === 'admin' ? 'selected' : '' ?>>Администратор</option>
            <option value="manager" <?= $user['role'] === 'manager' ? 'selected' : '' ?>>Менеджер</option>
            <option value="accountant" <?= $user['role'] === 'accountant' ? 'selected' : '' ?>>Бухгалтер</option>
            <option value="warehouse" <?= $user['role'] === 'warehouse' ? 'selected' : '' ?>>Кладовщик</option>
            <option value="sales" <?= $user['role'] === 'sales' ? 'selected' : '' ?>>Продавец</option>
        </select>
        <br>
        <button type="submit">Сохранить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='users.php'">Назад</button>
    </div>
</body>
</html>