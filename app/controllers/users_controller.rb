class UsersController < ApplicationController

def create #create and save user to db
  if User.find_by(name: params[:name]) #if username exists
    @user = User.find_by(name: params[:name]) #assign to @user
    render json: @user
  else
    @user = User.create(user_params)
    render json: @user
  end
end

def index

end

private

def user_params
  params.require(:user).permit(:name)
end


end
