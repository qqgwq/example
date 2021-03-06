class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if params[:start_at].present? and params[:end_at].present?
      @users = User.range(params[:start_at], params[:end_at]).order(created_at: :asc).page(params[:page]).per(10)
    else
      @users = User.order(created_at: :asc).page(params[:page]).per(10)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { render json: @user, status: '200' }
      format.js
    end
  end

  def export
    if params[:user_ids].present?
      @users = User.where(id: params[:user_ids].split(','))
      respond_to do |format|
        format.csv { send_data User.to_csv(@users), filename:"User.csv" }
      end
    else
      @users = User.all
      respond_to do |format|
        format.csv { send_data User.to_csv(@users), filename:"User.csv" }
      end
    end
  end

  def like
    @user = User.find(params[:id])
    @user.like << current_user.id
    @user.save!
    respond_to do |format|
      format.html
      format.js
    end
  end

  def dislike
    #binding.pry
    @user = User.find(params[:id])
    @user.like.delete(current_user.id.to_s)
    @user.save!
    respond_to do |format|
      format.html
      format.js
    end
  end

  def online
    @user = User.find(params[:id])
    @user.left!
    respond_to do |format|
      format.js
    end
  end

  def left
    @user = User.find(params[:id])
    @user.online!
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :content)
    end
end
