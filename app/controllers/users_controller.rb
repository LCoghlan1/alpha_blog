class UsersController < ApplicationController
   
   def new
       @user = User.new
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