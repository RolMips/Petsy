class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  add_flash_types :success, :danger

  before_action :only_sign_in

  helper_method :current_user, :user_signed_in

  private

  def only_sign_in
    if !user_signed_in
      redirect_to new_user_path, danger: "Vous n'êtes pas connecté."
    end
  end

  def only_sign_out
    redirect_to profil_path if user_signed_in
  end

  def current_user
    return nil if !session[:auth] || !session[:auth]['id']
    return @_user if @_user
    @_user = User.find_by_id(session[:auth]['id'])
  end

  def user_signed_in
    !current_user.nil?
  end

end
