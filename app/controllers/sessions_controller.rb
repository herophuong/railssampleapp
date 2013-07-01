class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        user = User.find_by_email(params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            if params[:session][:remember_me]
                sign_in user, true
            else
                sign_in user, false
            end
            redirect_back_or user
        else
            flash.now[:error] = 'Invalid email/password combination'
            render 'new'
        end
    end
    
    def destroy
        sign_out
        redirect_to root_path
    end
    
end
