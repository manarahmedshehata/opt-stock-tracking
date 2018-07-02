class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  def_param_group :user do
    param :name, String, "user name", :required => true
  end

  # GET /users
  api :GET, "users", "Get all users"
  returns :array_of => :user
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  api :GET, "users/:id", "Get an user"
  returns :user
  def show
    render json: @user
  end

  # POST /users
  api :POST, "users", "Create a user"
  param_group :user
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  api :PUT, "users/:id", "Update an user"
  param_group :user
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  api :DELETE, "users/:id", "Delete an user"
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end
end
