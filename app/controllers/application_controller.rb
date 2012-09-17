class ApplicationController < ActionController::Base

  layout :layout
  before_filter :authenticate_user! 
  
  protect_from_forgery
  def authenticate_admin  	 
    if !current_user.admin?
      redirect_to root_url
    end
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? "login" : "application"
    # or turn layout off for every devise controller:
    # devise_controller? && "application"
  end

end
