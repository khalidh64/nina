class Stockworkorder < ApplicationRecord
	has_many :itemlists, dependent: :destroy
	has_many :dcrs, dependent: :destroy
	accepts_nested_attributes_for :itemlists, :allow_destroy => true
	# validates_presence_of :locno,:erpno
	# validates_uniqueness_of :locno,{message: "LOC number already stored, please search LOC number"}
end
