<?php
session_start();
require_once '../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Панель менеджера</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Добро пожаловать, менеджер!</h1>
    <h2>Анализ продаж</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='manager/statistics.php'">Статистика</button>
    </div>
    <h2>Управление товарами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='manager/products.php'">Список товаров</button>
    </div>
    <h2>Складские запасы</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='manager/warehouses.php'">Список складов</button>
    </div>
    <h2>Управление заказами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='manager/orders.php'">Список заказов</button>
        <button class="link-button" onclick="location.href='manager/add_order.php'">Добавить заказ</button>
    </div>
    <h2>Управление клиентами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='manager/customers.php'">Список клиентов</button>
        <button class="link-button" onclick="location.href='manager/add_customer.php'">Добавить клиента</button>
    </div>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../logout.php'">Выйти</button>
    </div>
</body>
</html>