class Itemlist < ApplicationRecord
  belongs_to :stockworkorder
  has_many :dcrs, dependent: :destroy
  accepts_nested_attributes_for :dcrs, :allow_destroy => true
end
