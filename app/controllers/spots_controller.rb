class SpotsController < ApplicationController

  before_filter :authenticate_user!
  inherit_resources             # actually defines standard REST actions
  respond_to :html

end
