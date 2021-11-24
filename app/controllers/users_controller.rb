class UsersController < ApplicationController

  skip_before_action :only_sign_in, only: [:new, :create, :confirm]
  before_action :only_sign_out, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:login, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    @user.recover_password = nil
    if @user.valid?
      @user.save
      UserMailer.confirm(@user).deliver_now
      redirect_to new_user_path, success: "Votre compte a bien été enregistré mais vous devez l'activer à partir du mail qui vient de vous être envoyé."
    else
      render :new
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      @user.update(confirmed: true, confirmation_token: nil)
      @user.save(validate: false)
      session[:auth] = @user.to_session
      redirect_to profil_path, success: "Votre compte a bien été activé."
    else
      redirect_to new_user_path, danger: "Le token n'est pas valide."
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:login, :email, :firstname, :lastname, :avatar_file)
    if @user.update(user_params)
      redirect_to profil_path, success: "Profil mis à jour."
    else
      render :edit
    end
  end

end
