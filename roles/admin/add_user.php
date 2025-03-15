<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $role = $_POST['role'];

    // Добавляем пользователя
    $stmt = $pdo->prepare("INSERT INTO trade_org.users (username, password, role) VALUES (:username, :password, :role)");
    $stmt->execute([
        'username' => $username,
        'password' => $password,
        'role' => $role
    ]);

    header("Location: users.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить пользователя</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Добавить пользователя</h1>
    <form method="POST">
        <label for="username">Логин:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <label for="role">Роль:</label>
        <select id="role" name="role" required>
            <option value="admin">Администратор</option>
            <option value="manager">Менеджер</option>
            <option value="accountant">Бухгалтер</option>
            <option value="warehouse">Кладовщик</option>
            <option value="sales">Продавец</option>
        </select>
        <br>
        <button type="submit">Добавить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
    </div>
</body>
</html>