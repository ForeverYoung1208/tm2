# encoding: utf-8

class SessionsController < ApplicationController
  def new
    session[:working_date] = Odate.get_today
  end
 
  def create
     user = User.authenticate(params[:name], params[:password])
     if user
       session[:user] = user
       user.actions.create( :kind => "login" )
       user.actions.create( :kind => "stay_in")
       redirect_to aorders_path
     else
       flash.now.alert = "неправильные имя или пароль"
       render "new"
     end
   end

  def destroy
      session[:user] = nil
      redirect_to root_url, :notice => "Logged out!"
  end

end
