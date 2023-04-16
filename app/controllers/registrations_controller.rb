class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  private

  def configure_sign_up_params
    merge_birth_date_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end

  def configure_account_update_params
    merge_birth_date_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :email, :password, :password_confirmation, :current_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end

  def merge_birth_date_params
    params[:user][:birth_date] = "#{params[:user]['birth_date(1i)']}-#{params[:user]['birth_date(2i)']}-#{params[:user]['birth_date(3i)']}"
  end
end
