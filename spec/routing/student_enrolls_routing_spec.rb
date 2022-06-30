require "rails_helper"

RSpec.describe Api::V1::UserManagement::Student::StudentEnrollsController, type: :routing do
  describe "routing" do

    it "routes to #update via PUT" do
      expect(put: "/api/v1/user_management/student/student_enrolls").to route_to("api/v1/user_management/student/student_enrolls#update")
    end
  end
end
