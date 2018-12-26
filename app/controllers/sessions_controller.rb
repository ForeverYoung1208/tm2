# encoding: utf-8

class SessionsController < ApplicationController
  def new
    session[:working_date] = Odate.get_or_create_by_date(Time.now.to_date)
  end
 
  def create
     user = User.authenticate(params[:name], params[:password])
     if user && user.ip_check( request.remote_ip )
       session[:user] = user
       user.actions.create( :kind => "login" )
       user.actions.create( :kind => "stay_in")
       redirect_to aorders_path
     else
       flash.now.alert = user ? "неправильный IP: ожидается #{ user.ip_address }; получен #{ request.remote_ip }" :  "неправильные имя или пароль"
       render "new"
     end
   end

  def destroy
    session[:user] = nil
    reset_session
    redirect_to root_url, :notice => "Logged out!"
  end

end
