class StatController < ApplicationController
	include ApplicationHelper
  before_action :require_login  

	def index
		@date_begin = params[:first_date] ? params[:first_date] : Time.now.to_date-1.day
		@date_end = params[:last_date] ? params[:last_date] : Time.now.to_date
		@aorders=Aorder.get_by_dates(@date_begin, @date_end, params[:sorton]).order(:ftime)
		@auto_list=Aauto.used_in_orders(@aorders)

	end

	def index_xml
		@aorders=Aorder.get_by_dates(params[:first_date], params[:last_date])

		send_data @aorders.to_xml(
			:procs =>   [lambda{ |options, record| options[:builder].tag!('department', record.department.name) },
							lambda{ |options, record| options[:builder].tag!('driver', record.aauto.name_autodesc) if record.aauto },
							lambda{ |options, record| options[:builder].tag!('date', record.odate.thedate) },
							lambda{ |options, record| options[:builder].tag!('distance', record.distance) },
							lambda{ |options, record| options[:builder].tag!('user_author', record.user.name) },
							lambda{ |options, record| options[:builder].tag!('ftime_xml', record.ftime.strftime("%H:%M") ) },
							lambda{ |options, record| options[:builder].tag!('totime_xml', record.totime.strftime("%H:%M") ) },
							lambda{ |options, record| options[:builder].tag!('totaltime_seconds', record.duration_seconds ) }
						],
			:except =>  [:aauto_id, :department_id, :odate_id, :user_id, :ftime, :totime, :iscanceled, :ondepartment, :updated_at],
			:skip_types => true
			), 
		:type => 'text/xml; charset=UTF-8;',
		:disposition => "attachment",
		:filename => "stat_#{params[:first_date]}-#{params[:last_date]}.xml"
	end


	def routelist
#	@aorders = Aorder.get_by_dates(params[:first_date], params[:last_date]).where("aorders.aauto_id= ? ", params[:auto_id])
#	@odates = Odate.used_in_orders(@aorders).order(:thedate)

# получаем массив  интересующих нас aorders по датам и машине
		aorders = Aorder.get_by_dates( params[:first_date], params[:last_date] ).where("aorders.aauto_id IN (?) ", params[:auto_id]).reorder(:thedate)

# получаем idшки дней где оно біло
		used_odate_ids = aorders.pluck(:odate_id).uniq

#формируем хеш {дата  => [масив ордеров] }
		@days_of_orders={}

		used_odate_ids.each do |curr_odate_id|
			@days_of_orders[ Odate.find_by_id(curr_odate_id) ] = aorders.where("odate_id = ?", curr_odate_id).order(:ftime)
		end


		# @auto = Aauto.find_all_by(id: params[:auto_id])
		@auto = Aauto.find(params[:auto_id])

		respond_to do |format|
		  format.html # routelist.html.erb
		  format.xml  { }
		end
	end

end
