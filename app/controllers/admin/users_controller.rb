class Admin::UsersController < ApplicationController
  before_action :require_admin, except: :revert

  def index
    @users = User.where.not(id: current_user.id).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "#{@user.full_name} added."
      redirect_to admin_users_path
    else
      render :new
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.full_name} updated."
      redirect_to admin_users_path 
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
   
    respond_to do |format|
      if @user.destroy
        UserMailer.admin_user_delete_email(@user).deliver
        flash[:success] = 'User was successfully nuked.'
        format.html{redirect_to admin_users_path}
      end
    end

  end

  def spy_mode
    session[:admin_id] = session[:user_id]
    session[:user_id] = params[:id]
    redirect_to root_path
  end

  def revert
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to admin_users_path
  end
  
  protected
    def require_admin
      redirect_to root_path unless current_user.admin?
    end  

    def user_params
      params.require(:user).permit(
        :email,
        :firstname,
        :lastname, 
        :password,
        :password_cofirmation,
        :admin
      )
    end
end
