<?php
session_start();
require_once '../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Панель администратора</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Добро пожаловать, администратор!</h1>
    <h2>Управление заказами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/orders.php'">Список заказов</button>
    </div>
    <h2>Управление клиентами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/customers.php'">Список клиентов</button>
    </div>
    <h2>Управление товарами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/products.php'">Список товаров</button>
        <button class="link-button" onclick="location.href='admin/add_product.php'">Добавить товар</button>
    </div>
    <h2>Управление складами</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/warehouses.php'">Список складов</button>
        <button class="link-button" onclick="location.href='admin/add_warehouse.php'">Добавить склад</button>
    </div>
    <h2>Статистика и отчёты</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/statistics.php'">Общая статистика</button>
        <button class="link-button" onclick="location.href='admin/reports.php'">Генерация отчётов</button>
    </div>
    <h2>Управление категориями товаров</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/categories.php'">Список категорий</button>
        <button class="link-button" onclick="location.href='admin/add_category.php'">Добавить категорию</button>
    </div>
    <h2>Управление поставщиками</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/suppliers.php'">Список поставщиков</button>
        <button class="link-button" onclick="location.href='admin/add_supplier.php'">Добавить поставщика</button>
    </div>
    <h2>Управление пользователями</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='admin/users.php'">Список пользователей</button>
        <button class="link-button" onclick="location.href='admin/add_user.php'">Добавить пользователя</button>
    </div>    
    
    <div class="link-container">
        <button class="link-button" onclick="location.href='../logout.php'">Выйти</button>
    </div>
</body>
</html>