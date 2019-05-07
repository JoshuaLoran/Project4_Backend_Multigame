class ApplicationController < ActionController::API
  # before_action :authorized
  #user always has to be authorized except for when creating account
  skip_before_action :authorized, only: [:create]
  ALGORITHM = 'HS256' #to be used throughout auth process


  # def create
  #   @user = User.find_by(name: params[:name])
  #   #user#authenticate comes from BCrypt
  #   if @user && @user.authenticate(params[:password]) #checks to see if pw correct
  #     #encode token from ApplicationController
  #     token = encode_token({user_id: @user.id}) #login correct, give user token
  #     render json: {user: UserSerializer.new(@user), jwt: token}, status: :accepted
  #   else
  #     render json: {message: 'Invaid name or password'}, status: :unauthorized
  #   end
  # end

  def authorized
    #going to send back JSON telling user to log in, unless they are logged in
    #calls logged_in method to check for login status
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in
  end

  def logged_in
    !!current_user
    #not not current user - makes var into boolean equivalent
    #! flips to opposite, then second ! flips it to whatever it was
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      #can access user id once token has been decoded
      @user = User.find_by(id: user_id)
      #locates the user in the server
    end
  end

  def encode_token(payload)
    JWT.encode(payload, ENV["my_secret"])
  end

  def decoded_token #accesses the token, gets token as string
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV["my_secret"], true, ALGORITHM)
      rescue JWT::DecodeError
        nil #if bad token received, nil will be returned instead of crashing server
      end
    end
  end

  def auth_header
    request.headers['Authorization']
  end
end
