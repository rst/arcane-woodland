class SpotsController < ApplicationController

  before_filter :authenticate_user!
  inherit_resources             # actually defines standard REST actions
  respond_to :html

  def create
    create! do |success, failure|
      success.html { redirect_to spots_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to spots_url }
    end
  end

end
