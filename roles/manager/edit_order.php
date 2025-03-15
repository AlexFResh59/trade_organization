<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../../index.php");
    exit();
}

$order_id = $_GET['id'];

// Получаем данные заказа
$stmt = $pdo->prepare("
    SELECT o.order_id, o.customer_id, o.employee_id, o.order_date, o.total_amount 
    FROM trade_org.orders o
    WHERE o.order_id = :order_id
");
$stmt->execute(['order_id' => $order_id]);
$order = $stmt->fetch(PDO::FETCH_ASSOC);

// Получаем список клиентов и сотрудников
$customers = $pdo->query("SELECT customer_id, first_name, last_name FROM trade_org.customers")->fetchAll(PDO::FETCH_ASSOC);
$employees = $pdo->query("SELECT employee_id, first_name, last_name FROM trade_org.employees")->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $customer_id = $_POST['customer_id'];
    $employee_id = $_POST['employee_id'];
    $order_date = $_POST['order_date'];
    $total_amount = $_POST['total_amount'];

    // Обновляем данные заказа
    $stmt = $pdo->prepare("
        UPDATE trade_org.orders 
        SET customer_id = :customer_id, employee_id = :employee_id, order_date = :order_date, total_amount = :total_amount 
        WHERE order_id = :order_id
    ");
    $stmt->execute([
        'customer_id' => $customer_id,
        'employee_id' => $employee_id,
        'order_date' => $order_date,
        'total_amount' => $total_amount,
        'order_id' => $order_id
    ]);

    header("Location: orders.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактировать заказ</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Редактировать заказ</h1>
    <form method="POST">
        <label for="customer_id">Клиент:</label>
        <select id="customer_id" name="customer_id" required>
            <?php foreach ($customers as $customer): ?>
                <option value="<?= $customer['customer_id'] ?>" <?= $customer['customer_id'] == $order['customer_id'] ? 'selected' : '' ?>>
                    <?= $customer['first_name'] . ' ' . $customer['last_name'] ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="employee_id">Сотрудник:</label>
        <select id="employee_id" name="employee_id" required>
            <?php foreach ($employees as $employee): ?>
                <option value="<?= $employee['employee_id'] ?>" <?= $employee['employee_id'] == $order['employee_id'] ? 'selected' : '' ?>>
                    <?= $employee['first_name'] . ' ' . $employee['last_name'] ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="order_date">Дата заказа:</label>
        <input type="date" id="order_date" name="order_date" value="<?= $order['order_date'] ?>" required>
        <br>
        <label for="total_amount">Сумма:</label>
        <input type="number" id="total_amount" name="total_amount" step="0.01" value="<?= $order['total_amount'] ?>" required>
        <br>
        <button type="submit">Сохранить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='orders.php'">Назад</button>
    </div>
</body>
</html>