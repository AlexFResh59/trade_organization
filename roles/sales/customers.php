<?php
session_start();
require_once '../../includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'sales') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация клиентов
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "SELECT * FROM trade_org.customers";

if ($search) {
    $query .= " WHERE last_name ILIKE :search OR first_name ILIKE :search OR email ILIKE :search OR phone ILIKE :search";
}

$query .= " ORDER BY last_name ASC";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список клиентов</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список клиентов</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по фамилии, имени, email или телефону" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="customers.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../sales.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Фамилия</th>
                <th>Имя</th>
                <th>Email</th>
                <th>Телефон</th>
            </tr>
            <?php if (count($customers) > 0): ?>
                <?php foreach ($customers as $customer): ?>
                    <tr>
                        <td><?= $customer['customer_id'] ?></td>
                        <td><?= htmlspecialchars($customer['last_name']) ?></td>
                        <td><?= htmlspecialchars($customer['first_name']) ?></td>
                        <td><?= htmlspecialchars($customer['email']) ?></td>
                        <td><?= htmlspecialchars($customer['phone']) ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6" style="text-align:center; color: red;">Клиенты не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>
</body>
</html>
