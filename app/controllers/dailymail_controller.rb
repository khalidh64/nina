class DailymailController < ApplicationController
	require 'date'

	def dailyrec_cum
		if (params[:id] == "Nina" && params[:password] == "Nina@14Mailer")
			@dcr = Dcr.where(:month => Date.today.strftime("%B"), :year =>Date.today.strftime("%Y"))
			DailyRecMailer.dailyrec(@dcr).deliver
			DailyCumMailer.dailycum(@dcr).deliver
			render :json => {:status => 200, :messsage => "success"}
		else
			render :json => {:status => 404, :messsage => "Error"}
		end
	end

	def dailycum
		if (params[:id] == "Nina" && params[:password] == "Nina@14Mailer")
			@dcr = Dcr.where(:month => Date.today.strftime("%B"), :year =>Date.today.strftime("%Y"))
			DailyCumMailer.dailycum(@dcr).deliver
			render :json => {:status => 200, :messsage => "success"}
		else
			render :json => {:status => 404, :messsage => "Error"}
		end
	end

	def dailyrec
		if (params[:id] == "Nina" && params[:password] == "Nina@14Mailer")
			@dcr = Dcr.where(:month => Date.today.strftime("%B"), :year =>Date.today.strftime("%Y"))
			DailyCumMailer.dailyrec(@dcr).deliver
			render :json => {:status => 200, :messsage => "success"}
		else
			render :json => {:status => 404, :messsage => "Error"}
		end
	end
end
