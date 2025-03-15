<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

$product_id = $_GET['id'];

// Удаляем товар
$stmt = $pdo->prepare("DELETE FROM trade_org.products WHERE product_id = :product_id");
$stmt->execute(['product_id' => $product_id]);

header("Location: products.php");
exit();
?>