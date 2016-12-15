class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchased_by, :foreign_key => 'purchased_by', :class_name => 'User'

  validates :name,  presence: true

  validates_numericality_of :amount, :greater_than => 0, :less_than => 10000
  validates_format_of :amount, :with => /\A\d+(?:\.\d{0,2})?\z/



end
