class UsersController < ApplicationController
  user = User.new(
                  name: params[:name],
                  email: params[:email],
                  password: params[:password],
                  password_confirmation: parmas[:password_confirmation] 
    )
end
