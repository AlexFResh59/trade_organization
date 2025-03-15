<?php
session_start();
require_once '../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'warehouse') {
    header("Location: ../index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Панель кладовщика</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Добро пожаловать, кладовщик!</h1>
    <h2>Управление инвентаризацией</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='warehouse/inventory.php'">Список товаров на складе</button>
        <button class="link-button" onclick="location.href='warehouse/add_inventory.php'">Добавить товар на склад</button>
    </div>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../logout.php'">Выйти</button>
    </div>
</body>
</html>