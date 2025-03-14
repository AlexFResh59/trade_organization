<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

$product_id = $_GET['id'];

// Получаем данные товара
$stmt = $pdo->prepare("
    SELECT p.product_id, p.product_name, p.category_id, p.supplier_id, p.unit_price, p.units_in_stock, p.description 
    FROM trade_org.products p
    WHERE p.product_id = :product_id
");
$stmt->execute(['product_id' => $product_id]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);

// Получаем список категорий и поставщиков
$categories = $pdo->query("SELECT * FROM trade_org.categories")->fetchAll(PDO::FETCH_ASSOC);
$suppliers = $pdo->query("SELECT * FROM trade_org.suppliers")->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $product_name = $_POST['product_name'];
    $category_id = $_POST['category_id'];
    $supplier_id = $_POST['supplier_id'];
    $unit_price = $_POST['unit_price'];
    $units_in_stock = $_POST['units_in_stock'];
    $description = $_POST['description'];

    // Обновляем данные товара
    $stmt = $pdo->prepare("
        UPDATE trade_org.products 
        SET product_name = :product_name, category_id = :category_id, supplier_id = :supplier_id, unit_price = :unit_price, units_in_stock = :units_in_stock, description = :description 
        WHERE product_id = :product_id
    ");
    $stmt->execute([
        'product_name' => $product_name,
        'category_id' => $category_id,
        'supplier_id' => $supplier_id,
        'unit_price' => $unit_price,
        'units_in_stock' => $units_in_stock,
        'description' => $description,
        'product_id' => $product_id
    ]);

    header("Location: products.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактировать товар</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Редактировать товар</h1>
    <form method="POST">
        <label for="product_name">Название:</label>
        <input type="text" id="product_name" name="product_name" value="<?= $product['product_name'] ?>" required>
        <br>
        <label for="category_id">Категория:</label>
        <select id="category_id" name="category_id" required>
            <option value="">Выберите категорию</option>
            <?php foreach ($categories as $category): ?>
                <option value="<?= $category['category_id'] ?>" <?= $category['category_id'] == $product['category_id'] ? 'selected' : '' ?>>
                    <?= $category['category_name'] ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="supplier_id">Поставщик:</label>
        <select id="supplier_id" name="supplier_id" required>
            <option value="">Выберите поставщика</option>
            <?php foreach ($suppliers as $supplier): ?>
                <option value="<?= $supplier['supplier_id'] ?>" <?= $supplier['supplier_id'] == $product['supplier_id'] ? 'selected' : '' ?>>
                    <?= $supplier['supplier_name'] ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="unit_price">Цена:</label>
        <input type="number" id="unit_price" name="unit_price" step="0.01" value="<?= $product['unit_price'] ?>" required>
        <br>
        <label for="units_in_stock">Количество:</label>
        <input type="number" id="units_in_stock" name="units_in_stock" value="<?= $product['units_in_stock'] ?>" required>
        <br>
        <label for="description">Описание:</label>
        <textarea id="description" name="description"><?= $product['description'] ?></textarea>
        <br>
        <button type="submit">Сохранить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='products.php'">Назад</button>
    </div>
</body>
</html>