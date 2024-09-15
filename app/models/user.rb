class User < ApplicationRecord
  belongs_to :tenant
  has_many :custom_field_values, as: :customizable, dependent: :destroy

  validates :email, presence: true

  def get_custom_fields
    custom_field_values.includes(:custom_field).map do |cfv|
      {
        name: cfv.custom_field.name,
        value: JSON.parse(cfv.value)
      }
    end
  end
end
