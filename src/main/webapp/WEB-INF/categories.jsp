<%@ page import="org.example.ecom.Actions.CategoryAction" %>
<%@ page import="org.example.ecom.model.Category" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 30‏/10‏/2024
  Time: 09:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Category Management</title>
    <style>
        .error{
            color: #c9302c;
        }
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

        .search-bar {
            margin-bottom: 20px;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-around;
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
        .search-form{
            display: flex;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Category Management</h1>
<div class="search-bar">
    <s:form action="searchCategories" method="get" class="search-form">
        <s:textfield id="categorySearch" name="keyWord" placeholder="Search for categories.." />
        <s:submit value="Search" />
    </s:form>
    <div>
        <a href="addCategoryForm">Add Category</a>
    </div>
</div>
<s:if test="%{error != null}">
    <div class="error">
        <h1>Error</h1>
        <p><s:property value="error"/></p>
    </div>
</s:if>
<div class="category-list">
    <s:if test="%{categories.isEmpty()}">
        <h2>No categories found</h2>
    </s:if>
    <s:else>
        <h2>Categories</h2>
        <table>
            <tr>
                <th>Category ID</th>
                <th>Category Name</th>
                <th>Category Description</th>
                <th>Actions</th>
            </tr>
            <s:iterator value="categories">
            <tr>
                <td><s:property value="id"/></td>
                <td><s:property value="name"/></td>
                <td><s:property value="description"/></td>
                <td class="actions">
                    <form method="post" action="updateCategoryForm">
                        <input type="hidden" name="categoryId" value="<s:property value="id"/>">
                        <input type="submit" value="Update" class="update">
                    </form>
                    <form method="post" action="deleteCategory">
                        <input type="hidden" name="categoryId" value="<s:property value="id"/>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <tr>
                </s:iterator>
        </table>
    </s:else>
</div>
</body>
<script>
    function resetForm() {
        document.getElementById("name").value = "";
        document.getElementById("description").value = "";
    }
</script>
</html>
