<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../../index.php");
    exit();
}

// Обработка формы
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];

    // Валидация данных
    if (empty($first_name) || empty($last_name)) {
        $error = "Имя и фамилия обязательны для заполнения!";
    } else {
        // Добавление клиента в базу данных
        $stmt = $pdo->prepare("
            INSERT INTO trade_org.customers (first_name, last_name, email, phone, address)
            VALUES (?, ?, ?, ?, ?)
        ");
        $stmt->execute([$first_name, $last_name, $email, $phone, $address]);

        // Перенаправление на страницу списка клиентов
        header("Location: customers.php");
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить клиента</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Добавить клиента</h1>

    <?php if (isset($error)): ?>
        <p style="color: red;"><?= $error ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="first_name">Имя:</label>
        <input type="text" id="first_name" name="first_name" required><br>

        <label for="last_name">Фамилия:</label>
        <input type="text" id="last_name" name="last_name" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email"><br>

        <label for="phone">Телефон:</label>
        <input type="text" id="phone" name="phone"><br>

        <label for="address">Адрес:</label>
        <textarea id="address" name="address"></textarea><br>

        <button type="submit">Добавить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../manager.php'">Назад</button>
    </div>
</body>
</html>