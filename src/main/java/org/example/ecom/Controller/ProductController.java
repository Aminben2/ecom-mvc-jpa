package org.example.ecom.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Optional;
import org.example.ecom.FormBean.ProductBean;
import org.example.ecom.Service.CategoryDaoImp;
import org.example.ecom.Service.ProductDaoImpl;
import org.example.ecom.model.Category;
import org.example.ecom.model.Product;

@WebServlet("/product")
@MultipartConfig
public class ProductController extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    ProductDaoImpl productDao = new ProductDaoImpl();
    ProductBean productBean = new ProductBean();
    CategoryDaoImp categoryDao = new CategoryDaoImp();
    HttpSession session = request.getSession();
    String keyWord = request.getParameter("keyWord");
    String categoryId = request.getParameter("categoryId");
    if (keyWord != null && !keyWord.trim().isEmpty()) {
      productBean.setKeyWord(keyWord);
      productBean.setProducts(productDao.getProductByKeyWord(request.getParameter("keyWord")));
    } else if (categoryId != null && !categoryId.trim().isEmpty()) {
      productBean.setProducts(productDao.getProductByCategory(Long.parseLong(categoryId)));
      productBean.setFilterId(Long.parseLong(categoryId));
    } else {
      productBean.setProducts(productDao.getAll());
    }
    productBean.setCategories(categoryDao.getAll());
    session.setAttribute("productBean", productBean);
    request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    String method = request.getParameter("_method");
    if (method != null && method.equalsIgnoreCase("DELETE")) {
      doDelete(request, response);
    } else if (method != null && method.equalsIgnoreCase("UPDATE")) {
      doPut(request, response);
    } else {
      ProductDaoImpl productDao = new ProductDaoImpl();
      CategoryDaoImp categoryDao = new CategoryDaoImp();

      String name = request.getParameter("name");
      String description = request.getParameter("description");
      String price = request.getParameter("price");
      String quantity = request.getParameter("quantity");
      String sdr = request.getParameter("sdr");
      String categoryId = request.getParameter("categoryId");

      HttpSession session = request.getSession();
      ProductBean productBean = new ProductBean();

      if (name == null
          || name.trim().isEmpty()
          || description == null
          || description.trim().isEmpty()
          || price == null
          || quantity == null
          || sdr == null
          || categoryId == null) {
        productBean.setError("All fields are required");
        productBean.setCategories(categoryDao.getAll());
        productBean.setProducts(productDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      }

      Product product = new Product();
      product.setName(name);
      product.setDescription(description);
      try {
        product.setPrice(Double.parseDouble(price));
        product.setQuantity(Long.parseLong(quantity));
        product.setSdr(Long.parseLong(sdr));
      } catch (NumberFormatException e) {
        productBean.setError("Please enter a valid number");
        productBean.setProducts(productDao.getAll());
        productBean.setCategories(categoryDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      }

      Optional<Category> category = categoryDao.getById(Long.parseLong(categoryId));
      if (category.isEmpty()) {
        productBean.setError("Category not found");
        productBean.setProducts(productDao.getAll());
        productBean.setCategories(categoryDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      }
      product.setCategory(category.get());

      Part filePart = request.getPart("image");
      String imagePath = null;
      if (filePart != null && filePart.getSize() > 0) {
        String imageFolder = getServletContext().getRealPath("/images");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        imagePath = imageFolder + File.separator + fileName;
        product.setImage(imagePath);
        File imageFile = new File(imagePath);
        if (!imageFile.getParentFile().exists()) {
          imageFile.getParentFile().mkdirs();
        }
        Files.copy(filePart.getInputStream(), imageFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
      }
      
      
      if (method != null && method.equalsIgnoreCase("PUT")) {
        product.setId(Long.parseLong(request.getParameter("productId")));
        productDao.update(product);

        productBean.setProductId(product.getId());
        productBean.setProductName(name);
        productBean.setProductDescription(description);
        productBean.setProductPrice(Double.parseDouble(price));
        productBean.setProductQuantity(Long.parseLong(quantity));
        productBean.setProductSdr(Long.parseLong(sdr));
        productBean.setCategoryId(Long.parseLong(categoryId));

      } else {
        productDao.create(product);
      }
      

      productBean.setProducts(productDao.getAll());
      productBean.setCategories(categoryDao.getAll());
      session.setAttribute("productBean", productBean);
      request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
    }
  }

  public void doPut(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    Long id = Long.parseLong(request.getParameter("productId"));
    if (id != null) {
      ProductDaoImpl productDao = new ProductDaoImpl();
      CategoryDaoImp categoryDao = new CategoryDaoImp();
      Optional<Product> product = productDao.getById(id);
      HttpSession session = request.getSession();
      if (product.isPresent()) {
        Product product1 = product.get();
        ProductBean productBean = new ProductBean();
        productBean.setProductId(product1.getId());
        productBean.setProductName(product1.getName());
        productBean.setProductDescription(product1.getDescription());
        productBean.setProductPrice(product1.getPrice());
        productBean.setProductQuantity(product1.getQuantity());
        productBean.setProductSdr(product1.getSdr());
        productBean.setCategoryId(product1.getCategory().getId());

        productBean.setProducts(productDao.getAll());
        productBean.setCategories(categoryDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      }
    }
  }

  public void doDelete(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    ProductDaoImpl productDao = new ProductDaoImpl();
    CategoryDaoImp categoryDao = new CategoryDaoImp();
    ProductBean productBean = new ProductBean();
    HttpSession session = request.getSession();

    Long productId = Long.parseLong(request.getParameter("productId"));
    if (productId != null) {
      if (productDao.deleteById(productId) == 1) {
        productBean.setCategories(categoryDao.getAll());
        productBean.setProducts(productDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      } else {
        productBean.setError("Product not found");
        productBean.setCategories(categoryDao.getAll());
        productBean.setProducts(productDao.getAll());
        session.setAttribute("productBean", productBean);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
      }
    }
  }
}
