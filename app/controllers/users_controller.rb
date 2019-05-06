class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.create(params)
    if @user.valid?
      render json: { user: UserSerializer.new(@user) }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end




# def create #create and save user to db
#   if User.find_by(name: params[:name]) #if username exists
#     @user = User.find_by(name: params[:name]) #assign to @user
#     render json: @user
#   else
#     @user = User.create(user_params)
#     render json: @user
#   end
# end
#
# def index
#
# end
#
# private
#
# def user_params
#   params.require(:user).permit(:name, :password)
# end


end
