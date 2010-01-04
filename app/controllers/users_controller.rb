class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  skip_before_filter :require_login,:only=>[:new]
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.group=Group.first(:conditions=>{:group_name=>'common'})
    upload
    respond_to do |format|
      if @user.save
        flash[:notice] = 'You already become a member,please login'
        format.html { redirect_to(new_session_path) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash[:notice]='regist fail,please try again'
        format.html {render 'new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @user.attributes=params[:user]
    upload
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def upload
    uploaded_io = params[:user][:picture]
    File.open(Rails.root.join('public', 'user_picture', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read)
    end
    @user.picture="/user_picture/"+uploaded_io.original_filename
  end
end
