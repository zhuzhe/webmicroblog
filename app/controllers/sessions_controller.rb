class SessionsController < ApplicationController
  def new

  end

  def create
    @user=User.authencate(params[:email],params[:password])
    if @user
      session[:user_id]=@user.id
     redirect_to posts_path
    else
      flash[:notice]='invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:notice]='you already log out'
    redirect_to new_session_path
  end


end
