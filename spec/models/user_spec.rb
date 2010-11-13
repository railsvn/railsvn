require "#{File.dirname(__FILE__)}/../spec_helper"

describe User do
  describe "validations" do
    it { should validate_presence_of(:display_name) }

    it { should validate_presence_of(:email) }
    it "should validate uniqueness of email" do
      Factory.create(:user)
      should validate_uniqueness_of(:email)
    end
    it "should validate format of email" do
      should validate_format_of(:email).with('someone@example.com')
      should validate_format_of(:email).with('some.one@example.com.vn')
      should validate_format_of(:email).not_with('someone').with_message(/is invalid/)
      should validate_format_of(:email).not_with('someone@').with_message(/is invalid/)
      should validate_format_of(:email).not_with('someone@example').with_message(/is invalid/)
      should validate_format_of(:email).not_with('@example.com').with_message(/is invalid/)
    end
  end

  describe "associations" do
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:comments).dependent(:delete_all) }
  end
end
