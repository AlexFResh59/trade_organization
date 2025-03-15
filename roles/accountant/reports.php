<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'accountant') {
    header("Location: ../index.php");
    exit();
}

// Получаем финансовые отчёты по заказам
$orders = $pdo->query("
    SELECT o.order_id, o.order_date, o.total_amount, c.first_name, c.last_name
    FROM trade_org.orders o
    JOIN trade_org.customers c ON o.customer_id = c.customer_id
    ORDER BY o.order_date
")->fetchAll(PDO::FETCH_ASSOC);

// Общая сумма всех заказов
$total_revenue = $pdo->query("SELECT SUM(total_amount) AS total FROM trade_org.orders")->fetchColumn();
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Отчёты по заказам</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Отчёты по заказам</h1>

    <h2>Общая сумма всех заказов: <?= $total_revenue ?> руб.</h2>

    <table>
        <thead>
            <tr>
                <th>ID заказа</th>
                <th>Дата заказа</th>
                <th>Сумма</th>
                <th>Клиент</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($orders as $order): ?>
            <tr>
                <td><?= $order['order_id'] ?></td>
                <td><?= $order['order_date'] ?></td>
                <td><?= $order['total_amount'] ?> руб.</td>
                <td><?= $order['first_name'] ?> <?= $order['last_name'] ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <div class="link-container">
        <button class="link-button" onclick="location.href='../accountant.php'">Назад</button>
    </div>
</body>
</html>