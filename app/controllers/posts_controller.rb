class PostsController < ApplicationController
skip_before_filter :authorizeUser, :only => ['show']
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @user = User.find(current_user)
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id || @user.status != "Administrator"
	redirect_to(post_path(@post.id))
	flash[:notice] = "Can't Edit what aint urs!! :O"
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    @post.thred_id = session[:threds_id]

    respond_to do |format|
      if @post.save
        format.html { redirect_to(thred_path(@post.thred_id)) }
	flash[:notice] = 'Post was successfully created.'
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
	if @post.user_id == current_user.id
    @post.destroy
end

    respond_to do |format|
      format.html { redirect_to(:controller => "topics", :action => "topicsList") }
      format.xml  { head :ok }
    end
  end
end
