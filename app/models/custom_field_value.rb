class CustomFieldValue < ApplicationRecord
  belongs_to :custom_field
  belongs_to :customizable, polymorphic: true

  validates :value, presence: true

  validate :value_is_valid_based_on_field_type

  private

  # Refactor: Move to validation service
  def value_is_valid_based_on_field_type
    return unless value.is_a?(Hash)

    field_type = value["type"]
    extracted_value = value["data"]

    error_message = case field_type
    when "text"
                      validate_text(extracted_value)
    when "number"
                      validate_number(extracted_value)
    when "single_select"
                      validate_single_select(extracted_value)
    when "multiple_select"
                      validate_multiple_select(extracted_value)
    else
                      "Invalid field type: #{field_type}"
    end

    errors.add(:value, error_message) if error_message
  end

  def validate_text(value)
    value.present? ? nil : "Text field cannot be blank"
  end

  def validate_number(value)
    value.present? && value.to_s.match?(/\A[+-]?\d+(\.\d+)?\z/) ? nil : "Invalid number value"
  end

  def validate_single_select(value)
    value.present? ? nil : "Single select field value cannot be blank"
  end

  def validate_multiple_select(value)
    if value.is_a?(Array)
      value.all?(&:present?) ? nil : "Multiple select field value cannot be blank"
    else
      value.present? ? nil : "Multiple select field value cannot be blank"
    end
  end
end
