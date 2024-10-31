package org.example.ecom.FormBean;

import java.util.ArrayList;
import java.util.List;
import org.example.ecom.model.Category;
import org.example.ecom.model.Product;

public class ProductBean {
  private Long productId;
  private String productName;
  private String productDescription;
  private Double productPrice;
  private Long productQuantity;
  private Long productSdr;
  private Long categoryId;
  private String error;
  private String keyWord;
  private Long filterId;
  private List<Product> products = new ArrayList<>();
  private List<Category> categories = new ArrayList<>();

  public ProductBean() {}

  public Long getProductId() {
    return productId;
  }

  public void setProductId(Long productId) {
    this.productId = productId;
  }

  public String getProductDescription() {
    return productDescription;
  }

  public void setProductDescription(String productDescription) {
    this.productDescription = productDescription;
  }

  public Double getProductPrice() {
    return productPrice;
  }

  public void setProductPrice(Double productPrice) {
    this.productPrice = productPrice;
  }

  public Long getProductQuantity() {
    return productQuantity;
  }

  public void setProductQuantity(Long productQuantity) {
    this.productQuantity = productQuantity;
  }

  public Long getProductSdr() {
    return productSdr;
  }

  public void setProductSdr(Long productSdr) {
    this.productSdr = productSdr;
  }

  public Long getCategoryId() {
    return categoryId;
  }

  public void setCategoryId(Long categoryId) {
    this.categoryId = categoryId;
  }

  public List<Product> getProducts() {
    return products;
  }

  public void setProducts(List<Product> products) {
    this.products = products;
  }

  public String getProductName() {
    return productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public Long getFilterId() {
        return filterId;
    }

    public void setFilterId(Long filterId) {
        this.filterId = filterId;
    }
}
