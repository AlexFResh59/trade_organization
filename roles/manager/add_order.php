<?php
session_start();
require_once 'includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../index.php");
    exit();
}

// Получаем список клиентов и сотрудников
$customers = $pdo->query("SELECT customer_id, first_name, last_name FROM trade_org.customers")->fetchAll(PDO::FETCH_ASSOC);
$employees = $pdo->query("SELECT employee_id, first_name, last_name FROM trade_org.employees")->fetchAll(PDO::FETCH_ASSOC);

// Обработка формы
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $customer_id = $_POST['customer_id'];
    $employee_id = $_POST['employee_id'];
    $order_date = $_POST['order_date'];
    $total_amount = $_POST['total_amount'];

    // Валидация данных
    if (empty($customer_id) || empty($order_date) || empty($total_amount)) {
        $error = "Все поля обязательны для заполнения!";
    } else {
        // Добавление заказа в базу данных
        $stmt = $pdo->prepare("
            INSERT INTO trade_org.orders (customer_id, employee_id, order_date, total_amount)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$customer_id, $employee_id, $order_date, $total_amount]);

        // Перенаправление на страницу списка заказов
        header("Location: orders.php");
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить заказ</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Добавить заказ</h1>

    <?php if (isset($error)): ?>
        <p style="color: red;"><?= $error ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="customer_id">Клиент:</label>
        <select id="customer_id" name="customer_id" required>
            <option value="">Выберите клиента</option>
            <?php foreach ($customers as $customer): ?>
                <option value="<?= $customer['customer_id'] ?>"><?= $customer['first_name'] ?> <?= $customer['last_name'] ?></option>
            <?php endforeach; ?>
        </select><br>

        <label for="employee_id">Менеджер:</label>
        <select id="employee_id" name="employee_id">
            <option value="">Выберите менеджера</option>
            <?php foreach ($employees as $employee): ?>
                <option value="<?= $employee['employee_id'] ?>"><?= $employee['first_name'] ?> <?= $employee['last_name'] ?></option>
            <?php endforeach; ?>
        </select><br>

        <label for="order_date">Дата заказа:</label>
        <input type="date" id="order_date" name="order_date" required><br>

        <label for="total_amount">Сумма:</label>
        <input type="number" step="0.01" id="total_amount" name="total_amount" required><br>

        <button type="submit">Добавить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='../manager.php'">Назад</button>
    </div>
</body>
</html>