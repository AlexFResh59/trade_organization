<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../../index.php");
    exit();
}

// Фильтрация заказов
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "
    SELECT o.order_id, c.first_name AS customer_name, e.first_name AS employee_name, o.order_date, o.total_amount 
    FROM trade_org.orders o
    JOIN trade_org.customers c ON o.customer_id = c.customer_id
    JOIN trade_org.employees e ON o.employee_id = e.employee_id
";

if ($search) {
    $query .= " WHERE c.first_name ILIKE :search OR e.first_name ILIKE :search OR o.order_date::TEXT ILIKE :search";
}

$query .= " ORDER BY o.order_date";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список заказов</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список заказов</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по клиенту, сотруднику или дате" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="orders.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../manager.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Клиент</th>
                <th>Сотрудник</th>
                <th>Дата заказа</th>
                <th>Сумма</th>
                <th>Действия</th>
            </tr>
            <?php if (count($orders) > 0): ?>
                <?php foreach ($orders as $order): ?>
                    <tr>
                        <td><?= $order['order_id'] ?></td>
                        <td><?= htmlspecialchars($order['customer_name']) ?></td>
                        <td><?= htmlspecialchars($order['employee_name']) ?></td>
                        <td><?= htmlspecialchars($order['order_date']) ?></td>
                        <td><?= number_format($order['total_amount'], 2, ',', ' ') ?> ₽</td>
                        <td>
                            <a href="edit_order.php?id=<?= $order['order_id'] ?>" class="link-button">Редактировать</a>
                            <a href="delete_order.php?id=<?= $order['order_id'] ?>" class="link-button logout-button" onclick="return confirm('Вы уверены?')">Удалить</a>
                            <a href="order_details.php?id=<?= $order['order_id'] ?>" class="link-button">Детали</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6" style="text-align:center; color: red;">Заказы не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>
</body>
</html>
