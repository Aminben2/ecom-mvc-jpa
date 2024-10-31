<%@ page import="org.example.ecom.FormBean.CategoryBean" %>
<%@ page import="org.example.ecom.model.Category" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 30‏/10‏/2024
  Time: 09:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            font: inherit;
            vertical-align: baseline;
        }

        /* Make sure to set your content height */
        html, body {
            height: 100%;
            min-height: 100%;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
            padding: 20px;
        }

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

        h1, h2 {
            color: #333;
        }

        form {
            margin-bottom: 20px;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form div {
            margin-bottom: 10px;
        }

        label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
        }

        input[type="text"], select {
            width: calc(100% - 160px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background: #5cb85c;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background: #4cae4c;
        }

        .search-bar {
            margin-bottom: 20px;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .search-bar input[type="text"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-bar input[type="submit"] {
            width: 15%;
            background: #337ab7;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-bar input[type="submit"]:hover {
            background: #286090;
        }

        .category-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .category-list th, .category-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .category-list th {
            background: #f2f2f2;
            color: #333;
        }

        .actions {
            display: flex;
            justify-content: space-around;
        }

        .actions input[type="submit"] {
            background: #d9534f;
            color: #fff;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .actions input[type="submit"]:hover {
            background: #c9302c;
        }

        .update {
            background: #5bc0de;
            color: #fff;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #reset-button {
            background: #d9534f;
            color: #fff;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<% HttpSession httpSession = request.getSession();
    CategoryBean categoryBean = (CategoryBean) httpSession.getAttribute("categoryBean");
    List<Category> categories = categoryBean.getCategories();
%>
<h1>Category Management</h1>
<form action="category" method="post">
    <h2>Add Category</h2>
    <div>
        <label for="name">Category Name:</label>
        <input type="text" id="name" name="name"
               value="<%= categoryBean.getCategoryName() != null ? categoryBean.getCategoryName() : "" %>">
    </div>
    <div>
        <label for="description">Category Description:</label>
        <input type="text" id="description" name="description"
               value="<%= categoryBean.getCategoryDescription() != null ? categoryBean.getCategoryDescription() : "" %>">
    </div>
    <% if (categoryBean.getCategoryId() != null) { %>
    <input type="hidden" name="categoryId" value="<%= categoryBean.getCategoryId() %>">
    <input type="hidden" name="_method" value="PUT">
    <% } %>
    <div>
        <input type="submit" value="<%= categoryBean.getCategoryId() != null ? "Update category" : "Add category" %>">
        <% if (categoryBean.getCategoryId() != null) { %>
        <button id="reset-button" type="button" onclick="resetForm()">Reset</button>
        <% } %>
    </div>
</form>
<% if (categoryBean.getError() != null) { %>
<div>
    <h1>Error</h1>
    <p><%= categoryBean.getError() %></p>
</div>
<% } %>
<div class="search-bar">
    <form method="get" action="category">
        <input type="text" id="categorySearch" placeholder="Search for categories.." value="" name="keyWord">
        <input type="submit" value="Search">
    </form>
</div>
<div class="category-list">
    <% if (categories.isEmpty()) { %>
    <h2>No categories found</h2>
    <% } else { %>
    <table>
        <tr>
            <th>Category ID</th>
            <th>Category Name</th>
            <th>Category Description</th>
            <th>Actions</th>
        </tr>
        <% for (Category c : categories) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getDescription() %></td>
            <td class="actions">
                <form method="post" action="category">
                    <input type="hidden" name="_method" value="UPDATE">
                    <input type="hidden" name="categoryId" value="<%= c.getId() %>">
                    <input type="submit" value="Update" class="update">
                </form>
                <form method="post" action="category">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="categoryId" value="<%= c.getId() %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
<script>
    function resetForm() {
        document.getElementById("name").value = "";
        document.getElementById("description").value = "";
    }
</script>
</html>
