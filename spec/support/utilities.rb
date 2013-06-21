include ApplicationHelper

def fill_signup_form(user)
    fill_in "Name",             with: user.name
    fill_in "Email",            with: user.email
    fill_in "Password",         with: user.password
    fill_in "Confirmation",     with: user.password_confirmation
end

def fill_signin_form(user)
    fill_in "Email",        with: user.email
    fill_in "Password",     with: user.password
end

def fill_and_submit_signin_form(user)
    fill_signin_form(user)
    click_button "Sign in"
end