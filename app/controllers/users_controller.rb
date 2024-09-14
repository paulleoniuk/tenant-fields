class UsersController < ApplicationController
  before_action :set_user

  # PATCH/PUT /custom_fields/:id/update_value
  def update_value
    custom_field = CustomField.find(field_params[:custom_field_id])

    result = CustomFieldUpdater.new(customizable: @user,
                                    custom_field: custom_field,
                                    data: field_params[:value]).call

    if result[:success]
      render json: { message: result[:message] }, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def field_params
    params.permit(:custom_field_id, :value, :id)
  end

  def set_user
    # User or OtherEntity
    @user = User.find(field_params[:id]) if field_params[:id]
    # We may add here also authentication
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end
