class CustomField < ApplicationRecord
  belongs_to :tenant
  has_many :custom_field_values, dependent: :destroy

  validates :name, presence: true
  validates :field_type, presence: true, inclusion: { in: %w[text number single_select multiple_select] }

  # add options present validation for selectable types
end
