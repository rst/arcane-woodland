class SpotsController < ApplicationController

  before_filter :authenticate_user!
  resources_controller_for :spots

end
