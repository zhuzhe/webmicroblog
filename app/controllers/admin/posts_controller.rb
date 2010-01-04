class Admin::PostsController < ApplicationController
  before_filter :require_admin
  def index
    @posts=Post.all
  end
end
