class Query < ApplicationRecord
  after_validation :set_coordinates,
                   if: :needs_coordinates?

  validates :address,
            presence: true

  def searched!
    increment(:searches_count)
    self.searched_at = current_time_from_proper_timezone

    save
  end

  private

  def set_coordinates
    coordinates = Geocoder.coordinates(address)

    if coordinates.present?
      self.latitude  = coordinates.first
      self.longitude = coordinates.last
    end
  end

  def needs_coordinates?
    !latitude || !longitude || address_changed?
  end
end
