class UsersController < ApplicationController
  def new
   @user  = User.new
  end

  def show
    @user  = User.find(params[:id])
    @user_articles = @user.posts.paginate(page: params[:page], per_page: 2)
   end
 
  def create
  #render plain: params[:post].inspect
  @user = User.new(user_params) 
      if(@user.save)
        flash[:success] = "User #{@user.username} created successfully"
        redirect_to '/'
      else
        render 'new'
      end
  end

  def update
    @user = User.find(params[:id])
    
    if(@user.update(user_params))
        flash[:success] = "User update  successfully"
        redirect_to '/'
    else
        render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  private def user_params
    params.require(:user).permit(:username, :email, :password)
  end 
end
