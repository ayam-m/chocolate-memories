class Brand < ApplicationRecord
  has_many :records, dependent: :destroy
end
