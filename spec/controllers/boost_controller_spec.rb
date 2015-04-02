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

end
