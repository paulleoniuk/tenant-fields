# app/services/custom_field_updater.rb

class CustomFieldUpdater
  class InvalidFieldTypeError < StandardError; end

  def initialize(customizable, custom_field, value)
    @customizable = customizable
    @custom_field = custom_field
    @value = value
  end

  def call
    custom_field_value = @customizable.custom_field_values.find_or_initialize_by(custom_field_id: @custom_field.id)

    case @custom_field.field_type
    when 'text'
      custom_field_value.value = { field_type: 'text', value: @value }
    when 'number'
      custom_field_value.value = { field_type: 'number', value: @value.to_i }
    when 'single_select'
      custom_field_value.value = { field_type: 'single_select', value: @value }
    when 'multiple_select'
      values = @value.is_a?(Array) ? @value : [@value]
      custom_field_value.value = { field_type: 'multiple_select', values: values }
    else
      raise InvalidFieldTypeError, 'Invalid field type'
    end

    if custom_field_value.save
      { success: true, message: 'Custom field updated successfully' }
    else
      raise StandardError, custom_field_value.errors.full_messages.join(', ')
    end
  end
end
