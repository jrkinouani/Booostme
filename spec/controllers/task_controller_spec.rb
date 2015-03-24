require 'rails_helper'

RSpec.describe TaskController, type: :controller do

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

end
