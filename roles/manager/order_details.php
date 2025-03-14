<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../../index.php");
    exit();
}

$order_id = $_GET['id'];

// Получаем данные заказа
$stmt = $pdo->prepare("
    SELECT o.order_id, c.first_name AS customer_name, e.first_name AS employee_name, o.order_date, o.total_amount 
    FROM trade_org.orders o
    JOIN trade_org.customers c ON o.customer_id = c.customer_id
    JOIN trade_org.employees e ON o.employee_id = e.employee_id
    WHERE o.order_id = :order_id
");
$stmt->execute(['order_id' => $order_id]);
$order = $stmt->fetch(PDO::FETCH_ASSOC);

// Получаем товары в заказе
$stmt = $pdo->prepare("
    SELECT od.order_detail_id, p.product_name, od.quantity, od.unit_price 
    FROM trade_org.order_details od
    JOIN trade_org.products p ON od.product_id = p.product_id
    WHERE od.order_id = :order_id
");
$stmt->execute(['order_id' => $order_id]);
$order_items = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Детали заказа</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Детали заказа #<?= $order['order_id'] ?></h1>
    <p><strong>Клиент:</strong> <?= $order['customer_name'] ?></p>
    <p><strong>Сотрудник:</strong> <?= $order['employee_name'] ?></p>
    <p><strong>Дата заказа:</strong> <?= $order['order_date'] ?></p>
    <p><strong>Сумма:</strong> <?= $order['total_amount'] ?></p>

    <h2>Товары в заказе</h2>
    <table>
        <tr>
            <th>Товар</th>
            <th>Количество</th>
            <th>Цена за единицу</th>
            <th>Сумма</th>
        </tr>
        <?php foreach ($order_items as $item): ?>
            <tr>
                <td><?= $item['product_name'] ?></td>
                <td><?= $item['quantity'] ?></td>
                <td><?= $item['unit_price'] ?></td>
                <td><?= $item['quantity'] * $item['unit_price'] ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
    <div class="link-container">
        <button class="link-button" onclick="location.href='orders.php'">Назад</button>
    </div>
</body>
</html>