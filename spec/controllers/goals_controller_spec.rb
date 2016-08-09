require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe "GET #new" do
    it "renders the new goal creation page" do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "creates a new goal in the database" do
        user1 = User.create(username: "jimmy11", password:"123456")
        post :create, goal:{description: "lose 10 pounds", user_id: user1.id, privacy: "public", progress: 50}
        expect(response).to redirect_to(user_url(user1))
      end
    end

    context "with invalid params" do
      it "validates the presence of description, user_id, privacy, and progress" do
        post :create, goal:{description: "lose 10 pounds", user_id: "1"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "GET #show" do
    it "renders the goal page" do
      goal = Goal.create(description: "lose 10 pounds", user_id: "1", privacy: "public", progress: 50)
      get :show, id: Goal.last.id
      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "renders the edit goal page" do
      goal = Goal.create(description: "lose 10 pounds", user_id: "1", privacy: "public", progress: 50)
      get :edit, id: Goal.last.id
      expect(response).to render_template("edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do

    before(:each) do
      Goal.create(description: "lose 20 pounds", user_id: "1", privacy: "public", progress: 50)
    end

    context "with valid params" do
      it "updates the goal in the database" do
        user1 = User.create(username: "jimmy11", password:"123456")
        patch :update, id: Goal.last.id, goal:{ description: "lose 10 pounds", user_id: user1.id, privacy: "public", progress: 50}
        expect(response).to redirect_to(user_url(user1))
      end
    end

    context "with invalid params" do
      it "validates the presence of description, user_id, privacy, and progress" do
        user1 = User.create(username: "jimmy11", password:"123456")
        patch :update, id: Goal.last.id, goal:{description: "lose 10 pounds", user_id: user1.id, privacy: "protected"}
        expect(response).to render_template("edit")
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the goal and return to the owner's goals page" do
      user1 = User.create(username: "jimmy11", password:"123456")
      goal = Goal.create(description: "lose 20 pounds", user_id: user1.id, privacy: "public", progress: 50)
      delete :destroy, id: Goal.last.id
      expect(response).to redirect_to(user_url(id: goal.user_id))
    end
  end

end
