class DcrsController < ApplicationController
	require 'date'
  def index
  	if params[:id]
  	 @dcrs = Dcr.where(:itemlist_id => params[:id])
  	 @dcr = Dcr.where(:date => Date.today.strftime("%m-%d-%Y").to_s, :itemlist_id => params[:id]).last
  	 @itemlist = Itemlist.find(params[:id])
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
         :balatsitetotal=>cumconqtytotal,
         :cumrecqty => cumrecqtytotal,:cumconqty => cumconqtytotal,:balatsite=>balatsitetotal)
      end
  	
    	redirect_back fallback_location: root_path
  	else
  		redirect_back fallback_location: root_path
  	end
  end

  private
  def dcr_params
  	params.require(:dcr).permit(:id,:itemlist_id,:recqty,:cons,:remarks,:dcnumber)
  end
end
