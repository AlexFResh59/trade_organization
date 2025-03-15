<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'warehouse') {
    header("Location: ../index.php");
    exit();
}

// Получение параметра поиска
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

// Запрос товаров на складе с возможностью поиска
$query = "
    SELECT i.inventory_id, p.product_name, w.warehouse_name, i.quantity
    FROM trade_org.inventory i
    JOIN trade_org.products p ON i.product_id = p.product_id
    JOIN trade_org.warehouses w ON i.warehouse_id = w.warehouse_id
    WHERE 1=1
";

$params = [];
if ($search) {
    $query .= " AND (p.product_name ILIKE :search OR w.warehouse_name ILIKE :search)";
    $params['search'] = "%$search%";
}

$query .= " ORDER BY i.inventory_id";
$stmt = $pdo->prepare($query);
$stmt->execute($params);
$inventory = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список товаров на складе</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Список товаров на складе</h1>

    <!-- Форма поиска -->
    <form method="GET" class="search-form">
        <input type="text" name="search" placeholder="Поиск по товару или складу" value="<?= htmlspecialchars($search) ?>">
        <button type="submit" class="link-button">Поиск</button>
        <?php if ($search): ?>
            <a href="inventory.php" class="link-button logout-button">Сброс</a>
        <?php endif; ?>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../warehouse.php'">Назад</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Товар</th>
                <th>Склад</th>
                <th>Количество</th>
            </tr>
        </thead>
        <tbody>
            <?php if (count($inventory) > 0): ?>
                <?php foreach ($inventory as $item): ?>
                    <tr>
                        <td><?= $item['inventory_id'] ?></td>
                        <td><?= htmlspecialchars($item['product_name']) ?></td>
                        <td><?= htmlspecialchars($item['warehouse_name']) ?></td>
                        <td><?= htmlspecialchars($item['quantity']) ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="4" style="text-align:center; color: red;">Ничего не найдено</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</body>
</html>
