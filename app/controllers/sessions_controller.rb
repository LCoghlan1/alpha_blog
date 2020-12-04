class SessionsController < ApplicationController
    
    def new
        
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Logged in successfully"
            redirect_to user
        else
            # Flash.now used as not redirecting i.e. displays regardless of http request
            flash.now[:alert] = "Login details not correct"
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out successfully"
        redirect_to root_path
    end
    
end