class SessionsController < ApplicationController
  skip_before_filter :require_login
  def new

  end

  def create
    @user=User.authenticate(params[:email],params[:password])
    if @user
      session[:user_id]=@user.id
     redirect_to blogs_path
    else
      flash[:notice]='invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:notice]='you already log out'
    render 'new'
  end


end
