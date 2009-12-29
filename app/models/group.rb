class Group < ActiveRecord::Base
  has_many :users,:dependent=>:delete_all

end
