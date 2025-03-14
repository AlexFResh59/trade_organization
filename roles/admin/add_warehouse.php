<?php
session_start();
require_once 'includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $warehouse_name = trim($_POST['warehouse_name']);
    $address = trim($_POST['address']);

    if (!empty($warehouse_name) && !empty($address)) {
        $stmt = $pdo->prepare("INSERT INTO trade_org.warehouses (warehouse_name, address) VALUES (:warehouse_name, :address)");
        $stmt->execute(['warehouse_name' => $warehouse_name, 'address' => $address]);

        header("Location: warehouses.php");
        exit();
    } else {
        $error = "Заполните все поля!";
    }
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить склад</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Добавить склад</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название склада:</label>
            <input type="text" name="warehouse_name" required>
            
            <label>Адрес:</label>
            <input type="text" name="address" required>
            
            <button class="link-button" type="submit">Добавить</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
    </div>
</body>
</html>
