module Response
  extend ActiveSupport::Concern

  def json_success(data, message = "Success", status = :ok)
    render json: {
      status: true,
      message: message,
      payload: data
    }, status: status
  end

  def json_error(errors, message = "Failed", status = :unprocessable_entity)
    render json: {
      status: false,
      message: message,
      errors: errors
    }, status: status
  end
end
