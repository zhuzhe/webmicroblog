class Admin::UsersController < ApplicationController
  def index
    @common_users=Group.first(:conditions=>{:group_name=>'common'}).users

  end

  def new
    @user=User.new
  end

  def create
    @user = User.new(params[:user])
    @user.group=Group.first(:conditions=>{:group_name=>'admin'})
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Admin was successfully created.'
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def change_state
   @user= User.find(params[:id])
   state=@user.active
  if  state
    state=false
  else
    state=true
  end
  @user.active=state
   if @user.save
     respond_to do |format|
       format.html {redirect_to 'index'}
       format.js 
     end
   else
     flash[:notice]="error please try again"
     redirect_to 'index'
   end



  end
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'your accout was successfully updated.'
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

  end

  def edit
    @user=User.find(params[:id])
  end


end
