class UsersController < Clearance::UsersController
  def show
    @user = User.find_by_username(params[:username])
    @selections = @user.selections.all(order: "created_at DESC", limit: 50)
  end
end
