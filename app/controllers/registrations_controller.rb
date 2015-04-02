class RegistrationsController < Devise::RegistrationsController
 
  private
 
  def sign_up_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end
 
  #  specify their first and last names  when updating their profiles.
  # def account_update_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
end
