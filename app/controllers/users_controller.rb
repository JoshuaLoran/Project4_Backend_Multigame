class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :update]

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { user: UserSerializer.new(@user) }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    @user = User.find_by({id: user_params[:id]})
    @user.update(user_params)
    render json: @user
  end

  def profile
    render json: {user: UserSerializer.new(current_user)}, status: :accepted
  end

  private
   def user_params
     params.permit(:name, :password, :wins, :id)
   end

end
