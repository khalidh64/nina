class DcrsController < ApplicationController
	require 'date'
  def index
  	if params[:id]
        @itemlist = Itemlist.find_by_id(params[:id])
        @dcrs = Dcr.where(:itemlist_id => params[:id], :month =>Date.today.strftime("%B"))
        @dcr = Dcr.where(:date => Date.today.strftime("%m-%d-%Y").to_s, :itemlist_id => params[:id]).last
        date = Date.today
        predate = date << 1
        @predata = Dcr.where(:month => predate.strftime("%B").to_s, :itemlist_id => params[:id]).last
        if @dcr.blank?
            date = Date.today
            predate = date << 1
            itemdata = Itemlist.find_by_id(params[:id])
            @predata = Dcr.where(:month => predate.strftime("%B").to_s, :itemlist_id => params[:id]).last
            if @predata.blank?
                precumrecqty = itemdata.cumrecqtystart
                precumconqty = itemdata.cumconqtystart
                prebalatsite = itemdata.balatsitestart
            else
                precumrecqty = @predata.cumrecqtytotal
                precumconqty = @predata.cumconqtytotal
                prebalatsite = @predata.balatsitetotal
            end
            month_date = (Date.today - Date.today.mday + 1)
            no = Date.new(date.strftime("%Y").to_i, date.mon, -1).day
            (0..no-1).each do |n|
                Dcr.create(:itemlist_id => params[:id], :stockworkorder_id => @itemlist.stockworkorder_id,
                :date => (month_date+n).strftime("%m-%d-%Y"), :cumrecqty => precumrecqty,
                :recqty => 0,:cumconqty=>precumconqty,:cons=>0,:balatsite=>prebalatsite,
                :month=>date.strftime("%B"),:year => date.strftime("%Y"),:premonthbal=>0,
                :presentbal=>0,:remarks=>"",:cumrecqtytotal =>precumrecqty ,
                :cumconqtytotal =>precumconqty , :balatsitetotal =>prebalatsite )
            end
        end
        @dcr = Dcr.where(:date => Date.today.strftime("%m-%d-%Y").to_s, :itemlist_id => params[:id]).last
        @stockworkorder = Stockworkorder.find_by_id(@itemlist.stockworkorder_id)
    else
      @dcrs = Dcr.all
    end
  end

  def dcrupdate
    @itemlist = Itemlist.find_by_id(dcr_params["itemlist_id"])
  	@dcr = Dcr.find_by_id(dcr_params[:id])
    puts @dcr.date
    puts @dcr.cumrecqty

    if dcr_params[:recqty].to_i == @dcr.recqty
      cumrecqtytotal = @dcr.cumrecqty
    else
        cumrecqtytotal = (@dcr.cumrecqty - @dcr.recqty) + dcr_params[:recqty].to_i
    end

    if dcr_params[:cons].to_i == @dcr.cons
      cumconqtytotal = @dcr.cumconqty
    else
        cumconqtytotal = (@dcr.cumconqty - @dcr.cons) + dcr_params[:cons].to_i
    end

    if (dcr_params[:cons].to_i == @dcr.cons && dcr_params[:recqty].to_i == @dcr.recqty)
      balatsitetotal = @dcr.balatsite
    else
      balatsitetotal = cumrecqtytotal - cumconqtytotal
    end
    
    if @dcr.update_attributes(:cumrecqty => cumrecqtytotal,:cumconqty => cumconqtytotal,:balatsite => balatsitetotal,
      :recqty => dcr_params[:recqty],:cons => dcr_params["cons"],
      :dcnumber => dcr_params[:dcnumber], :remarks => dcr_params[:remarks])

      (Date.today..Date.today.end_of_month).each do |d|
        puts d.strftime("%m-%d-%Y")
        dc = Dcr.where(:date =>d.strftime("%m-%d-%Y"),:itemlist_id => dcr_params["itemlist_id"]).last
        dc.update_attributes(:cumrecqtytotal => cumrecqtytotal, :cumconqtytotal => cumconqtytotal,
         :balatsitetotal=>balatsitetotal,
         :cumrecqty => cumrecqtytotal,:cumconqty => cumconqtytotal,:balatsite=>balatsitetotal)
      end
  	
    	redirect_back fallback_location: root_path, :notice => "updated"
  	else
  		redirect_back fallback_location: root_path, :alert => "Error: Please try again."
  	end
  end

  private
  def dcr_params
  	params.require(:dcr).permit(:id,:itemlist_id,:recqty,:cons,:remarks,:dcnumber)
  end
end
