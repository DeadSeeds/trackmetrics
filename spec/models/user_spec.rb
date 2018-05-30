require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@user.com", password: "password") }
  
  describe "attributes" do
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
  end
end
