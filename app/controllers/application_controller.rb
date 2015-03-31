# encoding: utf-8

class ApplicationController < ActionController::Base
    protect_from_forgery


    ::USER_ID=1 #userlevel_id
    ::ADMIN_ID=2 #userlevel_id
#    ::NO_COMPANY_ID=5 
    ::USERTABEL_ID=3 #userlevel_id
    ::ALLTABELUSER_ID=4 #userlevel_id
    ::DRIVERUSER_ID=5 #userlevel_id

    ::NILDRIVER=6  #aauto_id
    ::DEF_PWD='123'
    ::MONTHNAMES_RUS = ["Ъ","Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Окрябрь","Ноябрь","Декабрь"]
 
    ::FREE_REGISTRATION = true
#    ADMIN_ID=::ADMIN_ID

    helper_method :is_admin?, :is_current_user_or_admin?, :check_tabel_rights?, :is_current_user_driver?

    class TraficError < StandardError
    end


    def is_admin?
      session[:user].userlevel_id == ::ADMIN_ID if session[:user]
    end

    def is_alltabeluser?
      session[:user].userlevel_id == ::ALLTABELUSER_ID if session[:user]
    end

    def is_current_user_or_admin?(checked_id)
      res=false
      if session[:user]
        res=true if session[:user].id == checked_id
        res=true if session[:user].userlevel_id == ::ADMIN_ID
      end
      res
    end

    def is_current_user_driver?
      session[:user].userlevel_id == ::DRIVERUSER_ID if session[:user]
    end


    def is_admin
      if not session[:user].userlevel_id == ::ADMIN_ID
        redirect_to root_url, :notice => "Действие не разрешено (только для админа)"
      end
    end

    def is_day_closed
      if session[:working_date].isclosed
        flash[:notice]="Невозможно выполнить, т.к. дата закрыта"
        flash.keep
        redirect_to aorders_path
      end
    end

    def require_login
      unless session[:user]
        flash[:notice]="Действие не разрешено (только для зарегистрированного пользователя)"
        flash.keep
        redirect_to root_url
      end
    end

    def check_tabel_rights?
      if (session[:user].userlevel_id== ::ADMIN_ID) or
          (session[:user].userlevel_id==::USERTABEL_ID) or
          (session[:user].userlevel_id==::ALLTABELUSER_ID)
        true
      else
        false
      end
    end

  def check_tabel_rights
    unless (session[:user].userlevel_id== ::ADMIN_ID) or
        (session[:user].userlevel_id==::USERTABEL_ID) or
          (session[:user].userlevel_id==::ALLTABELUSER_ID)
        
        redirect_to root_url, :notice => "Действие не разрешено (только для табелирующих)"
    end
  end





end
