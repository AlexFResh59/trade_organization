<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

// Фильтрация пользователей
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

$query = "SELECT * FROM trade_org.users";

if ($search) {
    $query .= " WHERE username ILIKE :search OR role ILIKE :search OR CAST(created_at AS TEXT) ILIKE :search";
}

$query .= " ORDER BY created_at";
$stmt = $pdo->prepare($query);

if ($search) {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}

$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список пользователей</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Список пользователей</h1>

        <!-- Форма поиска -->
        <form method="GET" class="search-form">
            <input type="text" name="search" placeholder="Поиск по логину, роли или дате создания" value="<?= htmlspecialchars($search) ?>">
            <button type="submit" class="link-button">Поиск</button>
            <?php if ($search): ?>
                <a href="users.php" class="link-button logout-button">Сброс</a>
            <?php endif; ?>
        </form>
        <div class="link-container">
            <button class="link-button" onclick="location.href='../admin.php'">Назад</button>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Логин</th>
                <th>Роль</th>
                <th>Дата создания</th>
                <th>Действия</th>
            </tr>
            <?php if (count($users) > 0): ?>
                <?php foreach ($users as $user): ?>
                    <tr>
                        <td><?= $user['user_id'] ?></td>
                        <td><?= htmlspecialchars($user['username']) ?></td>
                        <td><?= htmlspecialchars($user['role']) ?></td>
                        <td><?= htmlspecialchars($user['created_at']) ?></td>
                        <td>
                            <a href="edit_user.php?id=<?= $user['user_id'] ?>" class="link-button">Редактировать</a>
                            <a href="delete_user.php?id=<?= $user['user_id'] ?>" class="link-button logout-button" onclick="return confirm('Вы уверены?')">Удалить</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="5" style="text-align:center; color: red;">Пользователи не найдены</td>
                </tr>
            <?php endif; ?>
        </table>
    </div>
</body>
</html>
