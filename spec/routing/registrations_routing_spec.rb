require "rails_helper"

RSpec.describe Api::V1::UserManagement::Student::Auth::RegistrationsController, type: :routing do
  describe "routing" do

    it "routes to #create via POST" do
      expect(post: "/api/v1/user_management/student/auth/signup").to route_to("api/v1/user_management/student/auth/registrations#create")
    end

    it "routes to #verify_otp via POST" do
        expect(post: "/api/v1/user_management/student/auth/verify_otp").to route_to("api/v1/user_management/student/auth/registrations#verify_otp")
    end

    it "routes to #update via PUT" do
        expect(put: "/api/v1/user_management/student/auth/otp_num_change").to route_to("api/v1/user_management/student/auth/registrations#update")
    end
  end
end
