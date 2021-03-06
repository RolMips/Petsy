class UserMailer < ApplicationMailer

  def confirm(user)
    @user = user
    mail(to: user.email, subject: 'Inscription sur le site ' + Rails.application.config.site[:name])
  end

  def password(user)
    @user = user
    mail(to: user.email, subject: 'RĂ©initialisation du mot de passe ' + Rails.application.config.site[:name])
  end

end
