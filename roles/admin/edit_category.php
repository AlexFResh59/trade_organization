<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Получаем ID категории
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: categories.php");
    exit();
}

$category_id = $_GET['id'];

// Получаем текущие данные категории
$stmt = $pdo->prepare("SELECT * FROM trade_org.categories WHERE category_id = :category_id");
$stmt->execute(['category_id' => $category_id]);
$category = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$category) {
    header("Location: categories.php");
    exit();
}

// Обработка формы обновления
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $category_name = trim($_POST['category_name']);

    if (!empty($category_name)) {
        $update_stmt = $pdo->prepare("UPDATE trade_org.categories SET category_name = :category_name WHERE category_id = :category_id");
        $update_stmt->execute([
            'category_name' => $category_name,
            'category_id' => $category_id
        ]);

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
    <title>Редактировать категорию</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Редактировать категорию</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название категории:</label>
            <input type="text" name="category_name" value="<?= htmlspecialchars($category['category_name']) ?>" required>
            <button class="link-button" type="submit">Сохранить</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='categories.php'">Назад</button>
        </div>
    </div>
</body>
</html>
