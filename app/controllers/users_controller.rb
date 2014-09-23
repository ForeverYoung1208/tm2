# encoding: utf-8

class UsersController < ApplicationController
#    before_filter :is_admin
 
   def new
     @user = User.new
     if session[:user] and (session[:user].userlevel_id==::ADMIN_ID) or true
       @userlevels = Userlevel.find(:all)
       @companies = Company.find(:all)
     elsif session[:user]
# забавное решение, но...       @userlevels = Userlevel.find(:all, :conditions => "name REGEXP 'Пользователь*'")
       @userlevels = [Userlevel.find_by_id(::USER_ID)]
       @companies = [session[:user].company]
     else
       flash[:notice]="Для добавления нового пльзователя надо зарегистрироваться в системе."
       redirect_to root_url
     end


   end

   def edit
     @user = User.find_by_id(params[:id])
     if session[:user] and (session[:user].userlevel_id==::ADMIN_ID)
       @userlevels = Userlevel.find(:all)
       @companies = Company.find(:all)
     else
# забавное решение, но...        @userlevels = Userlevel.find(:all, :conditions => "name REGEXP 'Пользователь*'")
       @userlevels = [Userlevel.find_by_id(::USER_ID)]
       @companies = [session[:user].company]
     end
     render "new"
   end

   def create
     @user = User.new(params[:user])
     if @user.save
       redirect_to users_path, :notice => "Пользователь #{@user.name} создан"
     else
       render "new"
     end
   end

   def update
     @user = User.find_by_id(params[:id])
     if @user.update_attributes(params[:user])
       redirect_to users_path, :notice => "Пользователь #{@user.name} обновелен"
     else
       render "new"
     end
   end

   def index
     @users=User.find(:all) if is_admin?
     @users=User.find_all_by_id(session[:user].id) if !is_admin?
   end

   def password_reset
     u=User.find_by_id(params[:id])
     u.password=::DEF_PWD
     u.save
     flash[:notice]="Пароль пользователя #{u.name} типа сброшен"
     redirect_to users_path
   end
end
