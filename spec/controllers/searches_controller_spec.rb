require_relative '../spec_helper'

describe SearchesController do
  include Devise::TestHelpers

  before do
    # request.env["devise.mapping"] = Devise.mappings[:user]
    # request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    @user = User.create(
      name:"Ryan",
      email:"12@gmail.com",
      password: "12345",
      password_confirmation: "12345"
      )
  end

  after do
    # Can't create multiple users with the same email
    User.destroy_all
  end

  describe "index" do

    it "should check the index page" do

      sign_in @user
      # assigns(:current_user).should_not be_nil
      get :index
      expect(response).to be_success
      expect(response.status).to eq 200
    end


  end

  describe "sorry" do

    it "should get a successful response" do
      get :sorry, :q => "kaskade"
      expect(response).to be_success
      expect(response.status).to eq 200
    end

  end

  describe "search" do

    it "should get a succssful response" do
      get :search, :q => "kaskade "
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "should redirect to sorry if query is empty" do
      get :search, :q => ""
    end

    it "puts a default no photo with an artist with no photo" do
      get :search, :q => "joseph vincent"
    end

  end

  describe "facebook" do

    it "should respond successfully" do
      @user = User.create(
        name:"Ryan",
        email:"12@gmail.com",
        password: "12345",
        password_confirmation: "12345"
        )
      sign_in @user
      get :facebook
    end



  end

end