class BoostController < ApplicationController
  before_action :set_boost, only: [:show]
  before_action :check_user

  def index
    @boosts = Boost.all
  end

  def show
  end

  private

  def check_user
    if current_user.nil?
      flash[:error] = "You need to login"
      redirect_to new_user_session_path
    end
  end

  def set_boost
    @boost = Boost.find(params[:id])
  end

  def boost_params
    params.require(:boost).permit(:content)
  end

end
