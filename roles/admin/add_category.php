<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Обработка формы
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $category_name = trim($_POST['category_name']);

    if (!empty($category_name)) {
        $stmt = $pdo->prepare("INSERT INTO trade_org.categories (category_name) VALUES (:category_name)");
        $stmt->execute(['category_name' => $category_name]);

        header("Location: categories.php");
        exit();
    } else {
        $error = "Заполните поле названия категории!";
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить категорию</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Добавить категорию</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название категории:</label>
            <input type="text" name="category_name" required>
            <button class="link-button" type="submit">Добавить</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
    </div>
</body>
</html>
