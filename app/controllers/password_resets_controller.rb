class PasswordResetsController < ApplicationController
    before_filter :signed_in_user_should_not_visit, only: [:new, :create]
    
    def new
    end
    
    def create
        @user = User.find_by_email(params[:email])
        if @user.nil?
            flash[:error] = "Invalid email!"
            render 'new'
        else
            @user.send_password_reset
            flash[:success] = "An e-mail with password reset instruction has been sent to your mailbox"
            redirect_to reset_password_path
        end
    end
    
    def edit
        @user = User.find_by_password_reset_token!(params[:id])
    end
end
