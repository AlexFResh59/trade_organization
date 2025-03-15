<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Получаем ID поставщика из GET-запроса
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: suppliers.php");
    exit();
}

$supplier_id = $_GET['id'];

// Получаем текущие данные поставщика
$stmt = $pdo->prepare("SELECT * FROM trade_org.suppliers WHERE supplier_id = :supplier_id");
$stmt->execute(['supplier_id' => $supplier_id]);
$supplier = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$supplier) {
    header("Location: suppliers.php");
    exit();
}

// Обработка формы обновления
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $supplier_name = trim($_POST['supplier_name']);
    $contact_name = trim($_POST['contact_name']);
    $phone = trim($_POST['phone']);
    $email = trim($_POST['email']);

    if ($supplier_name && $contact_name && $phone && $email) {
        $update_stmt = $pdo->prepare("UPDATE trade_org.suppliers SET supplier_name = :supplier_name, contact_name = :contact_name, phone = :phone, email = :email WHERE supplier_id = :supplier_id");
        $update_stmt->execute([
            'supplier_name' => $supplier_name,
            'contact_name' => $contact_name,
            'phone' => $phone,
            'email' => $email,
            'supplier_id' => $supplier_id
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
    <title>Редактировать поставщика</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Редактировать поставщика</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название компании:</label>
            <input type="text" name="supplier_name" value="<?= htmlspecialchars($supplier['supplier_name']) ?>" required>
            
            <label>Контактное лицо:</label>
            <input type="text" name="contact_name" value="<?= htmlspecialchars($supplier['contact_name']) ?>" required>
            
            <label>Телефон:</label>
            <input type="text" name="phone" value="<?= htmlspecialchars($supplier['phone']) ?>" required>
            
            <label>Email:</label>
            <input type="email" name="email" value="<?= htmlspecialchars($supplier['email']) ?>" required>
            
            <button class="link-button" type="submit">Сохранить изменения</button>
        </form>

        <div class="link-container">
            <button class="link-button" onclick="location.href='suppliers.php'">Назад</button>
        </div>
    </div>
</body>
</html>
