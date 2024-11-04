<%@ page import="java.util.List" %>
<%@ page import="org.example.ecom.Actions.ProductAction" %>
<%@ page import="org.example.ecom.model.Product" %>
<%@ page import="org.example.ecom.model.Category" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Product Management</title>
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

        .product-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-list th, .product-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .product-list th {
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

        #filter {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-bottom: 20px;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Product Management</h1>
<div class="search-bar">
    <s:form action="searchProducts" method="get">
        <s:textfield id="categorySearch" name="keyWord" placeholder="Search for categories.." value="%{keyWord}"/>
        <s:submit value="Search"/>
    </s:form>
    <div>
        <a href="addProductForm">Add Product</a>
    </div>
</div>
<s:form action="filterProducts" method="get" id="filter">
    <label for="filterId"> Select Category:</label>
    <s:select id="filterId" name="filterId" list="categories" listKey="id" listValue="name" headerKey=""
              headerValue="All" value="%{filterId}"/>
    <s:submit value="Filter"/>
</s:form>
<div class="product-list">
    <s:if test="%{#products.isEmpty()}">
        <h2>No products found</h2>
    </s:if>
    <s:else>
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Product Description</th>
                <th>Product Price</th>
                <th>Product Category</th>
                <th>Actions</th>
            </tr>
            <s:iterator value="products" var="p">
                <tr>
                    <td><s:property value="#p.id"/></td>
                    <td><img src="./images/<s:property value="#p.image" />" alt="<s:property value="#p.name" />"
                             width="100" height="100"></td>
                    <td><s:property value="#p.name"/></td>
                    <td><s:property value="#p.description"/></td>
                    <td><s:property value="#p.price"/></td>
                    <td><s:property value="#p.category.name"/></td>
                    <td class="actions">
                        <s:form action="updateProductForm" method="post">
                            <s:hidden name="productId" value="#p.id"/>
                            <s:submit value="Update" cssClass="update"/>
                        </s:form>
                        <s:form action="deleteProduct" method="post">
                            <s:hidden name="productId" value="#p.id"/>
                            <s:submit value="Delete"/>
                        </s:form>
                    </td>
                </tr>
            </s:iterator>
        </table>
    </s:else>
</div>
</body>
<script>
    function resetForm() {
        document.getElementById("name").value = "";
        document.getElementById("description").value = "";
        document.getElementById("price").value = "";
        document.getElementById("quantity").value = "";
        document.getElementById("sdr").value = "";
        document.getElementById("category").selectedIndex = 0;
    }
</script>
</html>
