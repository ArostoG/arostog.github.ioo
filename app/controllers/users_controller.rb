class UsersController < ApplicationController

    def main
        render "index"
      end


    def new
        @users = User.create(first_name:params[:first_name],last_name:params[:last_name],email:params[:email],password:params[:password])
        if @users.valid?
          redirect_to '/main' 
        else
        flash[:messages] = @users.errors.full_messages 
        redirect_to '/main' 
        end
    end

    def login
        @user = User.find_by(email:params[:email])
        if  @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to '/groups'
        else
            flash[:messages] = ["Please try again you email & password is not matching"]
            redirect_to '/main'
        end
    end

    def clear
        @users = User.find(session[:user_id])
        session.clear
        redirect_to '/main'
      end




end
