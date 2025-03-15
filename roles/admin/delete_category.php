<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Проверяем наличие ID категории
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: categories.php");
    exit();
}

$category_id = $_GET['id'];

// Проверка наличия категории
$stmt = $pdo->prepare("SELECT * FROM trade_org.categories WHERE category_id = :category_id");
$stmt->execute(['category_id' => $category_id]);
$category = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$category) {
    header("Location: categories.php");
    exit();
}

// Удаляем категорию
$delete_stmt = $pdo->prepare("DELETE FROM trade_org.categories WHERE category_id = :category_id");
$delete_stmt->execute(['category_id' => $category_id]);

header("Location: categories.php");
exit();
?>
