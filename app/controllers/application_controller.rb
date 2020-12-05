class ApplicationController < ActionController::Base
    
    # Make method available to views as well
    helper_method :current_user, :logged_in?
    
    def current_user
        if session[:user_id]
            #give user object from user table - only do this if not done before. This will stop the code from accessing the db every time a user accesses a page
            @current_user ||= User.find(session[:user_id])
            
        end
    end
    
    def logged_in?
        # !! turn current user into boolean
        !!current_user
    end
    
    # security feature to stop acccess to restricted actions when not logged in
    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action you shnakey bastard"
            redirect_to login_path
        end
    end
    
    
end
