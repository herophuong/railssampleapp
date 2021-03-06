module SessionsHelper
    
    def sign_in(user, remember_me = false)
        if remember_me
            cookies.permanent[:remember_token] = user.remember_token
        else
            cookies[:remember_token] = user.remember_token
        end
        self.current_user = user
    end
    
    def current_user=(user)
        @current_user = user
    end
    
    def current_user
        @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
    
    def current_user?(user)
        current_user == user
    end
    
    def signed_in_user
        unless signed_in?
            store_location
            redirect_to signin_path, notice: "Please sign in."
        end
    end
    
    def signed_in?
        !current_user.nil?
    end
    
    def sign_out
        self.current_user = nil
        cookies.delete(:remember_token)
    end
    
    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end
    
    def store_location
        session[:return_to] = request.fullpath
    end
    
    def signed_in_user_should_not_visit
        redirect_to(root_path) unless current_user.nil?
    end
end
