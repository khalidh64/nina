class WorkorderController < ApplicationController
  def index
  	@workorders = Workorder.all
  end

  def new
  	@workorder = Workorder.new
  end

  def create
  	@workorder = Workorder.new(workorder_params)
  	if @workorder.valid?
  		@workorder.save
  		redirect_to workorder_path, :notice=> "Workorder created."
  	else
  		redirect_to :back, :alert => @order.errors
  	end
  end

  private

  def workorder_params
  	params.require(:workorder).permit(:erpno,:clientname,:sitename,:workorderno,:workorderdate,:workorder_type,:workorder_value,:mobbg_no,:mobadv,:matadv,:retbg,:perbg,:pwarrenty,:workcompdate,:remarks)
  end

end
