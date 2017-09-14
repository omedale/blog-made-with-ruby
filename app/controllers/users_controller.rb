class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_owner, only: [:edit, :update, :destroy]
  def new
   @user  = User.new
  end

  def show
    @user_articles = @user.posts.paginate(page: params[:page], per_page: 2)
  end
 
  def create
  #render plain: params[:post].inspect
  @user = User.new(user_params) 
      if(@user.save)
        session[:id] = @user.id
        flash[:success] = "User #{@user.username} created successfully"
        redirect_to user_path(@user)
      else
        render 'new'
      end
  end

  def update  
    if(@user.update(user_params))
        flash[:success] = "User update  successfully"
        redirect_to '/'
    else
        render 'edit'
    end
  end

  def edit
  end
  private def user_params
    params.require(:user).permit(:username, :email, :password)
  end 

  def destroy 
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all article has been destroyed"
    redirect_to home_path   
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def require_owner
    if current_user != @user 
        flash[:danger] = "You can only edit or delete your own account"           
        redirect_to home_path
    end
end
end
