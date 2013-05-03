class UsersController < Clearance::UsersController
  def show
    @user = User.find_by_username(params[:username])
    @selections = @user.selections.all
  end
end
