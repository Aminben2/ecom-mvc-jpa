package org.example.ecom.Actions;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.example.ecom.Service.CategoryDaoImp;
import org.example.ecom.Service.ProductDaoImpl;
import org.example.ecom.model.Category;
import org.example.ecom.model.Product;

public class ProductAction extends ActionSupport {
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

  public ProductAction() {}

  public String execute() {
    return SUCCESS;
  }

  public Product createProduct() {
    Product product = new Product();
    product.setName(productName);
    product.setDescription(productDescription);
    product.setPrice(productPrice);
    product.setQuantity(productQuantity);
    product.setSdr(productSdr);
    return product;
  }

  public String addProduct() {
    String validationResult = validateProductFields();
    if (!SUCCESS.equals(validationResult)) {
      return validationResult;
    }
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    Product product = createProduct();
    Optional<Category> category = categoryDaoImp.getById(categoryId);
    if (category.isEmpty()) {
      setError("Category not found");
      return ERROR;
    }
    product.setCategory(category.get());
    productDaoImpl.create(product);
    setProducts(productDaoImpl.getAll());
    setCategories(categoryDaoImp.getAll());
    return SUCCESS;
  }

  public String updateProduct() {
    if (productId == null) {
      setError("Product id is required");
      return ERROR;
    }
    String validationResult = validateProductFields();
    if (!SUCCESS.equals(validationResult)) {
      return validationResult;
    }
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    Product product = createProduct();
    product.setId(productId);
    Optional<Category> category = categoryDaoImp.getById(categoryId);
    if (category.isEmpty()) {
      setError("Category not found");
      return ERROR;
    }
    product.setCategory(category.get());
    productDaoImpl.update(product);
    setProducts(productDaoImpl.getAll());
    setCategories(categoryDaoImp.getAll());
    return SUCCESS;
  }

  public String updateProductFormData(){
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    Optional<Product> productOptional = productDaoImpl.getById(productId);
    if (productOptional.isEmpty()) {
      setError("Product not found");
      return SUCCESS;
    }
    Product product = productOptional.get();
    setProductId(product.getId());
    setProductName(product.getName());
    setProductDescription(product.getDescription());
    setProductPrice(product.getPrice());
    setProductQuantity(product.getQuantity());
    setProductSdr(product.getSdr());
    setCategoryId(product.getCategory().getId());
    setCategories(categoryDaoImp.getAll());
    return SUCCESS;
  }

  public String addProductFormData() {
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    setCategories(categoryDaoImp.getAll());
    return SUCCESS;
  }

  public String deleteProduct() {
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    int res = productDaoImpl.deleteById(productId);
    if (res == 0) {
      setError("Product not found");
      return ERROR;
    }
    setProducts(productDaoImpl.getAll());
    setCategories(new CategoryDaoImp().getAll());
    return SUCCESS;
  }

  public String listProducts() {
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    setCategories(categoryDaoImp.getAll());
    setProducts(productDaoImpl.getAll());
    return SUCCESS;
  }

  public String listProductsByKeyWord() {
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    setProducts(productDaoImpl.getProductByKeyWord(keyWord));
    setCategories(categoryDaoImp.getAll());
    return SUCCESS;
  }

  public String listProductByCategory(){
    ProductDaoImpl productDaoImpl = new ProductDaoImpl();
    CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
    setProducts(productDaoImpl.getProductByCategory(filterId));
    setCategories(categoryDaoImp.getAll());
    setFilterId(filterId);
    return SUCCESS;
  }

  public String validateProductFields() {
    if (isNullOrEmpty(productName)) {
      return setErrorAndReturn("Product name is required");
    }
    if (isNullOrEmpty(productDescription)) {
      return setErrorAndReturn("Product description is required");
    }
    if (productPrice == null) {
      return setErrorAndReturn("Product price is required");
    }
    if (productQuantity == null) {
      return setErrorAndReturn("Product quantity is required");
    }
    if (productSdr == null) {
      return setErrorAndReturn("Product sdr is required");
    }
    if (categoryId == null) {
      return setErrorAndReturn("Category is required");
    }
    return SUCCESS;
  }

  private boolean isNullOrEmpty(String value) {
    return value == null || value.isEmpty();
  }

  private String setErrorAndReturn(String errorMessage) {
    setError(errorMessage);
    return ERROR;
  }

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
