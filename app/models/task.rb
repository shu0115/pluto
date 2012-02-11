class Task < ActiveRecord::Base
  scope :comp, where( :complete_flag => true )
  scope :incomp, where( :complete_flag => false )
end
