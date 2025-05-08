class CategoriesController < ApplicationController
  def index 
    catogries = Category.all 
    if catogries.present?
      json_success(catogries)
    else
      json_error(catogries.errors.full_messages)
    end
  end

  def create 
    category = Category.new(catogrey_params)
    if category.present?
      category.update(catogrey_params)
      json_success(category)
    else
      json_error(category.errors.full_messages)
    end
  end

  def category_count
    categories_count = Category.count
    json_success(categories_count)
  end

  def destroy
    category = Category.find(params[:id])
    if category
      category.destroy
    else 
      json_error(category.errors.full_messages)
    end
  end

  private

  def catogrey_params
    params.require(:category).permit(:name)
  end
end
