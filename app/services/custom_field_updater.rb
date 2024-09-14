class CustomFieldUpdater
  class InvalidFieldTypeError < StandardError; end

  def initialize(customizable:, custom_field:, data:)
    @customizable = customizable
    @custom_field = custom_field
    @data = data
  end

  def call
    custom_field_value = @customizable.custom_field_values.find_or_initialize_by(custom_field_id: @custom_field.id)
    custom_field_value.value = build_field_value(@custom_field.field_type, @data)

    if custom_field_value.valid? && custom_field_value.save
      { success: true, message: "Custom field updated successfully" }
    else
      { success: false, errors: custom_field_value.errors.full_messages }
    end
  end

  private

  def build_field_value(field_type, data)
    case field_type
    when "text"
      { type: "text", data: data }
    when "number"
      { type: "number", data: data.present? ? data.to_i : nil }
    when "single_select"
      { type: "single_select", data: data }
    when "multiple_select"
      { type: "multiple_select", data: Array(data) }
    else
      raise InvalidFieldTypeError, "Invalid field type: #{type}"
    end
  end
end
