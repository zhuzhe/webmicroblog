class User < ActiveRecord::Base
  belongs_to :group
  has_many :posts,:dependent=>:destroy

  
  def self.authencate(input_email,input_password)
    first(:conditions=>{:email=>input_email,:password=>input_password})

  end
end
