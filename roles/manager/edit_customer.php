<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'manager') {
    header("Location: ../../index.php");
    exit();
}

$customer_id = $_GET['id'];

// Получаем данные клиента
$stmt = $pdo->prepare("SELECT * FROM trade_org.customers WHERE customer_id = :customer_id");
$stmt->execute(['customer_id' => $customer_id]);
$customer = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];

    // Обновляем данные клиента
    $stmt = $pdo->prepare("
        UPDATE trade_org.customers 
        SET first_name = :first_name, last_name = :last_name, email = :email, phone = :phone, address = :address 
        WHERE customer_id = :customer_id
    ");
    $stmt->execute([
        'first_name' => $first_name,
        'last_name' => $last_name,
        'email' => $email,
        'phone' => $phone,
        'address' => $address,
        'customer_id' => $customer_id
    ]);

    header("Location: customers.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактировать клиента</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <h1>Редактировать клиента</h1>
    <form method="POST">
        <label for="first_name">Имя:</label>
        <input type="text" id="first_name" name="first_name" value="<?= $customer['first_name'] ?>" required>
        <br>
        <label for="last_name">Фамилия:</label>
        <input type="text" id="last_name" name="last_name" value="<?= $customer['last_name'] ?>" required>
        <br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<?= $customer['email'] ?>">
        <br>
        <label for="phone">Телефон:</label>
        <input type="text" id="phone" name="phone" value="<?= $customer['phone'] ?>">
        <br>
        <label for="address">Адрес:</label>
        <textarea id="address" name="address"><?= $customer['address'] ?></textarea>
        <br>
        <button type="submit">Сохранить</button>
    </form>
    <div class="link-container">
        <button class="link-button" onclick="location.href='customers.php'">Назад</button>
    </div>
</body>
</html>