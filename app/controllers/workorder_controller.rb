class WorkorderController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:erpno]
  	 @workorder = Workorder.find_by_erpno(params[:erpno])
    else
      @workorders = Workorder.all
    end
  end

  def new
  	@workorder = Workorder.new
  end

  def create
  	@workorder = Workorder.new(workorder_params)
    @workorder.user_id = current_user.id
  	if @workorder.valid?
  		@workorder.save
  		redirect_to workorders_path, :notice=> "Workorder created."
  	else
  		redirect_to :back, :alert => @order.errors
  	end
  end

  private

  def workorder_params
  	params.require(:workorder).permit(:user_id,:erpno,:clientname,:sitename,:workorderno,:workorderdate,:workorder_type,:workorder_value,:mobbg_no,:mobadv,:matadv,:retbg,:perbg,:pwarrenty,:workcompdate,:remarks)
  end

end
