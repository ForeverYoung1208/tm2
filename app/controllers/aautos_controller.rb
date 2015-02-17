# encoding: utf-8

class AautosController < ApplicationController
  before_filter :is_admin, :except => [:index, :show]
 

  # GET /aautos
  # GET /aautos.xml
  def index
    @adrivers = Aauto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aautos }
    end
  end

  # GET /aautos/1
  # GET /aautos/1.xml
  def show
    @adriver = Aauto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aauto }
    end
  end

  # GET /aautos/new
  # GET /aautos/new.xml
  def new
    @adriver = Aauto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aauto }
    end
  end

  # GET /aautos/1/edit
  def edit
    @adriver = Aauto.find(params[:id])
  end

  # POST /aautos
  # POST /aautos.xml
  def create
    @adriver = Adriver.new(params[:aauto])

    respond_to do |format|
      if @aauto.save
        format.html { redirect_to(@adriver, :notice => 'Aauto was successfully created.') }
        format.xml  { render :xml => @adriver, :status => :created, :location => @aauto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aauto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aautos/1
  # PUT /aautos/1.xml
  def update
    @adriver = Aauto.find(params[:id])

    respond_to do |format|
      if @adriver.update_attributes(params[:aauto])
        format.html { redirect_to(@adriver, :notice => 'Aauto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @aauto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aautos/1
  # DELETE /aautos/1.xml
  def destroy
    @adriver = Aauto.find(params[:id])
    @aauto.destroy

    respond_to do |format|
      format.html { redirect_to(aautos_url) }
      format.xml  { head :ok }
    end
  end
end
