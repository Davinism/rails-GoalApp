require 'rails_helper'



RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user, username: "davinkim", password: "password")
  end

  subject(:saved_user) do
    FactoryGirl.create(:user, username: "jimwang", password: "password213", session_token: "ajklr23e")
  end

  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:session_token)}
  it {should validate_uniqueness_of(:session_token)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_length_of(:password).is_at_least(6)}

  it {should have_many(:goals)}
  it {should have_many(:comments)}

  describe "::find_by_credentials" do
    it "should find user by credentials if correct credentials are given" do
      saved_user.save
      user1 = User.find_by_credentials("jimwang","password213")
      expect(user1).to eq(saved_user)
    end

    it "should return nil if given incorrect credentials" do
      user1 = User.find_by_credentials("davinkim","password1")
      expect(user1).to be_nil
    end
  end

  describe "::generate_session_token" do
    it "should generate session token string" do
      expect(User.generate_session_token).to_not be_nil
    end
  end

  describe "#reset_session_token!" do
    it "should reset session token" do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end
  end

  describe "#password=" do
    it "set the password_digest" do
      user.password = "Password2"
      expect(user.password_digest).to_not be_nil
    end
  end

  describe "#is_password?" do
    it "returns true if the correct pw is given" do
      expect(user.is_password?("password")).to be true
    end

    it "returns false if the incorrect pw is given" do
      expect(user.is_password?("")).to be false
    end
  end


end
