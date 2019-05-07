class AuthController < ApplicationController
  skip_before_action :authorized,  only: [:create]

  def create

    @user = User.find_by(name: params[:name])

    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })

      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else

      render json: { message: 'Invalid Username or Password' }, status: :unauthorized
    end
  end





end
