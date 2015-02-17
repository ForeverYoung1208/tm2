# encoding: utf-8

class OnlineautosController < ApplicationController
 
  # POST /aorders
  # POST /aorders.xml
  def create
    @onlinedriver=Onlinedriver.new(params[:onlineauto])
    @onlineauto.save!
    redirect_to aorders_path
  end

  # DELETE /aorders/1
  def destroy
    @onlinedriver = Onlineauto.find(params[:id])
    @onlineauto.destroy

    redirect_to aorders_path
  end

  def fillautos
    if  not Onlineauto.find_by_odate_id(session[:working_date])
      lastdate=Odate.find(:all, :order =>'thedate', :conditions => "thedate < '#{session[:working_date].thedate}'").last
      olddrivers=Onlineauto.find_all_by_odate_id(lastdate.id)

      oldautos.each do |od|
        newdriver=Onlineauto.new
        newdriver.adriver_id=od.aauto_id
        newauto.odate_id=session[:working_date].id
        newauto.save
      end
    end

    redirect_to aorders_path
  end

  def setonduty
    @onlinedriver = Onlineauto.find(params[:id])
    @onlinedriver.onduty = !@onlineauto.onduty
    @onlineauto.save
    redirect_to aorders_path
  end

end
