class BlogsController < ApplicationController
  def index
    @posts=current_user.posts
    @post= Post.new
  end


  def  show
    @posts=User.find(params[:id]).posts
  end

  def search
    @users=User.all
#      @users=User.find_by_solr(params[:key])
    respond_to do |format|
      format.js
      format.html
      format.xml  { render :xml => @users }
    end
   
  end

  def master
    @users=current_user.masters
  end

  def follow
      @user=User.find(params[:id])
      if current_user.masters.include?(@user)
        flash[:notice]='you already have followed this blog'
        redirect_to  master_blogs_path
        return
      end
      current_user.masters<<@user
      if current_user.save
          redirect_to master_blogs_path
      else
#        flash[:notice]='please try again'
        redirect_to master_blogs_path
      end
      return
  end
end
