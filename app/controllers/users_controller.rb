class UsersController < ApplicationController

  def index # GET /vinyls
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Signed up!"
      session[:user_id] = @user.id
    else
      flash[:notice] = "User exists."
      redirect_to sign_up_path    
    end
  end


  def show # GET /:username
    @user = User.find_by_username!(params[:username])
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.user_id = current_user.id
    if @user.update_attributes(params[:user])
      
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, notice: 'User was not updated.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to action: :index
  end
end
