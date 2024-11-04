<%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 30‏/10‏/2024
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Home Page</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            height: 100%;
            min-height: 100%;
            background-color: #f4f4f4;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            padding: 20px;
        }

        /* Header and Navigation Styling */
        header {
            background: #333;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        nav ul {
            list-style: none;
            display: flex;
        }

        nav ul li {
            margin: 0 10px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 18px;
        }

        nav ul li a:hover {
            text-decoration: underline;
        }

        .container {
            margin: 20px auto;
            padding: 20px;
            max-width: 800px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h1 {
            color: #333;
        }

        .container a {
            display: inline-block;
            margin: 10px 0;
            padding: 10px 20px;
            color: #fff;
            text-decoration: none;
            background: #337ab7;
            border-radius: 4px;
        }

        .container a:hover {
            background: #286090;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome to E-Commerce Management</h1>
    <br/>
    <a href="categories.action" >Categories Management</a>
    <br/>
    <a href="products.action" >Products Management</a>
</div>
</body>
</html>
