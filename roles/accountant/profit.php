<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'accountant') {
    header("Location: ../index.php");
    exit();
}

// Получаем общую сумму всех заказов (выручка)
$total_revenue = $pdo->query("SELECT SUM(total_amount) AS total FROM trade_org.orders")->fetchColumn();

// Получаем общую сумму зарплат сотрудников (расходы)
$total_salary = $pdo->query("SELECT SUM(salary) AS total FROM trade_org.employees")->fetchColumn();

// Рассчитываем чистую прибыль
$net_profit = $total_revenue - $total_salary;
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Прибыль</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Прибыль</h1>

    <h2>Общая выручка: <?= $total_revenue ?> руб.</h2>
    <h2>Общие расходы (зарплаты): <?= $total_salary ?> руб.</h2>
    <h2>Чистая прибыль: <?= $net_profit ?> руб.</h2>

    <div class="link-container">
        <button class="link-button" onclick="location.href='../accountant.php'">Назад</button>
    </div>
</body>
</html>