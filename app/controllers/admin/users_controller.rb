class Admin::UsersController < AdminsController

  def index
    @users = User.where.not(id: current_user.id)
  end

  # def show

  # end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admins_users_path, notice: "#{@user.full_name} added."
    else
      render :new
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "#{@user.full_name} updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path(@user)
    #redirect_to movies_path
  end

  protected
    def user_params
      params.require(:user).permit(
        :email,
        :firstname,
        :lastname, 
        :password,
        :password_cofirmation
      )
    end

end
