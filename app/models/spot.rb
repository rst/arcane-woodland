class Spot < ActiveRecord::Base

  FLAG_ATTRS = [:has_food, :has_drinks, :has_music]

  attr_accessible :name, :addr1, :addr2, :latitude, :longitude, *FLAG_ATTRS

  validates :name, :address,   presence: true

  def address
    if addr2.blank?
      addr1
    elsif addr1.blank?
      addr2
    else
      addr1 + ", " + addr2
    end
  end

  validate do
    unless FLAG_ATTRS.any?{ |a| self.send( a ) }
      errors.add :base, "Spot must offer at least one service"
    end
    if latitude.blank? || longitude.blank?
      errors.add :base, "Could not resolve address to a map location"
    end
  end

end
