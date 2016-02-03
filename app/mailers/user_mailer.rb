class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def welcome_email(user)

  end

  def admin_user_delete_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account got nuked by our admins.')
  end

end
