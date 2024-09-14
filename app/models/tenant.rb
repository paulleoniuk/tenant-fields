class Tenant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :custom_fields, dependent: :destroy

  validates :name, presence: true
end
