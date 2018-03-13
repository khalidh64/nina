class PhysicalstockController < ApplicationController
  before_action :authenticate_user!
  require 'date'
  def index
  	if params[:locno]
  	 @stockworkorder = Stockworkorder.find_by_locno(params[:locno])
    else
      @stockworkorders = Workorder.all
    end
  end

  def new
  	if current_user.has_role? :admin
  		@stockworkorder = Stockworkorder.new
  	else
      redirect_to stockworkorders_path
    end
  end

  def create
  	if current_user.has_role? :admin
	  	@stockworkorder = Stockworkorder.new(stockworkoder_params)
	  	@stockworkorder.user_id = current_user.id
	  	if @stockworkorder.valid?
	  		@stockworkorder.save!
        month_date = (Date.today - Date.today.mday + 1)
        @stockworkorder.itemlists.each do |i|
          date = Date.today
          no = Date.new(date.strftime("%Y").to_i, date.mon, -1).day
          (0..no-1).each do |n|
            Dcr.create(:itemlist_id => i.id, :stockworkorder_id => @stockworkorder.id,
              :date => (month_date+n).strftime("%m-%d-%Y"), :cumrecqty => i.cumrecqtystart,:recqty => 0,
              :cumconqty=>i.cumconqtystart,:cons=>0,:balatsite=>i.balatsitestart,:month=>date.strftime("%B"),
              :year => date.strftime("%Y"),:premonthbal=>0,:presentbal=>0,:remarks=>"",
              :cumrecqtytotal =>i.cumrecqtystart ,:cumconqtytotal =>i.cumconqtystart , :balatsitetotal =>i.balatsitestart )
          end
        end
	  		redirect_to stockworkorders_path, :notice=> "Stock Workorder created."
	  	else
	  		redirect_back fallback_location: root_path, :alert => @stockworkorder.errors
	  	end
	 else
      redirect_to stockworkorders_path
    end
  end

  def change
  	if current_user.has_role? :admin
  		@stockworkorder = Stockworkorder.find(params[:id])
  	else
      redirect_to stockworkorders_path
    end
  end

  def update
  	if current_user.has_role? :admin
	  	@stockworkorder = Stockworkorder.find(params[:id])
	  	if @stockworkorder.update_attributes(stockworkoder_update_params)
	  		redirect_to "/stockworkorder/#{@stockworkorder.id}/change", :notice => "Stock Workorder Updated"
	    else
	      redirect_to "/stockworkorder/#{@stockworkorder.id}/change", :alert => @stockworkorder.errors
	    end
	else
      redirect_to stockworkorders_path
    end    
  end

  private
  def stockworkoder_params
  	params.require(:stockworkorder).permit(:locno,:erpno,:projectname,:projectvalue,:branch,:gmname,:projectincharge,:billingeng, 
      itemlists_attributes: [:id,:stockworkorder_id, :itemno,:itemname, :units,:matqty,:cumrecqtystart, :cumconqtystart,:balatsitestart, :_destroy])
  end
  def stockworkoder_update_params
    params.require(:stockworkorder).permit(:locno,:erpno,:projectname,:projectvalue,:branch,:gmname,:projectincharge,:billingeng, 
      itemlists_attributes: [:id,:stockworkorder_id, :itemno,:itemname, :units,:matqty,:cumrecqtystart, :cumconqtystart,:balatsitestart, :_destroy, 
        dcrs_attributes: [:id,:itemlist_id,:month,:year,:date,:cumrecqty,:recqty,:cumconqty,:cons,:remarks,:_destroy]])
  end
end
