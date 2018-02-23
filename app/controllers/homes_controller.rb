class HomesController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
  end

  def search

  end

  def products
  end
end
