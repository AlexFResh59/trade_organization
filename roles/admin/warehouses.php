<?php
session_start();
require_once 'includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация складов
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "SELECT * FROM trade_org.warehouses";

if ($search) {
    $query .= " WHERE warehouse_name ILIKE :search OR address ILIKE :search";
}

$query .= " ORDER BY warehouse_name ASC";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$warehouses = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список складов</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список складов</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по названию склада или адресу" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="warehouses.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Название склада</th>
                <th>Адрес</th>
                <th>Действия</th>
            </tr>
            <?php if (count($warehouses) > 0): ?>
                <?php foreach ($warehouses as $warehouse): ?>
                    <tr>
                        <td><?= $warehouse['warehouse_id'] ?></td>
                        <td><?= htmlspecialchars($warehouse['warehouse_name']) ?></td>
                        <td><?= htmlspecialchars($warehouse['address']) ?></td>
                        <td>
                            <button class="link-button" onclick="location.href='edit_warehouse.php?id=<?= $warehouse['warehouse_id'] ?>'">Редактировать</button>
                            <button class="link-button logout-button" onclick="confirmDelete(<?= $warehouse['warehouse_id'] ?>)">Удалить</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="4" style="text-align:center; color: red;">Склады не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>
    <script>
        function confirmDelete(id) {
            if (confirm("Вы уверены, что хотите удалить склад?")) {
                window.location.href = 'delete_warehouse.php?id=' + id;
            }
        }
    </script>
</body>
</html>
