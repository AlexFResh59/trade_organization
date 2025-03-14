<?php
session_start();
require_once 'includes/db.php';

// Проверка роли менеджера
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация по дате (по умолчанию текущий месяц)
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : date('Y-m-01');
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : date('Y-m-d');

// Получение количества заказов за период
$stmt = $pdo->prepare("SELECT COUNT(*) AS total_orders FROM trade_org.orders WHERE order_date BETWEEN :start_date AND :end_date");
$stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);
$total_orders = $stmt->fetch(PDO::FETCH_ASSOC)['total_orders'];

// Получение общего дохода за период
$stmt = $pdo->prepare("SELECT SUM(total_amount) AS total_revenue FROM trade_org.orders WHERE order_date BETWEEN :start_date AND :end_date");
$stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);
$total_revenue = $stmt->fetch(PDO::FETCH_ASSOC)['total_revenue'] ?? 0;

// Получение топ-5 клиентов по количеству заказов
$stmt = $pdo->prepare("
    SELECT c.first_name, c.last_name, COUNT(o.order_id) AS order_count 
    FROM trade_org.orders o
    JOIN trade_org.customers c ON o.customer_id = c.customer_id
    WHERE o.order_date BETWEEN :start_date AND :end_date
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY order_count DESC
    LIMIT 5
");
$stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);
$top_customers = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Анализ продаж</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Анализ продаж</h1>
        <form method="GET" class="search-form">
            <label>С начала:</label>
            <input type="date" name="start_date" value="<?= $start_date ?>" required>
            <label>По:</label>
            <input type="date" name="end_date" value="<?= $end_date ?>" required>
            <button type="submit" class="link-button">Фильтровать</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../manager.php'">Назад</button>
        </div>

        <div class="stats-container">
            <div class="card">
                <h2>Заказов за период:</h2>
                <p><?= $total_orders ?></p>
            </div>
            <div class="card">
                <h2>Общий доход:</h2>
                <p><?= number_format($total_revenue, 2, ',', ' ') ?> ₽</p>
            </div>
        </div>

        <!-- Топ-5 клиентов -->
        <h2>Топ-5 клиентов по заказам</h2>
        <table>
            <tr>
                <th>Имя</th>
                <th>Фамилия</th>
                <th>Количество заказов</th>
            </tr>
            <?php foreach ($top_customers as $customer): ?>
                <tr>
                    <td><?= htmlspecialchars($customer['first_name']) ?></td>
                    <td><?= htmlspecialchars($customer['last_name']) ?></td>
                    <td><?= $customer['order_count'] ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>
