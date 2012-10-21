class Spot < ActiveRecord::Base

  FLAG_ATTRS = [:has_food, :has_drinks, :has_music]

  attr_accessible :name, :addr1, :addr2, :latitude, :longitude, *FLAG_ATTRS

  validates :name,     :address,   presence: true
  validates :latitude, :longitude, presence: true, numericality: true

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
      errors.add :base, "Must offer at least one service for inclusion"
    end
  end

end
