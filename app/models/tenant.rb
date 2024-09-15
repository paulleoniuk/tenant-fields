class Tenant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :custom_fields, dependent: :destroy

  validates :name, presence: true

  def create_custom_field(name:, field_type:, options: [])
    custom_fields.create!(
      name: name,
      field_type: field_type,
      options: options
    )
  end
end
