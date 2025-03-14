<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация заказов по дате
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : date('Y-m-01');
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : date('Y-m-d');

$stmt = $pdo->prepare("SELECT o.order_id, c.first_name, c.last_name, o.order_date, o.total_amount 
                       FROM trade_org.orders o 
                       JOIN trade_org.customers c ON o.customer_id = c.customer_id
                       WHERE o.order_date BETWEEN :start_date AND :end_date
                       ORDER BY o.order_date");
$stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);
$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">  
    <title>Генерация отчётов</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Генерация отчётов</h1>

        <!-- Форма выбора дат -->
        <form method="GET">
            <label>С начала:</label>
            <input type="date" name="start_date" value="<?= $start_date ?>" required>
            <label>По:</label>
            <input type="date" name="end_date" value="<?= $end_date ?>" required>
            <button class="link-button" type="submit">Фильтровать</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
        <!-- Таблица заказов -->
        <table>
            <tr>
                <th>ID заказа</th>
                <th>Клиент</th>
                <th>Дата</th>
                <th>Сумма</th>
            </tr>
            <?php foreach ($orders as $order): ?>
                <tr>
                    <td><?= $order['order_id'] ?></td>
                    <td><?= $order['first_name'] . ' ' . $order['last_name'] ?></td>
                    <td><?= $order['order_date'] ?></td>
                    <td><?= number_format($order['total_amount'], 2, ',', ' ') ?> ₽</td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>
