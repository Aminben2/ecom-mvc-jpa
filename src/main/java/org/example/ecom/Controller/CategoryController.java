package org.example.ecom.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;
import org.example.ecom.FormBean.CategoryBean;
import org.example.ecom.Service.CategoryDaoImp;
import org.example.ecom.model.Category;

@WebServlet("/category")
public class CategoryController extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        CategoryDaoImp categoryDao = new CategoryDaoImp();
        CategoryBean categoryBean = new CategoryBean();
        HttpSession session = request.getSession();
        String keyWord = request.getParameter("keyWord");
        if (keyWord != null && !keyWord.trim().isEmpty()) {
            categoryBean.setCategories(categoryDao.getCategoryByKeyWord(request.getParameter("keyWord")));
        } else {
            categoryBean.setCategories(categoryDao.getAll());
        }
        session.setAttribute("categoryBean", categoryBean);
        request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String method = request.getParameter("_method");
        if (method != null && method.equalsIgnoreCase("DELETE")) {
            doDelete(request, response);
        } else if (method != null && method.equalsIgnoreCase("UPDATE")) {
            doPut(request, response);
        } else {
            CategoryDaoImp categoryDao = new CategoryDaoImp();

            String name = request.getParameter("name");
            String description = request.getParameter("description");

            HttpSession session = request.getSession();
            CategoryBean categoryBean = new CategoryBean();
            if (name == null
                    || name.trim().isEmpty()
                    || description == null
                    || description.trim().isEmpty()) {
                categoryBean.setError("All fields are required");
                categoryBean.setCategories(categoryDao.getAll());
                session.setAttribute("categoryBean", categoryBean);
                request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
            }

            Category category = new Category();
            category.setName(name);
            category.setDescription(description);

            if (method != null && method.equalsIgnoreCase("PUT")) {
                category.setId(Long.parseLong(request.getParameter("categoryId")));
                categoryDao.update(category);

                categoryBean.setCategoryId(category.getId());
                categoryBean.setCategoryName(name);
                categoryBean.setCategoryDescription(description);
            } else {
                categoryDao.create(category);
            }

            categoryBean.setCategories(categoryDao.getAll());
            session.setAttribute("categoryBean", categoryBean);
            request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
        }
    }

    public void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("categoryId"));
        if (id != null) {
            CategoryDaoImp categoryDao = new CategoryDaoImp();
            Optional<Category> category = categoryDao.getById(id);
            HttpSession session = request.getSession();
            if (category.isPresent()) {
                Category category1 = category.get();
                CategoryBean categoryBean = new CategoryBean();
                categoryBean.setCategoryId(category1.getId());
                categoryBean.setCategoryName(category1.getName());
                categoryBean.setCategoryDescription(category1.getDescription());

                categoryBean.setCategories(categoryDao.getAll());
                session.setAttribute("categoryBean", categoryBean);
                request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
            }
        }
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        CategoryDaoImp categoryDao = new CategoryDaoImp();
        CategoryBean categoryBean = new CategoryBean();
        HttpSession session = request.getSession();

        Long categoryId = Long.parseLong(request.getParameter("categoryId"));
        if (categoryId != null) {
            if (categoryDao.deleteById(categoryId) == 1) {
                categoryBean.setCategories(categoryDao.getAll());
                session.setAttribute("categoryBean", categoryBean);
                request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
            } else {
                categoryBean.setError("Category not found");
                categoryBean.setCategories(categoryDao.getAll());
                session.setAttribute("categoryBean", categoryBean);
                request.getRequestDispatcher("/WEB-INF/categories.jsp").forward(request, response);
            }
        }
    }
}
