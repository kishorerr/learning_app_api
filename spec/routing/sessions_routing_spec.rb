require "rails_helper"

RSpec.describe Api::V1::UserManagement::Student::Auth::SessionsController, type: :routing do
  describe "routing" do

    it "routes to #create via POST" do
      expect(post: "/api/v1/user_management/student/auth/signin").to route_to("api/v1/user_management/student/auth/sessions#create")
    end

    it "routes to #destroy via DELETE" do
        expect(delete: "/api/v1/user_management/student/auth/signout").to route_to("api/v1/user_management/student/auth/sessions#destroy")
    end
  end
end
