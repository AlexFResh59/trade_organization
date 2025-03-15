<?php
session_start();
require_once '../../includes/db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Проверяем наличие ID склада
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: warehouses.php");
    exit();
}

$warehouse_id = $_GET['id'];

// Проверяем, есть ли такой склад
$stmt = $pdo->prepare("SELECT * FROM trade_org.warehouses WHERE warehouse_id = :warehouse_id");
$stmt->execute(['warehouse_id' => $warehouse_id]);
$warehouse = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$warehouse) {
    header("Location: warehouses.php");
    exit();
}

// Удаляем склад
$delete_stmt = $pdo->prepare("DELETE FROM trade_org.warehouses WHERE warehouse_id = :warehouse_id");
$delete_stmt->execute(['warehouse_id' => $warehouse_id]);

header("Location: warehouses.php");
exit();
?>
