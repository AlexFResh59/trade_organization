<?php
session_start();
require_once '../../includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Получаем ID склада
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: warehouses.php");
    exit();
}

$warehouse_id = $_GET['id'];

// Получаем текущие данные склада
$stmt = $pdo->prepare("SELECT * FROM trade_org.warehouses WHERE warehouse_id = :warehouse_id");
$stmt->execute(['warehouse_id' => $warehouse_id]);
$warehouse = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$warehouse) {
    header("Location: warehouses.php");
    exit();
}

// Обработка формы обновления
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $warehouse_name = trim($_POST['warehouse_name']);
    $address = trim($_POST['address']);

    if (!empty($warehouse_name) && !empty($address)) {
        $update_stmt = $pdo->prepare("UPDATE trade_org.warehouses SET warehouse_name = :warehouse_name, address = :address WHERE warehouse_id = :warehouse_id");
        $update_stmt->execute([
            'warehouse_name' => $warehouse_name,
            'address' => $address,
            'warehouse_id' => $warehouse_id
        ]);

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
    <title>Редактировать склад</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Редактировать склад</h1>

        <?php if (isset($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST">
            <label>Название склада:</label>
            <input type="text" name="warehouse_name" value="<?= htmlspecialchars($warehouse['warehouse_name']) ?>" required>
            
            <label>Адрес:</label>
            <input type="text" name="address" value="<?= htmlspecialchars($warehouse['address']) ?>" required>
            
            <button class="link-button" type="submit">Сохранить</button>
        </form>

        <div class="link-container">
            <button class="link-button" onclick="location.href='warehouses.php'">Назад</button>
        </div>
    </div>
</body>
</html>
