class MainController < ApplicationController
  def index
  end

  def generate
    generated_passwords = PasswordBuilder.generate(params[:words])
    if generated_passwords
      render json: generated_passwords
    else
      render json: "Недостаточно слов для формирования пароля", status: :unprocessable_entity
    end
  end
end
