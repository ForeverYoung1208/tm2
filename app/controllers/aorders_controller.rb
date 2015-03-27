# encoding: utf-8

class AordersController < ApplicationController
  before_filter :require_login
  before_filter :is_admin, :only => [:set_day_status]
  before_filter :is_day_closed, :only => [:ocancel, :new, :create, :update, :destroy]

  def uporderstable
    if session[:user]

      last_today_act = session[:user].actions.where("created_at>'#{DateTime.current.beginning_of_day.to_s(:db)}' and created_at<'#{DateTime.current.end_of_day.to_s(:db)}'").last

      last_today_act.update_attributes!(
        :kind=>"stay_in",
        :updated_at => DateTime.current
      )

      @odate = session[:working_date]
      @aorders = Aorder.joins("LEFT OUTER JOIN `aautos` ON `aautos`.`id` = `aorders`.`aauto_id`").where("odate_id=#{@odate.id} AND iscanceled=false").order(session[:sort_orders_by])
      @aorder = Aorder.new
      @aorder.odate=@odate
      @aorder.iscanceled=false
      @aorder.outofcity=0
      @aorder.user_id=session[:user].id if session[:user]
      @aorder.ftime=Time.now.localtime
      @aorder.totime=Time.now.localtime

      @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)

      @onlineauto=Onlineauto.new
      @onlineauto.odate_id=@odate.id
    else
      logger.info("No user logged in!")
      render :nothing => true
    end

  end

  def set_day_status
    begin
      @odate=Odate.set_day_status(params)
      session[:working_date]=@odate
      session[:error_text]='Готово.'
    rescue TraficError => e
      session[:error_text]="Ошибка: #{e.message}"
    end
    flash[:notice]=session[:error_text]
    redirect_to aorders_path
  end

  def setdate
    if not session[:working_date]=Odate.find_by_thedate(params[:tek_date])
      d=Odate.new
      d.isclosed=false
      d.thedate=params[:tek_date]
      d.save
      session[:working_date]=d
    end
    redirect_to aorders_path
  end

#  def setosort
#    session[:sort_orders_by]=params[:sorton]
#    redirect_to aorders_path
#  end

  def ocancel
    @aorder=Aorder.find_by_id(params[:id])
    @aorder.iscanceled=true
    @aorder.ttmid=session[:user].id
    @aorder.save!
    redirect_to aorders_path
  end

  # GET /aorders
  # GET /aorders.xml
  def index

    @error_text=session[:error_text]
    session[:error_text]=nil
    @odate = session[:working_date]

    params[:sorton] ? (session[:sort_orders_by] = params[:sorton]) : (session[:sort_orders_by]||='id')

    @aorders = Aorder.joins("LEFT OUTER JOIN `aautos` ON `aautos`.`id` = `aorders`.`aauto_id`").where("odate_id=#{@odate.id} AND iscanceled=false").order(session[:sort_orders_by])
    @aorder = Aorder.new
    @aorder.odate=@odate
    @aorder.iscanceled=false
    @aorder.user_id=session[:user].id
    @aorder.ftime=Time.now.localtime
    @aorder.totime=Time.now.localtime

    @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)

    @onlineauto=Onlineauto.new
    @onlineauto.odate_id=@odate.id

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aorder }
    end

  end

  # GET /aorders/1
  # GET /aorders/1.xml
  def show
    @aorder = Aorder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aorder }
    end
  end

  # GET /aorders/new
  # GET /aorders/new.xml
  def new
    @aorder = Aorder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aorder }
    end
  end

  # GET /aorders/1/edit
  def edit

    @odate = session[:working_date]
    @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)
  
    @aorder = Aorder.find(params[:id])
    @aorder.user_id=session[:user].id unless is_admin?
    @aorder.ttmid=session[:user].id
  end

  def edit_odometer

    @odate = session[:working_date]
    @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)
    @aorder = Aorder.find(params[:id])
    @aorder.user_id = session[:user].id unless is_admin?
    @aorder.ttmid = session[:user].id
    @aorder.is_updating_odometer = true

    respond_to do |format|
      format.html
    end
  end

  # POST /aorders
  # POST /aorders.xml
  def create
    @odate = session[:working_date]    
    @aorder = Aorder.new(params[:aorder])
    @aorder.ttmid=session[:user].id
    @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)
        
    respond_to do |format|
      if @aorder.save
        format.html { redirect_to(aorders_path, :notice => 'Aorder was successfully created.') }
        format.xml  { render :xml => @aorder, :status => :created, :location => @aorder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aorder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aorders/1
  # PUT /aorders/1.xml
  def update
    @odate = session[:working_date]
    @aorder = Aorder.find(params[:id])
    @aorder.ttmid=session[:user].id

    @onlineautos=Onlineauto.find_all_by_odate_id_puls_empty(@odate.id)

    respond_to do |format|
      if @aorder.update_attributes(params[:aorder])
        format.html { redirect_to(aorders_path, :notice => 'Заказ изменен.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @aorder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aorders/1
  # DELETE /aorders/1.xml
  def destroy
    @aorder = Aorder.find(params[:id])
    @aorder.ttmid=session[:user].id
    @aorder.destroy

    respond_to do |format|
      format.html { redirect_to(aorders_url) }
      format.xml  { head :ok }
    end
  end



end
