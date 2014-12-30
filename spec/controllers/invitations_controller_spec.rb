require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    
    context "with valid input" do
      after { ActionMailer::Base.deliveries.clear }
      
      it "redirects to the invitation new page" do
        set_current_user
        post :create, invitation: { recipient_name: "My Friend", recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(response).to redirect_to new_invitation_path 
      end      
      it "creates an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "My Friend", recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(Invitation.count).to eq(1)
      end  
      it "sends an email to the friend" do
        set_current_user
        post :create, invitation: { recipient_name: "My Friend", recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["myfriend@email.com"]) 
      end
      it "sets the flash success message" do
        set_current_user
        post :create, invitation: { recipient_name: "My Friend", recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(flash[:success]).to be_present
      end      
    end
    
    context "with invalid input" do
      it "does not create the invitation" do
        set_current_user
        post :create, invitation: { recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(Invitation.count).to eq(0)
      end
      it "does not send out an email" do
        set_current_user
        post :create, invitation: { message: "Hey, try out MyFlix" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it "renders the :new template" do
        set_current_user
        post :create, invitation: { recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(response).to render_template :new
      end
      it "sets the flash error message" do
        set_current_user
        post :create, invitation: { recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(flash[:error]).to be_present
      end
      it "sets @invitation" do   
        set_current_user
        post :create, invitation: { recipient_email: "myfriend@email.com", message: "Hey, try out MyFlix" }
        expect(assigns[:invitation]).to be_present
      end
    end
  end
end