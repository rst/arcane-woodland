module SpotsHelper

  # ID for the form editing a spot.  This actually duplicates stock 
  # Rails 3.2 behavior, but that behavior is documented poorly enough
  # that I'd rather not rely on it...

  def spot_form_id( spot )
    if (spot.persisted?)
      dom_id( spot, :edit )
    else
      dom_id( spot, :new )
    end
  end
end
