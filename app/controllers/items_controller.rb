class ItemsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:create, :new, :update, :destroy]

  def index
    
  end
end
