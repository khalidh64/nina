class PhysicalstockController < ApplicationController
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
	  	if @stockworkorder.update_attributes(stockworkoder_params)
	  		redirect_to "/stockworkorder/#{@stockworkorder.id}/change", :notice => "Stock Workorder Updated"
	    else
	      redirect_to "/stockworkorder/#{@stockworkorder.id}/change", :alert => "Something went wrong"
	    end
	else
      redirect_to stockworkorders_path
    end    
  end

  private
  def stockworkoder_params
  	params.require(:stockworkorder).permit(:locno,:erpno,:projectname,:projectvalue,:branch,:gmname,:projectincharge,:billingeng)
  end
end
