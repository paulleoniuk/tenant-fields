class UsersController < ApplicationController
  before_action :set_user

  # PATCH/PUT /custom_fields/:id/update_value
  def update_value
    custom_field = CustomField.find(params[:custom_field_id])
    value = params[:value]

    validator = CustomFieldValidator.new(custom_field.field_type, value)
    validator.validate

    service = CustomFieldUpdater.new(@user, custom_field, value)
    result = service.call

    render json: { message: result[:message] }, status: :ok
  rescue CustomFieldValidator::ValidationError, CustomFieldUpdater::InvalidFieldTypeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
  end

  private

  def set_user
    # User or OtherEntity
    @user = User.find(params[:id]) if params[:id]
    # We may add here also authentication
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
