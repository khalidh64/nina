class DailyCumMailer < ApplicationMailer
	default from: "info@entersoftsecurity.com"

	def dailycum(dcr)
		@dcr = dcr
	 	mail(to: "khalidhmhd@gmail.com" , subject: "#{Date.today.strftime('%m-%d-%Y')} Cunsumption Quantity")
	end
end
