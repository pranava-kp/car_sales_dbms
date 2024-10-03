<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        overflow: hidden;
    }
    .video-background {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: -1;
    }
    .logo-container {
        position: absolute;
        top: 20px;
        left: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .logo {
        position: absolute;
        top: 50px;
        left: 50px;
        width: 100px;
        height: 100px;
    }
    .login-container {
        background: rgba(255, 255, 255, 0.1);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 300px;
        z-index: 1;
    }
    .login-container h2 {
        margin-top: 0;
        color:black;
    }
    .login-container label {
        display: block;
        margin: 10px 0 5px;
        text-align: left;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 90%;
        padding: 10px;
        margin-bottom: 10px;
        border: none;
        border-radius: 5px;
    }
    .login-container input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s ease, transform 0.3s ease;
        margin: 10px 0;
        width: 100%;
    }
    .login-container input[type="submit"]:hover {
        background: #45a049;
        transform: translateY(-2px);
    }
    .login-container input[type="submit"]:active {
        background: #3e8e41;
        transform: translateY(0);
    }
</style>
</head>
<body>
<img src="design.jpeg" alt="JAL-GAAR" class="video-background">
<div class="logo-container">
    <img src="geenie.jpg" alt="Logo" class="logo">
</div>
<div class="login-container">
    <h2>Company Login</h2>
    <form action="company_validate.jsp" method="post">
        <label for="user_id">User ID:</label>
        <input type="text" id="user_id" name="user_id" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
</div>
</body>
</html>
