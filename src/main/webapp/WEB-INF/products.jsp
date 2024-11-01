<%@ page import="java.util.List" %>
<%@ page import="org.example.ecom.FormBean.ProductBean" %>
<%@ page import="org.example.ecom.model.Product" %>
<%@ page import="org.example.ecom.model.Category" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<% HttpSession httpSession = request.getSession();
    ProductBean productBean = (ProductBean) httpSession.getAttribute("productBean");
    List<Product> products = productBean.getProducts();
    List<Category> categories = productBean.getCategories();
    Long categoryId = productBean.getCategoryId();
    Long filterId = productBean.getFilterId();
%>
<h1>Product Management</h1>
<form action="product" method="post" enctype="multipart/form-data">
    <h2>Add Product</h2>
    <div>
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name"
               value="<%= productBean.getProductName() != null ? productBean.getProductName(): ""%>">
    </div>
    <div>
        <label for="description">Product Description:</label>
        <input type="text" id="description" name="description"
               value="<%= productBean.getProductDescription() != null ? productBean.getProductDescription() : "" %>">
    </div>
    <div>
        <label for="price">Product Price:</label>
        <input type="text" id="price" name="price"
               value="<%= productBean.getProductPrice() != null ? productBean.getProductPrice() :""%>">
    </div>
    <div>
        <label for="quantity">Quantity :</label>
        <input type="text" id="quantity" name="quantity"
               value="<%= productBean.getProductQuantity() != null ? productBean.getProductQuantity() : ""%>">
    </div>
    <div>
        <label for="sdr">Sdr :</label>
        <input type="text" id="sdr" name="sdr"
               value="<%= productBean.getProductSdr() != null ? productBean.getProductSdr() : "" %>">
    </div>
    <dic>
        <label for="image">Product Image:</label>
        <input type="file" id="image" name="image">
    </dic>
    <% if (productBean.getProductId() != null) { %>
    <input type="hidden" name="productId" value="<%= productBean.getProductId() %>">
    <input type="hidden" name="_method" value="PUT">
    <% } %>
    <div>
        <label for="category">Product Category:</label>
        <select id="category" name="categoryId">
            <% for (Category c : categories) { %>
            <option <%= categoryId != null && categoryId.equals(c.getId()) ? "selected" : "" %>
                    value="<%= c.getId() %>"><%= c.getName() %>
            </option>
            <% } %>
        </select>
    </div>
    <div>
        <input type="submit" value="<%= productBean.getProductId() != null ? "Update product" : "Add product" %>">
        <% if (productBean.getProductId() != null) { %>
        <button id="reset-button" type="button" onclick="resetForm()">Reset</button>
        <% } %>
    </div>
</form>
<% if (productBean.getError() != null) { %>
<div>
    <h1>Error</h1>
    <p><%= productBean.getError()%>
    </p>
</div>
<% } %>
<div class="search-bar">
    <form method="get" action="product">
        <input type="text" id="categorySearch" placeholder="Search for categories.."
               value="<%= productBean.getKeyWord() != null ? productBean.getKeyWord() : ""%>" name="keyWord">
        <input type="submit" value="Search">
    </form>
</div>
<form method="get" action="product" id="filter">
    <label for="categoryId"> Select Category:</label>
    <select id="categoryId" name="categoryId">
        <option value="">All</option>
        <% for (Category c : categories) { %>
        <option <%= filterId != null && filterId.equals(c.getId()) ? "selected" : "" %>
                value="<%= c.getId() %>"><%= c.getName() %>
        </option>
        <% } %>
    </select>
    <input type="submit" value="Filter">
</form>
<div class="product-list">
        <% if (products.isEmpty()){ %>
    <h2>No products found</h2>
        <%} else {%>
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
        <% for (Product p : products) {%>
        <tr>
            <td><%= p.getId() %>
            </td>
            <td><img src="./images/<%= new File(p.getImage()).getName() %>" alt="<%= p.getName() %>"
                     width="100" height="100"></td>
            <td><%= p.getName() %>
            </td>
            <td><%= p.getDescription() %>
            </td>
            <td><%= p.getPrice() %>
            </td>
            <td><%= p.getCategory().getName() %>
            </td>
            <td class="actions">
                <form method="post" action="product">
                    <input type="hidden" name="_method" value="UPDATE">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="submit" value="Update" class="update">
                </form>
                <form method="post" action="product">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
        <% } %>
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
