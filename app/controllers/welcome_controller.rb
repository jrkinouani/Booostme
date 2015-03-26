class WelcomeController < ApplicationController
  def index
    @tasks = Task.last(3)
  end
end
