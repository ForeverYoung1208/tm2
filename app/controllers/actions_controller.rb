# encoding: utf-8

require 'date'
class ActionsController < ApplicationController
  before_action :require_login
  before_action :check_tabel_rights



  # GET /actions
  # GET /actions.xml
  
  def index
    @actions = Action.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actions }
    end
  end

  def tabel

    params[:company_id] && @company=Company.find_by_id(params[:company_id])
    @company||=session[:user].company

    if is_admin?
      @company ? @users=@company.users.all : @users=User.all
      @companies=Company.find(:all)
    elsif is_alltabeluser?
      @company ? @users=@company.users.all : @users=User.all
      @companies=Company.find(:all)
    else
      @users=@company.users.all
      @companies=[session[:user].company]
    end
    
    @odate=session[:working_date]
    @odate.thedate=params[:tek_date] if params[:tek_date]
    @year=session[:working_date].thedate.year
    @month=session[:working_date].thedate.month
    @day=session[:working_date].thedate.day

    @days_in_month=days_in_month(@month, @year)


  end

  # GET /actions/1
  # GET /actions/1.xml
=begin
  def show
    @action = Action.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action }
    end
  end
=end

  # GET /actions/new
  # GET /actions/new.xml
  def new
    @action = Action.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action }
    end
  end
=begin
  # GET /actions/1/edit
  def edit
    @action = Action.find(params[:id])
  end
=end

  # POST /actions
  # POST /actions.xml
  def create
    @action = Action.new(params[:action])

    respond_to do |format|
      if @action.save
        format.html { redirect_to(@action, :notice => 'Action was successfully created.') }
        format.xml  { render :xml => @action, :status => :created, :location => @action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end

=begin
  # PUT /actions/1
  # PUT /actions/1.xml
  def update
    @action = Action.find(params[:id])

    respond_to do |format|
      if @action.update_attributes(params[:action])
        format.html { redirect_to(@action, :notice => 'Action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end
=end

=begin
  # DELETE /actions/1
  # DELETE /actions/1.xml
  def destroy
    @action = Action.find(params[:id])
    @action.destroy

    respond_to do |format|
      format.html { redirect_to(actions_url) }
      format.xml  { head :ok }
    end
  end
=end

  private
  def days_in_month(month, year)
    (Date.new(year,12,31).to_date<<(12-month)).day
  end



end
