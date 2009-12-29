class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :replies,:dependent=>:destroy
end

