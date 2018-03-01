class Product < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_many :images
  has_many :features

  accepts_nested_attributes_for :images
  validates_associated :images

  accepts_nested_attributes_for :features
  validates_associated :features

end
