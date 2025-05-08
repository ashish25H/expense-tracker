Rails.application.routes.draw do
  resources :expenses do
    collection do 
      get 'get_expense_by_category'
    end
  end

  resources :categories, only: [:index, :create, :destroy] do
    collection do 
      get :category_count
    end
  end
end
