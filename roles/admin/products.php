<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

// Фильтрация товаров
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "
    SELECT p.product_id, p.product_name, c.category_name, s.supplier_name, p.unit_price, p.units_in_stock, p.description 
    FROM trade_org.products p
    LEFT JOIN trade_org.categories c ON p.category_id = c.category_id
    LEFT JOIN trade_org.suppliers s ON p.supplier_id = s.supplier_id
";

if ($search) {
    $query .= " WHERE p.product_name ILIKE :search OR c.category_name ILIKE :search OR s.supplier_name ILIKE :search OR CAST(p.unit_price AS TEXT) ILIKE :search";
}

$query .= " ORDER BY p.product_name ASC";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список товаров</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список товаров</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по названию, категории, поставщику или цене" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="products.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Название</th>
                <th>Категория</th>
                <th>Поставщик</th>
                <th>Цена</th>
                <th>Количество</th>
                <th>Описание</th>
                <th>Действия</th>
            </tr>
            <?php if (count($products) > 0): ?>
                <?php foreach ($products as $product): ?>
                    <tr>
                        <td><?= $product['product_id'] ?></td>
                        <td><?= htmlspecialchars($product['product_name']) ?></td>
                        <td><?= htmlspecialchars($product['category_name']) ?></td>
                        <td><?= htmlspecialchars($product['supplier_name']) ?></td>
                        <td><?= number_format($product['unit_price'], 2, ',', ' ') ?> ₽</td>
                        <td><?= htmlspecialchars($product['units_in_stock']) ?></td>
                        <td><?= htmlspecialchars($product['description']) ?></td>
                        <td>
                            <a href="edit_product.php?id=<?= $product['product_id'] ?>" class="link-button">Редактировать</a>
                            <a href="delete_product.php?id=<?= $product['product_id'] ?>" class="link-button logout-button" onclick="return confirm('Вы уверены?')">Удалить</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="8" style="text-align:center; color: red;">Товары не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>
</body>
</html>
