class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		flash[:success] = "Thank you for logging in!"
  		redirect_to todo_lists_path
  	else
  		flash[:error] = "There was an error with your credentials.  Please check your email and password."
  		render action: 'new'
  	end
  end
end
