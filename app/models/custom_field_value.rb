class CustomFieldValue < ApplicationRecord
  belongs_to :custom_field
  belongs_to :customizable, polymorphic: true

  validates :value, presence: true
end
