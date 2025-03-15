<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Запросы к базе данных для статистики
$total_users = $pdo->query("SELECT COUNT(*) FROM trade_org.users")->fetchColumn();
$total_orders = $pdo->query("SELECT COUNT(*) FROM trade_org.orders")->fetchColumn();
$total_sales = $pdo->query("SELECT SUM(total_amount) FROM trade_org.orders")->fetchColumn();
$total_products = $pdo->query("SELECT COUNT(*) FROM trade_org.products")->fetchColumn();

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Общая статистика</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Общая статистика</h1>
        <div class="card">
            <h2>Пользователей в системе: <?= $total_users ?></h2>
        </div>
        <div class="card">
            <h2>Всего заказов: <?= $total_orders ?></h2>
        </div>
        <div class="card">
            <h2>Общая сумма продаж: <?= number_format($total_sales, 2, ',', ' ') ?> ₽</h2>
        </div>
        <div class="card">
            <h2>Всего товаров: <?= $total_products ?></h2>
        </div>
        <div class="link-container">
        <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
    </div>
    </div>
</body>
</html>
