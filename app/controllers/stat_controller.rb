class StatController < ApplicationController
  before_filter :require_login	

	def index
		@date_begin = params[:first_date] ? params[:first_date] : Time.now.to_date-1.day
		@date_end = params[:last_date] ? params[:last_date] : Time.now.to_date

		get_aorders 

	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { render :xml => @aorders.to_xml }
	    end
	end

	def index_xml
		@date_begin = params[:first_date_xml]
		@date_end = params[:last_date_xml]

		get_aorders 

		send_data @aorders.to_xml, 
			:type => 'text/xml; charset=UTF-8;',
			:disposition => "attachment"
	end


	def routelist
		@date_begin = params[:first_date]
		@date_end = params[:last_date]

		get_aorders 

	    respond_to do |format|
	      format.html { render :index }# index.html.erb
	      format.xml  { }
	    end
	end


	private

	def get_aorders 
		join_str = "LEFT OUTER JOIN `odates` ON `odates`.`id` = `aorders`.`odate_id`"
      	@aorders = Aorder.joins(join_str).order('thedate').where("thedate >= '#{@date_begin}' AND thedate <= '#{@date_end}' AND iscanceled=false")

      	auto_ids=[]
      	@aorders.each {|aorder| auto_ids<<aorder.aauto.id }
		@auto_list=Aauto.where(id: auto_ids)
	end


end
