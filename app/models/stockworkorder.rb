class Stockworkorder < ApplicationRecord
	validates_presence_of :locno,:erpno
	validates_uniqueness_of :locno
end
