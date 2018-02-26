class User::DashboardController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user_from_token!, :raise => false
  
  def show
  end
end
