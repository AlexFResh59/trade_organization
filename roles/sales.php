<?php
session_start();
require_once '../includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'sales') {
    header("Location: ../index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Панель продавца</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Добро пожаловать, продавец!</h1>
    <h2>Список товаров</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='sales/products.php'">Список товаров</button>
    </div>
    <h2>Просмотр клиентов</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='sales/customers.php'">Список клиентов</button>
    </div>
    <h2>Просмотр заказов</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='sales/orders.php'">Список заказов</button>
        <button class="link-button" onclick="location.href='sales/add_order.php'">Добавить заказ</button>
    </div>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../logout.php'">Выйти</button>
    </div>
</body>
</html> 