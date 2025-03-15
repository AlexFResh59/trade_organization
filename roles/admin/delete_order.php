<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

$order_id = $_GET['id'];

// Удаляем заказ
$stmt = $pdo->prepare("DELETE FROM trade_org.orders WHERE order_id = :order_id");
$stmt->execute(['order_id' => $order_id]);

header("Location: orders.php");
exit();
?>