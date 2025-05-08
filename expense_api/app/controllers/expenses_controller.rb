class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :update, :destroy]

  def index 
    expenses = Expense.all
    if expenses.present?
      json_success(ActiveModelSerializers::SerializableResource.new(expenses, each_serializer: ExpenseSerializer))
    else
      json_error(expenses.errors.full_messages)
    end
  end

  def show 
    if @expense.present?
      json_success(ActiveModelSerializers::SerializableResource.new(@expense, each_serializer: ExpenseSerializer))
    else
      json_error(@expense.errors.full_messages)
    end
  end

  def create
    expense = Expense.new(expense_params)
    
    if expense.save 
      json_success(ActiveModelSerializers::SerializableResource.new(expense, each_serializer: ExpenseSerializer))
    else
      json_error(expense.errors.full_messages)
    end
  end

  def update 
    if @expense.present?
      @expense.update(expense_params)
      json_success(ActiveModelSerializers::SerializableResource.new(@expense, each_serializer: ExpenseSerializer))
    else
      json_error(@expense.errors.full_messages)
    end
  end

  def destroy
    if @expense.present?
      @expense.destroy
      json_success(nil, "Expense deleted successfully")
    else
      json_error(nil, "Expense not found", :not_found)
    end
  end  

  def get_expense_by_category
    result = Expense.joins(:category)
                    .group('categories.name')
                    .sum(:amount)
  
    formatted_result = result.map { |category_name, total| { category_name => total } }
  
    json_success(formatted_result)
  end

  private

  def set_expense
    @expense = Expense.find(params[:id]);
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :date, :category_id)
  end
end
