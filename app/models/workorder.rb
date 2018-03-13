class Workorder < ApplicationRecord
	validates_uniqueness_of :erpno, {:message => "ERP number already stored, please search."}
end
