class Admin::SystemsController < ApplicationController
    before_filter :require_admin
  def index
  end

end
