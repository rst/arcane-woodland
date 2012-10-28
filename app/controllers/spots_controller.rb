class SpotsController < ApplicationController

  before_filter :authenticate_user!
  inherit_resources             # actually defines standard REST actions

  respond_to :html
  respond_to :json, :only => :index

  MAP_ACTIONS=[:index, :show_on_map]
  layout 'single-jqmobile-page', :only => MAP_ACTIONS

  def signon_dummy

    # Would like to route "root :to => 'spots#index'" in routes.rb,
    # but jquery mobile is unhappy to see the same page rendered from 
    # more than one browser-visible URL.  So, we instead have the
    # root route go to this...

    redirect_to spots_url
  end

  def create
    create! do |success, failure|
      success.html { redirect_to show_on_map_spot_url( @spot ) }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to show_on_map_spot_url( @spot ) }
    end
  end

  def show_on_map
    # HTML get only
    @highlight_spot_id = resource.id
    render :action => :index
  end

end
