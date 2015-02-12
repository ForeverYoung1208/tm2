class StatController < ApplicationController

	def index
		@date_begin ||= Time.now.to_date-1.day
		@date_end ||= Time.now.to_date

		get_orders 

	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { }
	    end
	end

	def setstatdates
		@date_begin = params[:first_date]
		@date_end = params[:last_date]

		get_orders 

	    respond_to do |format|
	      format.html { render :index }# index.html.erb
	      format.xml  { }
	    end
	end

	def routelist
		@date_begin = params[:first_date]
		@date_end = params[:last_date]
		get_orders 

	    respond_to do |format|
	      format.html { render :index }# index.html.erb
	      format.xml  { }
	    end
	end


	private

	def get_orders 
		join_str = "LEFT OUTER JOIN `odates` ON `odates`.`id` = `aorders`.`odate_id`"
      	@aorders = Aorder.joins(join_str).order('thedate').where("thedate >= '#{@date_begin}' AND thedate <= '#{@date_end}' AND iscanceled=false")

      	driver_ids=[]
      	@aorders.each {|aorder| driver_ids<<aorder.adriver.id }
		@driver_list=Adriver.where(id: driver_ids)
	end


end
