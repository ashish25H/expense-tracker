class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :date, :created_at, :category_name

  def category_name
    object.category.name
  end
end
