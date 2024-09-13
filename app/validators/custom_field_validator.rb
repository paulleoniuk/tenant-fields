# app/validators/custom_field_validator.rb

class CustomFieldValidator
  class ValidationError < StandardError; end

  def initialize(field_type, value)
    @field_type = field_type
    @value = value
  end

  def validate
    error_message = case @field_type
                    when 'text'
                      validate_text
                    when 'number'
                      validate_number
                    when 'single_select'
                      validate_single_select
                    when 'multiple_select'
                      validate_multiple_select
                    else
                      'Invalid field type'
                    end
    raise ValidationError, error_message if error_message
  end

  private

  def validate_text
    @value.present? ? nil : 'Text field cannot be blank'
  end

  def validate_number
    @value.present? && @value.match?(/\A[+-]?\d+(\.\d+)?\z/) ? nil : 'Invalid number value'
  end

  def validate_single_select
    @value.present? ? nil : 'Single select field value cannot be blank'
  end

  def validate_multiple_select
    if @value.is_a?(Array)
      @value.all? { |v| v.present? } ? nil : 'Multiple select field values cannot be blank'
    else
      @value.present? ? nil : 'Multiple select field value cannot be blank'
    end
  end
end
