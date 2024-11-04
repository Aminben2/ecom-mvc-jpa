package org.example.ecom.Actions;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import org.example.ecom.Service.CategoryDaoImp;
import org.example.ecom.model.Category;

public class CategoryAction extends ActionSupport {
    private String keyWord;
    private Long categoryId;
    private String categoryName;
    private String categoryDescription;
    private String error;
    private List<Category> categories = new ArrayList<>();

    public CategoryAction() {
    }

    public String execute() {
        return SUCCESS;
    }

    public String addCategory() {
        CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
        Category category = new Category();
        category.setName(categoryName);
        category.setDescription(categoryDescription);
        categoryDaoImp.create(category);
        return SUCCESS;
    }

    public String updateCategory() {
        CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
        Category category = new Category();
        category.setId(categoryId);
        category.setName(categoryName);
        category.setDescription(categoryDescription);
        categoryDaoImp.update(category);
        return SUCCESS;
    }

    public String updateCategoryFormData() {
        CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
        Category category = categoryDaoImp.getById(categoryId).get();
        setCategoryId(category.getId());
        setCategoryName(category.getName());
        setCategoryDescription(category.getDescription());
        return SUCCESS;
    }

    public String deleteCategory() {
        CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
        categoryDaoImp.deleteById(categoryId);
        return SUCCESS;
    }

    public String listCategories() {
        CategoryDaoImp categoryDaoImp = new CategoryDaoImp();
        setCategories(categoryDaoImp.getAll());
        return SUCCESS;
    }

    public String listCategoriesByKeyword(){
        CategoryDaoImp categoryDaoImp  = new CategoryDaoImp();
        setCategories(categoryDaoImp.getCategoryByKeyWord(keyWord));
        return SUCCESS;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
