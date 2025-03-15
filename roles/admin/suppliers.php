<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация поставщиков
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "SELECT * FROM trade_org.suppliers";

if ($search) {
    $query .= " WHERE supplier_name ILIKE :search OR contact_name ILIKE :search OR phone ILIKE :search OR email ILIKE :search";
}

$query .= " ORDER BY supplier_name ASC";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$suppliers = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список поставщиков</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список поставщиков</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по названию, контактному лицу, телефону или email" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="suppliers.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Название</th>
                <th>Контактное лицо</th>
                <th>Телефон</th>
                <th>Email</th>
                <th>Действия</th>
            </tr>
            <?php if (count($suppliers) > 0): ?>
                <?php foreach ($suppliers as $supplier): ?>
                    <tr>
                        <td><?= $supplier['supplier_id'] ?></td>
                        <td><?= htmlspecialchars($supplier['supplier_name']) ?></td>
                        <td><?= htmlspecialchars($supplier['contact_name']) ?></td>
                        <td><?= htmlspecialchars($supplier['phone']) ?></td>
                        <td><?= htmlspecialchars($supplier['email']) ?></td>
                        <td>
                            <button class="link-button" onclick="location.href='edit_supplier.php?id=<?= $supplier['supplier_id'] ?>'">Редактировать</button>
                            <button class="link-button logout-button" onclick="confirmDelete(<?= $supplier['supplier_id'] ?>)">Удалить</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6" style="text-align:center; color: red;">Поставщики не найдены</td>
                </tr>
            <?php endif; ?>
        </table>  
    </div>
    <script>
        function confirmDelete(id) {
            if (confirm("Вы уверены, что хотите удалить поставщика?")) {
                window.location.href = 'delete_supplier.php?id=' + id;
            }
        }
    </script>
</body>
</html>
