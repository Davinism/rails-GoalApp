require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the sign up page" do
      get :new, user: {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "creates a new user in the database" do
        post :create, user:{username: "Jimmy", password: "hellow1"}
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "validates the presence of username and session_token and password_digest" do
        post :create, user:{username: "hello"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

  end

  describe "GET #show" do
    it "renders the User's home page" do
      user = User.create(username: "jimmy2" ,password: "123456")
      get :show, id: User.last.id
      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "renders the index page of all users" do
      get :index, user: {}
      expect(response).to render_template("index")
      expect(response).to have_http_status(200)
    end
  end

end
