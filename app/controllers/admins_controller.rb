class AdminsController < ApplicationController
  before_action :require_admin

  protected
    def require_admin
      redirect_to movies_path unless current_user.admin?
    end

    def spy_mode
      admin_user = session[:user_id]
      puts admin_user
      puts params[:id]
      #current_user = User.find(params[:id])
      redirect_to movies_path 
    end
end

