class SessionsController < ApplicationController

  skip_before_action :only_sign_in, only: [:new, :create]
  before_action :only_sign_out, only: [:new, :create]

  def new
  end

  def create
    user_params = params.require(:user)
        @user = User.where('confirmed = 1 AND (login = :login OR email = :login)',  login: user_params[:login]).first
    if @user and @user.confirmed? and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: "Connexion réusie."
    else
      redirect_to new_session_path, danger: "Connexion refusée."
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: "Deconnexion réusie."
  end
end
