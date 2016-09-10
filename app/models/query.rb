class Query < ApplicationRecord
  validates :address,
            presence: true

end
