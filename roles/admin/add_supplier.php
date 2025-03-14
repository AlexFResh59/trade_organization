<?php
session_start();
require_once 'includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Обработка формы
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $supplier_name = trim($_POST['supplier_name']);
    $contact_name = trim($_POST['contact_name']);
    $phone = trim($_POST['phone']);
    $email = trim($_POST['email']);

    if ($supplier_name && $contact_name && $phone && $email) {
        $stmt = $pdo->prepare("INSERT INTO trade_org.suppliers (supplier_name, contact_name, phone, email) VALUES (:supplier_name, :contact_name, :phone, :email)");
        $stmt->execute([
            'supplier_name' => $supplier_name,
            'contact_name' => $contact_name,
            'phone' => $phone,
            'email' => $email
        ]);

        header("Location: suppliers.php");
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
    <title>Добавить поставщика</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Добавить поставщика</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название компании:</label>
            <input type="text" name="supplier_name" required>
            
            <label>Контактное лицо:</label>
            <input type="text" name="contact_name" required>
            
            <label>Телефон:</label>
            <input type="text" name="phone" required>
            
            <label>Email:</label>
            <input type="email" name="email" required>
            
            <button class="link-button" type="submit">Добавить</button>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
    </div>
</body>
</html>
