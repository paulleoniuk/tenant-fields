class User < ApplicationRecord
  belongs_to :tenant
  has_many :custom_field_values, as: :customizable, dependent: :destroy

  validates :email, :password_digest, presence: true
end
