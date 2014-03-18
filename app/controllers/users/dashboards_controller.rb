class Users::DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @attachments = current_user.attachments
  end
end
