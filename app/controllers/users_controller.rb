class UsersController < ApplicationController
   
   def show
       @user = User.find(params[:id])
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
       @user = User.find(params[:id])
   end
   
   def update
       @user = User.find(params[:id])
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
           flash[:notice] = "Welcome to Luke's Blog #{@user.username}, you're signed up n' stuff. Go git t'articlin"
           redirect_to articles_path
       else
           render 'new'
       end
   end
    
end

private

def user_params
   params.require(:user).permit(:username, :email, :password)
end