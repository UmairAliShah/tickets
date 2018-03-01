class Feature < ApplicationRecord
  belongs_to :product
  validates :title, :presence => true
end
