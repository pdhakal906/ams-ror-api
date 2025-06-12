class Api::UsersController < ApplicationController
  include Paginatable
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :authenticate, except: [ :create ]


  # GET /api/users
  def index
    users = paginate(User.all)
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(users, each_serializer: UserSerializer),
      meta: paginate_meta(users)
    }
  end

  # GET /api/users/:id
  def show
    user = User.find(params[:id])
    render json: user
  end

  # POST /api/users
  def create
    user = User.new(user_create_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PUT/PATCH /api/users/:id
  def update
    user = User.find(params[:id])
    if user.update(user_update_params)
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end

  rescue ArgumentError => e
      render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /api/users/:id
  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

  def user_create_params
  params.permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :phone,
    :dob,
    :gender,
    :address,
    :role
  )
  end

  def user_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone,
      :dob,
      :gender,
      :address
    )
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end
end
