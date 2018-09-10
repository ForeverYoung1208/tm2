# encoding: utf-8

class UsersController < ApplicationController

  if ::FREE_REGISTRATION 
    before_filter :require_login, except: [:new, :create] 
  else 
    before_filter :require_login, except: [:index, :edit, :update]
  end

  before_filter :ip_change_allowed?, only: [:update]


#  
  
#    before_filter :is_admin
 
  def new
    @user = User.new( ip_address: '0.0.0.0' )
    get_companies_and_userlevels
  end

  def edit

    @user = User.find_by_id(params[:id])
    @user.ip_address ||= '0.0.0.0'
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

    filtered_params = params[:user]

    if session[:user] && is_admin?
      logger.debug "Admin #{session[:user].name} has updated user permission"
    elsif session[:user] && is_company_admin?
      filtered_params[:userlevel_id] == ::ADMIN_ID ? filtered_params[:userlevel_id] = ::COMPANY_ADMIN_ID : {}
    elsif session[:user]
      filtered_params[:userlevel_id] = session[:user].userlevel_id
      filtered_params[:company_id] = session[:user].company_id
    elsif ::FREE_REGISTRATION
      logger.debug "Free registration fiesta!!!! "
    else
      flash[:notice]="Для изменения пользователя недостаточно прав"
      redirect_to root_url
    end


    if @user.update_attributes(filtered_params)
      flash[:notice] = "#{flash[:notice]} Пользователь #{@user.name} обновелен."
      flash.keep
      redirect_to users_path
    else
      render "new"
    end
  end

  def index
    if is_admin?
      @users=User.find(:all) 
    elsif is_company_admin?
      @users=User.find_all_by_company_id(session[:user].company_id)
    elsif session[:user]
      @users=[ session[:user] ]
    elsif
      flash[:notice]="Надо зарегистрироваться в системе."
      redirect_to root_url      
    end
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
    if session[:user] && is_admin?
      @userlevels = Userlevel.find(:all)
      @companies = Company.find(:all)
    elsif session[:user] && is_company_admin?
      @userlevels = Userlevel.find_all_by_id([::COMPANY_ADMIN_ID, ::USER_ID])
      @companies = [session[:user].company]
    elsif session[:user]
      @userlevels = [session[:user].userlevel]
      @companies = [session[:user].company]
    elsif ::FREE_REGISTRATION
      @userlevels = [Userlevel.find_by_id(::USER_ID)]
      @companies = Company.find(:all)
    else
      flash[:notice]="Для добавления нового пользователя надо зарегистрироваться в системе."
      redirect_to root_url
    end
  end

  def ip_change_allowed?
    if !is_superadmin?
      params[:user].delete(:ip_address)
      params[:user].delete(:is_ip_controlled)
      flash[:notice] = "Немає можливості зміни IP-адреси. Решта змін застосовано."
    end
    flash[:notice] = "Ok"
  end

end

