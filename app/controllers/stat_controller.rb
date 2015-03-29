class StatController < ApplicationController
  before_filter :require_login  

	def index
		@date_begin = params[:first_date] ? params[:first_date] : Time.now.to_date-1.day
		@date_end = params[:last_date] ? params[:last_date] : Time.now.to_date
		@aorders=Aorder.get_by_dates(@date_begin, @date_end, params[:sorton])
		@auto_list=Aauto.used_in_orders(@aorders)

	end

	def index_xml
		@aorders=Aorder.get_by_dates(params[:first_date], params[:last_date])

		send_data @aorders.to_xml(
			:procs =>   [lambda{ |options, record| options[:builder].tag!('department', record.department.name) },
							lambda{ |options, record| options[:builder].tag!('driver', record.aauto.name_autodesc) if record.aauto },
							lambda{ |options, record| options[:builder].tag!('date', record.odate.thedate) },
							lambda{ |options, record| options[:builder].tag!('user_author', record.user.name) },
							lambda{ |options, record| options[:builder].tag!('ftime_xml', record.ftime.strftime("%H:%M") ) },
							lambda{ |options, record| options[:builder].tag!('totime_xml', record.totime.strftime("%H:%M") ) }

						],
			:except =>  [:aauto_id, :department_id, :odate_id, :user_id, :ftime, :totime],
			:skip_types => true
			), 
		:type => 'text/xml; charset=UTF-8;',
		:disposition => "attachment",
		:filename => "stat.xml"
	end


	def routelist
		@aorders=Aorder.get_by_dates(params[:first_date], params[:last_date]).where("aorders.aauto_id= ? ", params[:auto_id])

		@odates = Odate.used_in_orders(@aorders)

		respond_to do |format|
		  format.html # routelist.html.erb
		  format.xml  { }
		end
	end

end
