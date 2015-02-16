# encoding: utf-8

class AdriversController < ApplicationController
  before_filter :is_admin, :except => [:index, :show]
 

  # GET /adrivers
  # GET /adrivers.xml
  def index
    @adrivers = Adriver.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adrivers }
    end
  end

  # GET /adrivers/1
  # GET /adrivers/1.xml
  def show
    @adriver = Adriver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adriver }
    end
  end

  # GET /adrivers/new
  # GET /adrivers/new.xml
  def new
    @adriver = Adriver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adriver }
    end
  end

  # GET /adrivers/1/edit
  def edit
    @adriver = Adriver.find(params[:id])
  end

  # POST /adrivers
  # POST /adrivers.xml
  def create
    @adriver = Adriver.new(params[:adriver])

    respond_to do |format|
      if @adriver.save
        format.html { redirect_to(@adriver, :notice => 'Adriver was successfully created.') }
        format.xml  { render :xml => @adriver, :status => :created, :location => @adriver }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adriver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adrivers/1
  # PUT /adrivers/1.xml
  def update
    @adriver = Adriver.find(params[:id])

    respond_to do |format|
      if @adriver.update_attributes(params[:adriver])
        format.html { redirect_to(@adriver, :notice => 'Adriver was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adriver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adrivers/1
  # DELETE /adrivers/1.xml
  def destroy
    @adriver = Adriver.find(params[:id])
    @adriver.destroy

    respond_to do |format|
      format.html { redirect_to(adrivers_url) }
      format.xml  { head :ok }
    end
  end
end
