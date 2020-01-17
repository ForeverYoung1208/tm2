class CallistsController < ApplicationController
  before_action :require_login
  # GET /callists
  # GET /callists.json
  def index
    @callists = Callist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @callists }
    end
  end

  # GET /callists/1
  # GET /callists/1.json
  def show
    @callist = Callist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @callist }
    end
  end

  # GET /callists/new
  # GET /callists/new.json
  def new
    @callist = Callist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @callist }
    end
  end

  # GET /callists/1/edit
  def edit
    @callist = Callist.find(params[:id])
  end

  # POST /callists
  # POST /callists.json
  def create
    @callist = Callist.new(params[:callist])
    if params[:callist][:callsfile]
      callsfile = params[:callist][:callsfile]
      @callist.data = callsfile.read
      @callist.filename = callsfile.original_filename
    end


    respond_to do |format|
      if @callist.save
        format.html { redirect_to @callist, notice: 'Callist was successfully created.' }
        format.json { render json: @callist, status: :created, location: @callist }
      else
        format.html { render action: "new" }
        format.json { render json: @callist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /callists/1
  # PUT /callists/1.json
  def update
    @callist = Callist.find(params[:id])
    if params[:callist][:callsfile]
      callsfile = params[:callist][:callsfile]
      callsfile.rewind
      @callist.data = callsfile.read
      @callist.filename = callsfile.original_filename
    end
    
    respond_to do |format|
      if @callist.update_attributes(params[:callist])
        format.html { redirect_to @callist, notice: 'Callist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @callist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callists/1
  # DELETE /callists/1.json
  def destroy
    @callist = Callist.find(params[:id])
    @callist.destroy

    respond_to do |format|
      format.html { redirect_to callists_url }
      format.json { head :no_content }
    end
  end
end
