class UsersController < ApplicationController
   
   before_action :set_user, only: [:show, :edit, :update, :destroy]
   before_action :require_user, only: [:edit, :update]
   # Important this is after require_user as above code needs to run first
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def show
       #take articles created by specific user
       @articles = @user.articles.paginate(page: params[:page], per_page: 5)
   end
   
   def index
     @users = User.paginate(page: params[:page], per_page: 5)
   end
   
   def new
       @user = User.new
   end
   
   def edit

   end
   
   def update

       if @user.update(user_params)
           flash[:notice] = "Your account was updated successfully"
           redirect_to @user
       else
           render 'edit'
       end
   end
   
   def create
       @user = User.new(user_params)
       #if statement for no user validation errors
       if @user.save
           #log user in
           session[:user_id] = @user.id
           flash[:notice] = "Welcome to Luke's Blog #{@user.username}, you're signed up n' stuff. Go git t'articlin"
           redirect_to articles_path
       else
           render 'new'
       end
   end
   
   def destroy
       @user.destroy
       # App will throw an error if this is not included
       session[:user_id] = nil
       flash[:notice] = "Account and all associated articles deleted"
       redirect_to root_path
   end
    
end

private

def user_params
   params.require(:user).permit(:username, :email, :password)
end

def set_user
    @user = User.find(params[:id])
end

def require_same_user
   if current_user != @user
    flash[:alert] = "You can only edit your own account ya dope"
    redirect_to @user
   end
end
