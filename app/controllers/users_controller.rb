class UsersController < Clearance::UsersController
  def show
    @user = User.find_by_username(params[:username])
  end
end
