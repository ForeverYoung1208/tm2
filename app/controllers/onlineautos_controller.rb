# encoding: utf-8

class OnlineautosController < ApplicationController
  before_action :require_login  
 
  # POST /aorders
  # POST /aorders.xml
  def create
    @onlineauto=Onlineauto.new(params[:onlineauto])
    @onlineauto.save!
    redirect_to aorders_path
  end

  # DELETE /aorders/1
  def destroy
    @onlineauto = Onlineauto.find(params[:id])
    @onlineauto.destroy

    redirect_to aorders_path
  end

  def fillautos
    if  not Onlineauto.find_by_odate_id(session[:working_date])
      lastdate=Odate.find(:all, :order =>'thedate', :conditions => "thedate < '#{session[:working_date].thedate}'").last
      oldautos=Onlineauto.find_all_by_odate_id(lastdate.id) if lastdate

      oldautos.each do |od|
        newauto=Onlineauto.new
        newauto.aauto_id=od.aauto_id
        newauto.odate_id=session[:working_date].id
        newauto.save
      end if lastdate
    end

    redirect_to aorders_path
  end

  def setonduty
    @onlineauto = Onlineauto.find(params[:id])
    @onlineauto.onduty = !@onlineauto.onduty
    @onlineauto.save
    redirect_to aorders_path
  end

end
