<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'warehouse') {
    header("Location: ../index.php");
    exit();
}

// Получаем список продуктов и складов
$products = $pdo->query("SELECT product_id, product_name FROM trade_org.products")->fetchAll(PDO::FETCH_ASSOC);
$warehouses = $pdo->query("SELECT warehouse_id, warehouse_name FROM trade_org.warehouses")->fetchAll(PDO::FETCH_ASSOC);

// Обработка формы
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $product_id = $_POST['product_id'];
    $warehouse_id = $_POST['warehouse_id'];
    $quantity = $_POST['quantity'];

    // Валидация данных
    if (empty($product_id) || empty($warehouse_id) || empty($quantity)) {
        $error = "Все поля обязательны для заполнения!";
    } else {
        // Добавление товара на склад
        $stmt = $pdo->prepare("
            INSERT INTO trade_org.inventory (product_id, warehouse_id, quantity)
            VALUES (?, ?, ?)
        ");
        $stmt->execute([$product_id, $warehouse_id, $quantity]);

        // Перенаправление на страницу списка товаров
        header("Location: inventory.php");
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить товар на склад</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Добавить товар на склад</h1>

    <?php if (isset($error)): ?>
        <p style="color: red;"><?= $error ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="product_id">Товар:</label>
        <select id="product_id" name="product_id" required>
            <option value="">Выберите товар</option>
            <?php foreach ($products as $product): ?>
                <option value="<?= $product['product_id'] ?>"><?= $product['product_name'] ?></option>
            <?php endforeach; ?>
        </select><br>

        <label for="warehouse_id">Склад:</label>
        <select id="warehouse_id" name="warehouse_id" required>
            <option value="">Выберите склад</option>
            <?php foreach ($warehouses as $warehouse): ?>
                <option value="<?= $warehouse['warehouse_id'] ?>"><?= $warehouse['warehouse_name'] ?></option>
            <?php endforeach; ?>
        </select><br>

        <label for="quantity">Количество:</label>
        <input type="number" id="quantity" name="quantity" min="1" required><br>

        <button type="submit">Добавить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../warehouse.php'">Назад</button>
    </div>
</body>
</html>