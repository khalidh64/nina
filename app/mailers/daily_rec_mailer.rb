class DailyRecMailer < ApplicationMailer
	default from: "info@entersoftsecurity.com"

	def dailyrec(dcr)
		@dcr = dcr
	 	mail(to: "khalidhmhd@gmail.com" , subject: "#{Date.today.strftime('%m-%d-%Y')} Received Quantity")
	end
end
