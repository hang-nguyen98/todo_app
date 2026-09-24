module ApplicationHelper
  # helper method for highlighting nav-brand
  def brand_nav_class
    if current_page?(root_path)
      "navbar-brand active"
    else
      "navbar-brand"
    end
  end

  # helper method for highlighting nav-item todos
  def todos_nav_class
    if current_page?(todos_path) ||
       (request.path.start_with?("/todos/") && !request.path.start_with?("/todos/completed"))
      "nav-link active"
    else
      "nav-link"
    end
  end

  # helper method for highlighting category nav
  def category_nav_class
    if (request.path.start_with?("/categories"))
      "nav-link active"
    else
      "nav-link"
    end
  end

  # helper method for highlighting nav-item completed todos
  def completed_nav_class
    request.path.start_with?("/todos/completed") ? "nav-link active" : "nav-link"
  end


  def account_nav_class
    if (request.path.start_with?("/account"))
      "nav-link app-account-link active"
    else
      "nav-link app-account-link"
    end
  end  
  
end