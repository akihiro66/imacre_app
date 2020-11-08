class GuestSessionsController < ApplicationController

  def new_guest
    user = User.find_by(email: 'recruit@example.com')
    log_in user
    flash[:success] = 'ゲストユーザーでログインしました'
    redirect_to root_path
  end
end
