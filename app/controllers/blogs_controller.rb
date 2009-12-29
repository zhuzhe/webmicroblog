class BlogsController < ApplicationController
  def index
    @posts=current_user.posts
    @post= Post.new
  end

end
