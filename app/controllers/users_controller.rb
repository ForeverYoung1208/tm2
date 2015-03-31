# encoding: utf-8

class UsersController < ApplicationController

  ::FREE_REGISTRATION ? before_filter( :require_login, except: [:new, :create] ) : (before_filter :require_login)
#  
  
#    before_filter :is_admin
 
  def new
    @user = User.new
    get_companies_and_userlevels
  end

  def edit
    @user = User.find_by_id(params[:id])
    get_companies_and_userlevels

    render "new"
  end

  def create
    @user = User.new(params[:user])
    get_companies_and_userlevels

    if @user.save

      if ::FREE_REGISTRATION
        redirect_to root_url, :notice => "Пользователь #{@user.name} создан (свободная регистрация)"
      else  
        redirect_to users_path, :notice => "Пользователь #{@user.name} создан"
      end

    else
      render "new"
    end
  end

  def update

    @user = User.find_by_id(params[:id])
    get_companies_and_userlevels

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

  private

  def get_companies_and_userlevels
    if ( session[:user] and (session[:user].userlevel_id==::ADMIN_ID) )
      @userlevels = Userlevel.find(:all)
      @companies = Company.find(:all)
    elsif session[:user]
      @userlevels = [Userlevel.find_by_id(::USER_ID)]
      @companies = [session[:user].company]
    elsif ::FREE_REGISTRATION
      @userlevels = [Userlevel.find_by_id(::USER_ID)]
      @companies = Company.find(:all)
    else
      flash[:notice]="Для добавления нового пльзователя надо зарегистрироваться в системе."
      redirect_to root_url
    end
  end
end
