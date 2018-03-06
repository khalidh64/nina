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
    if current_user.has_role? :admin
      @workorder = Workorder.new
    else
      redirect_to workorders_path
    end
  end

  def create
    if current_user.has_role? :admin
      @workorder = Workorder.new(workorder_params)
      @workorder.user_id = current_user.id
      if @workorder.valid?
        @workorder.save!
        redirect_to workorders_path, :notice=> "Workorder created."
      else
        redirect_to :back, :alert => @order.errors
      end
    else
      redirect_to workorders_path
    end
  end

  def change
    if current_user.has_role? :admin
      @workorder = Workorder.find(params[:id])
    else
      redirect_to workorders_path
    end
  end

  def update
    if current_user.has_role? :admin
      @workorder = Workorder.find(params[:id])
      if @workorder.update_attributes(workorder_params)
        redirect_to "/workorder/#{@workorder.id}/change", :notice => "Updated"
      else
        redirect_to "/workorder/#{@workorder.id}/change", :alert => "Something went wrong"
      end
    else
      redirect_to workorders_path
    end
  end

  private

  def workorder_params
  	params.require(:workorder).permit(:erpno,:clientname,:sitename,:workorderno,:workorderdate,:workorder_type,:workorder_value,:mobbg_no,:mobadv,:matadv,:retbg,:perbg,:pwarrenty,:workcompdate,:remarks)
  end

end
