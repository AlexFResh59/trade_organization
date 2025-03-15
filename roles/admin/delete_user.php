<?php
session_start();
require_once '../../includes/db.php';

// Проверка роли
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../../index.php");
    exit();
}

$user_id = $_GET['id'];

// Удаляем пользователя
$stmt = $pdo->prepare("DELETE FROM trade_org.users WHERE user_id = :user_id");
$stmt->execute(['user_id' => $user_id]);

header("Location: users.php");
exit();
?>