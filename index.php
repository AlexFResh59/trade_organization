<?php
session_start();
require_once 'includes/db.php';
require_once 'includes/auth.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Проверка авторизации
    $user = authenticateUser($username, $password, $pdo);

    if ($user) {
        // Сохраняем данные в сессии
        $_SESSION['user_id'] = $user['user_id'];
        $_SESSION['role'] = $user['role'];

        // Перенаправляем на страницу роли
        header("Location: roles/{$user['role']}.php");
        exit();
    } else {
        $error = "Неверный логин или пароль.";
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Авторизация</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Вход в систему</h1>
    <?php if (isset($error)): ?>
        <p style="color: red;"><?= $error ?></p>
    <?php endif; ?>
    <form method="POST">
        <label for="username">Логин:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <button type="submit">Войти</button>
    </form>

    <h2>Тестовые пользователи</h2>
    <ul>
        <li><strong>Логин:</strong> admin, <strong>Пароль:</strong> AdminPass123, <strong>Роль:</strong> admin</li>
        <li><strong>Логин:</strong> manager, <strong>Пароль:</strong> ManagerPass456, <strong>Роль:</strong> manager</li>
        <li><strong>Логин:</strong> accountant, <strong>Пароль:</strong> AccountantPass789, <strong>Роль:</strong> accountant</li>
        <li><strong>Логин:</strong> warehouse, <strong>Пароль:</strong> WarehousePass321, <strong>Роль:</strong> warehouse</li>
        <li><strong>Логин:</strong> sales, <strong>Пароль:</strong> SalesPass654, <strong>Роль:</strong> sales</li>
    </ul>
</body>
</html>