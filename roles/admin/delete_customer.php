<?php
session_start();
require_once 'includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Проверяем наличие ID клиента
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: customers.php");
    exit();
}

$customer_id = $_GET['id'];

// Проверяем, есть ли клиент
$stmt = $pdo->prepare("SELECT * FROM trade_org.customers WHERE customer_id = :customer_id");
$stmt->execute(['customer_id' => $customer_id]);
$customer = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$customer) {
    header("Location: customers.php");
    exit();
}

// Удаляем клиента
$delete_stmt = $pdo->prepare("DELETE FROM trade_org.customers WHERE customer_id = :customer_id");
$delete_stmt->execute(['customer_id' => $customer_id]);

header("Location: customers.php");
exit();
?>
