require 'rails_helper'

RSpec.describe TaskController, type: :controller do

  before(:each) do 
    @user = login_user
  end

  describe "GET #index" do
    it "populates an array of tasks" do 
      task = FactoryGirl.create(:task)
      get :index 
      assigns(:tasks).should eq([task])
    end

    it "rendres the :index view" do 
      get :index
      response.should render_template :index
    end
  end

  describe "GET #category" do
    it "populates an array of tasks" do
      task_to_do = FactoryGirl.create(:task)
      task_pending = FactoryGirl.create(:task)
      task_pending.transition_pending
      get :category, state: "pending"
      assigns(:tasks).should eq([task_pending])
    end

    it "rendres the :index view" do 
      get :category, state: "pending"
      response.should render_template :category
    end
  end


  describe "GET #show" do
    it "assigns the requested task to @task" do 
      task = FactoryGirl.create(:task)
      get :show, id: task
      assigns(:task).should eql(task)
    end

    it "rendres the :show view" do 
      task =  FactoryGirl.create(:task)
      get :show, id: task 
      response.should render_template :show
    end

  end


  describe "GET #new" do
    it "assigns a new task to @task" do 
      get :new
      assigns(:task).should respond_to(:title)
      assigns(:task).should respond_to(:start_date)
      assigns(:task).should respond_to(:end_date)
    end

    it "renders the :new view" do 
      get :new
      response.should render_template :new
    end
  end


  describe "PUT #stop_timer" do
    it "change the state of the task" do
      task = FactoryGirl.create(:task)
      User.first.tasks << task
      put :stop_timer, id: task.id
      task.reload
      expect(task.state).to eql "pending"
    end

    it "rendres the :show view" do 
      task = FactoryGirl.create(:task)
      put :stop_timer, id: task.id
      response.should redirect_to Task.last
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new task in the database" do 
        task_attr = FactoryGirl.attributes_for(:task)
        expect{
          post :create, task: task_attr
        }.to change(Task, :count).by(1)
      end

      it "redirect to the new task" do
        task_attr = FactoryGirl.attributes_for(:task)
        post :create, task: task_attr
        response.should redirect_to Task.last
      end
    end

    context "with invalide attributes" do
      it "does not save new task in the database" do
        task_attr = FactoryGirl.attributes_for(:invalid_task)
        expect{
          post :create, task: task_attr
        }.to_not change(Task, :count)
      end

      it "re-renders the :new template" do 
        task_attr = FactoryGirl.attributes_for(:invalid_task)
        post :create, task: task_attr
        response.should render_template :new
      end
    end
  end

  describe "POST #text_boost" do

    context "with valid attributes" do
      it "saves the new task in the database" do 
        task = FactoryGirl.create(:task)
        boost_attr = {text: "slt yo bobi bien ou bien", type: "TextBoost"}
        expect{
          post :text_boost, id: task.id, boost: boost_attr
        }.to change(Boost, :count).by(1)
      end

      it "redirect to the new task" do
        task = FactoryGirl.create(:task)
        boost_attr = {text: "slt yo bobi bien ou bien", type: "TextBoost"}
        post :text_boost, id: task.id, boost: boost_attr
        response.should redirect_to Task.last
      end
    end

    context "with invalide attributes" do
      it "does not save new task in the database" do
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_text_invalid)
        expect{
          post :text_boost, id: task.id, boost: boost_attr
        }.to_not change(Boost, :count)
      end

      it "re-renders the :new template" do 
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_text)
        post :text_boost, id: task.id, boost: boost_attr
        response.should redirect_to Task.last
      end
    end
  end

  describe "POST #picture_boost" do

    context "with valid attributes" do
      before :each do
        @file = fixture_file_upload('spec/files/booostme_400vert.png', 'text/png')
      end

      it "saves the new picture in the database" do 
        task = FactoryGirl.create(:task)
        boost_attr = {image: @file, type: "PictureBoost"}
        expect{
          post :picture_boost, id: task.id, boost: boost_attr
        }.to change(Boost, :count).by(1)
      end

      it "redirect to the new task" do
        task = FactoryGirl.create(:task)
        boost_attr = {image: @file, type: "PictureBoost"}
        post :picture_boost, id: task.id, boost: boost_attr
        response.should redirect_to Task.last
      end
    end

    context "with invalide attributes" do
      it "does not save new picture boost in the database" do
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_picture_invalid)
        expect{
          post :picture_boost, id: task.id, boost: boost_attr
        }.to_not change(Boost, :count)
      end

      it "re-renders the :new template" do 
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_text)
        post :picture_boost, id: task.id, boost: boost_attr
        response.should redirect_to Task.last
      end
    end
  end


  describe "POST #money_boost" do

    context "with valid attributes" do

      before(:each) do
        card_data = { :number => "4242424242424242", :exp_month => 9, :exp_year => 2018, :cvc => "999" }
        card = StripeMock::Util.card_merge(card_data, {})
        card[:fingerprint] = StripeMock::Util.fingerprint(card[:number])

        @stripe_token = Stripe::Token.create(:card => card)
      end

      it "saves the new money boost in the database" do 
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_money)
        expect{
          post :money_boost, id: task.id, boost: boost_attr, stripeToken: @stripe_token.id
        }.to change(Boost, :count).by(1)
      end

      it "redirect to the new task" do
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_money)
        post :money_boost, id: task.id, boost: boost_attr, stripeToken: @stripe_token.id
        response.should redirect_to Task.last
      end
    end

    context "with invalide attributes" do
      before(:each) do
        card_data = { :number => "4242424242424242", :exp_month => 9, :exp_year => 2018, :cvc => "999" }
        card = StripeMock::Util.card_merge(card_data, {})
        card[:fingerprint] = StripeMock::Util.fingerprint(card[:number])

        @stripe_token = Stripe::Token.create(:card => card)
      end

      it "does not save new money boost in the database" do
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_picture_invalid)
        expect{
          post :money_boost, id: task.id, boost: boost_attr, stripeToken: @stripe_token.id
        }.to_not change(Boost, :count)
      end

      it "re-renders the :new template" do 
        task = FactoryGirl.create(:task)
        boost_attr = FactoryGirl.attributes_for(:boost_text)
        post :money_boost, id: task.id, boost: boost_attr, stripeToken: @stripe_token.id
        response.should redirect_to Task.last
      end
    end
  end

end
