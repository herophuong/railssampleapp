require 'spec_helper.rb'

describe "Password Reset Page" do
    
    subject { page }
    
    describe "Form" do
        before { visit reset_password_path }
        let(:user) { FactoryGirl.create(:user) }
        
        it { should have_selector('title', text: full_title("Reset Password")) }
        
        describe "when user signed in" do
            before { sign_in user }
            
            describe "should not show up" do
                before { get reset_password_path }
                it { response.should redirect_to(root_path) }
            end
            
            describe "should not allow reset request" do
                before { post password_resets_path }
                it {response.should redirect_to(root_path) }
            end
        end
        
        describe "submitting invalid email" do
            before { click_button "Send Email Request" }
            
            it "should have errors" do
                should have_selector('div.alert.alert-error', text: "Invalid email")
                should have_selector('title', text: full_title("Reset Password"))
            end
        end
        
        describe "submitting valid email" do
            before do
                fill_in "Email", with: user.email
                click_button "Send Email Request"
            end
            
            it "should give success" do
                should have_selector('div.alert.alert-success', text: "password reset")
                should have_selector('title', text: full_title("Reset Password"))
            end
            
            it "should send password reset email to user" do
                last_email.to.should include(user.email)
            end
        end
    end
end
