class StatController < ApplicationController

	def index
		@date_begin ||= Time.now.to_date
		@date_end ||= Time.now.to_date+1.day

		join_str = "LEFT OUTER JOIN `adrivers` ON `adrivers`.`id` = `aorders`.`adriver_id`"
		odate_first = Odate.find_by_thedate(@date_begin)  блять ебучая проблма поиска первой Одаты
		odate_last = Odate.find_by_thedate(@date_last)     и последней одаты. и нахера я вообще это лепил?
      	@aorders = Aorder.joins(join_str).order(session[:sort_orders_by]).where("odate_id > #{odate_first.id} AND odate_id < #{odate_last.id} AND iscanceled=false")

	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { }
	    end
	end

	def setstatdates
		@date_begin = params[:first_date]
		@date_end = params[:last_date]

	    respond_to do |format|
	      format.html { render :index }# index.html.erb
	      format.xml  { }
	    end
	end


end
