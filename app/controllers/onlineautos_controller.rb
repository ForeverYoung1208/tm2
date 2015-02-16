# encoding: utf-8

class OnlinedriversController < ApplicationController
 
  # POST /aorders
  # POST /aorders.xml
  def create
    @onlinedriver=Onlinedriver.new(params[:onlinedriver])
    @onlinedriver.save!
    redirect_to aorders_path
  end

  # DELETE /aorders/1
  def destroy
    @onlinedriver = Onlinedriver.find(params[:id])
    @onlinedriver.destroy

    redirect_to aorders_path
  end

  def filldrivers
    if  not Onlinedriver.find_by_odate_id(session[:working_date])
      lastdate=Odate.find(:all, :order =>'thedate', :conditions => "thedate < '#{session[:working_date].thedate}'").last
      olddrivers=Onlinedriver.find_all_by_odate_id(lastdate.id)

      olddrivers.each do |od|
        newdriver=Onlinedriver.new
        newdriver.adriver_id=od.adriver_id
        newdriver.odate_id=session[:working_date].id
        newdriver.save
      end
    end

    redirect_to aorders_path
  end

  def setonduty
    @onlinedriver = Onlinedriver.find(params[:id])
    @onlinedriver.onduty = !@onlinedriver.onduty
    @onlinedriver.save
    redirect_to aorders_path
  end

end
