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

	private

	def get_orders 
#		odate_first_id = Odate.find_by_thedate(@date_begin).id
#		odate_last_id = Odate.find_by_thedate(@date_end).id

		#debugger

		join_str = "LEFT OUTER JOIN `odates` ON `odates`.`id` = `aorders`.`odate_id`"

      	@aorders = Aorder.joins(join_str).order('thedate').where("thedate >= '#{@date_begin}' AND thedate <= '#{@date_end}' AND iscanceled=false")


		#join_str = "LEFT OUTER JOIN `adrivers` ON `adrivers`.`id` = `aorders`.`adriver_id`"

      	#@aorders = Aorder.joins(join_str).order(session[:sort_orders_by]).where("odate_id >= #{odate_first_id} AND odate_id <= #{odate_last_id} AND iscanceled=false")

	end


end
