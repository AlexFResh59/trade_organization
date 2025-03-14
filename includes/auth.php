<?php
function authenticateUser($username, $password, $pdo) {
    // Подготовка запроса (поиск пользователя по имени)
    $stmt = $pdo->prepare("SELECT * FROM trade_org.users WHERE username = :username");
    $stmt->execute(['username' => $username]);

    // Получаем пользователя
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Проверяем, найден ли пользователь и совпадает ли пароль
    if ($user && password_verify($password, $user['password'])) {
        return $user; // Если пароль верный — возвращаем данные пользователя
    }

    return false; // Если аутентификация не удалась
}
?>
