<?php
session_start();
require_once 'includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Получаем ID клиента
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: customers.php");
    exit();
}

$customer_id = $_GET['id'];

// Получаем данные клиента
$stmt = $pdo->prepare("SELECT * FROM trade_org.customers WHERE customer_id = :customer_id");
$stmt->execute(['customer_id' => $customer_id]);
$customer = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$customer) {
    header("Location: customers.php");
    exit();
}

// Обработка формы обновления
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $first_name = trim($_POST['first_name']);
    $last_name = trim($_POST['last_name']);
    $email = trim($_POST['email']);
    $phone = trim($_POST['phone']);

    if (!empty($first_name) && !empty($last_name) && !empty($email) && !empty($phone)) {
        $update_stmt = $pdo->prepare("UPDATE trade_org.customers SET first_name = :first_name, last_name = :last_name, email = :email, phone = :phone WHERE customer_id = :customer_id");
        $update_stmt->execute([
            'first_name' => $first_name,
            'last_name' => $last_name,
            'email' => $email,
            'phone' => $phone,
            'customer_id' => $customer_id
        ]);

        header("Location: customers.php");
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
    <title>Редактировать клиента</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Редактировать клиента</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Имя:</label>
            <input type="text" name="first_name" value="<?= htmlspecialchars($customer['first_name']) ?>" required>

            <label>Фамилия:</label>
            <input type="text" name="last_name" value="<?= htmlspecialchars($customer['last_name']) ?>" required>
            
            <label>Email:</label>
            <input type="email" name="email" value="<?= htmlspecialchars($customer['email']) ?>" required>
            
            <label>Телефон:</label>
            <input type="text" name="phone" value="<?= htmlspecialchars($customer['phone']) ?>" required>
            
            <button class="link-button" type="submit">Сохранить</button>
        </form>

        <div class="link-container">
            <button class="link-button" onclick="location.href='customers.php'">Назад</button>
        </div>
    </div>
</body>
</html>
