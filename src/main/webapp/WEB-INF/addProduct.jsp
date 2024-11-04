<%--
  Created by IntelliJ IDEA.
  User: amine
  Date: 4‏/11‏/2024
  Time: 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Add Product</title>
    <style>
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
    </style>
</head>
<body>
<s:form action="addProduct" method="post" enctype="multipart/form-data">
    <h2>Add Product</h2>
    <div>
        <label for="name">Product Name:</label>
        <s:textfield id="name" name="productName"/>
    </div>
    <div>
        <label for="description">Product Description:</label>
        <s:textfield id="description" name="productDescription"/>
    </div>
    <div>
        <label for="price">Product Price:</label>
        <s:textfield id="price" name="productPrice"/>
    </div>
    <div>
        <label for="quantity">Quantity :</label>
        <s:textfield id="quantity" name="productQuantity"/>
    </div>
    <div>
        <label for="sdr">Sdr :</label>
        <s:textfield id="sdr" name="productSdr"/>
    </div>
    <div>
        <label for="image">Product Image:</label>
        <s:file id="image" name="image"/>
    </div>
    <div>
        <label for="category">Product Category:</label>
        <s:select id="category" name="categoryId" list="categories" listKey="id" listValue="name"/>
    </div>
    <div>
        <s:submit value="Add product"/>
        <button id="reset-button" type="button" onclick="resetForm()">Reset</button>
    </div>
    <s:if test="%{error != null}">
        <div>
            <h1>Error</h1>
            <p><s:property value="error"/></p>
        </div>
    </s:if>
</s:form>
</body>
</html>
