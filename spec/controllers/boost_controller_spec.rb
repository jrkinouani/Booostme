require 'rails_helper'

RSpec.describe BoostController, type: :controller do

  before(:each) do 
    login_user
  end


  describe "GET #index" do
    it "populate an array og boost" do 
      @boost = FactoryGirl.create(:boost)
      get :index
      assigns(:boosts).should eq([@boost])
    end

    it "render the :index view" do 
      get :index
      response.should render_template :index
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    before(:each) do
      @boost = FactoryGirl.create(:boost)
    end


    it "assigns the requested boost to @boost" do
      get :show, id: @boost.id
      assigns(:boost).should respond_to(:content)
    end

    it "render the :show view" do
      get :show, id: @boost.id
      response.should render_template :show
    end

    it "returns http success" do
      get :show, id: @boost.id
      expect(response).to have_http_status(:success)
    end
  end

  # describe "POST #text" do
    # context "with valid attributes" do
    #   it "saves the new text boost in the database" do 
    #     boost_attr = FactoryGirl.attributes_for(:text_boost)
    #     expect{
    #       post :text, task: task_attr
    #     }.to change(Boostt, :count).by(1)
    #   end

    #   it "redirect to the new task" do
    #     task_attr = FactoryGirl.attributes_for(:task)
    #     post :create, task: task_attr
    #     response.should redirect_to Task.last
    #   end
    # end

    # context "with invalide attributes" do
    #   it "does not save new task in the database" do
    #     task_attr = FactoryGirl.attributes_for(:invalid_task)
    #     expect{
    #       post :create, task: task_attr
    #     }.to_not change(Task, :count)
    #   end

    #   it "re-renders the :new template" do 
    #     task_attr = FactoryGirl.attributes_for(:invalid_task)
    #     post :create, task: task_attr
    #     response.should render_template :new
    #   end
    # end
   #end

end
