require "spec_helper"

describe UserMailer do
    describe "password reset" do
        let(:user) { Factory.create(:user, password_reset_token: "anything") }
        let(:mail) { UserMailer.password_reset(user) }
        
        it "send user password reset url" do
            mail.subject.should == "Password Reset"
            mail.to.should == [user.email]
            mail.from.should == ["from@example.com"]
        end
        
        it "renders the body" do
            mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
        end
    end
end
