<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Фильтрация категорий
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "SELECT * FROM trade_org.categories";

if ($search) {
    $query .= " WHERE category_name ILIKE :search";
}

$query .= " ORDER BY category_name ASC";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список категорий</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список категорий</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по названию категории" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="categories.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Название категории</th>
                <th>Действия</th>
            </tr>
            <?php if (count($categories) > 0): ?>
                <?php foreach ($categories as $category): ?>
                    <tr>
                        <td><?= $category['category_id'] ?></td>
                        <td><?= htmlspecialchars($category['category_name']) ?></td>
                        <td>
                            <button class="link-button" onclick="location.href='edit_category.php?id=<?= $category['category_id'] ?>'">Редактировать</button>
                            <button class="link-button logout-button" onclick="confirmDelete(<?= $category['category_id'] ?>)">Удалить</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="3" style="text-align:center; color: red;">Категории не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>

    <script>
        function confirmDelete(id) {
            if (confirm("Вы уверены, что хотите удалить категорию?")) {
                window.location.href = 'delete_category.php?id=' + id;
            }
        }
    </script>
</body>
</html>
