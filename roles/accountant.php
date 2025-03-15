<?php
session_start();
require_once '../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'accountant') {
    header("Location: ../index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Панель бухгалтера</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Добро пожаловать, бухгалтер!</h1>
    <h2>Финансовые отчёты</h2>
    <div class="link-container">
        <button class="link-button" onclick="location.href='accountant/reports.php'">Отчёты по заказам</button>
        <button class="link-button" onclick="location.href='accountant/profit.php'">Прибыль</button>
        <button class="link-button logout-button" onclick="location.href='../logout.php'">Выйти</button>
    </div>
</body>
</html>