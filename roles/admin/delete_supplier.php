<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли администратора
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.php");
    exit();
}

// Проверяем наличие ID поставщика
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    header("Location: suppliers.php");
    exit();
}

$supplier_id = $_GET['id'];

// Проверка наличия поставщика перед удалением
$stmt = $pdo->prepare("SELECT * FROM trade_org.suppliers WHERE supplier_id = :supplier_id");
$stmt->execute(['supplier_id' => $supplier_id]);
$supplier = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$supplier) {
    header("Location: suppliers.php");
    exit();
}

// Удаляем поставщика
$delete_stmt = $pdo->prepare("DELETE FROM trade_org.suppliers WHERE supplier_id = :supplier_id");
$delete_stmt->execute(['supplier_id' => $supplier_id]);

header("Location: suppliers.php");
exit();
?>
