class AdminsController < ApplicationController
  before_action :require_admin

  protected
    def require_admin
      redirect_to movies_path unless current_user.admin?
    end
end

