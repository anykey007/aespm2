class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  def authenticate_admin
    if !current_user.admin?
      redirect_to root_url
    end
  end

end
