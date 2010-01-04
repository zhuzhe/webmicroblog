require "digest/sha1"


class User < ActiveRecord::Base
  acts_as_solr
  belongs_to :group
  has_many :posts,:dependent=>:destroy
  has_and_belongs_to_many :followers,:class_name=>'User',:foreign_key=>'master_id',:join_table=>'follows',:association_foreign_key=>'follower_id'
  has_and_belongs_to_many :masters,:class_name=>'User',:foreign_key=>'follower_id',:join_table=>'follows',:association_foreign_key=>'master_id'

  
 

  attr_accessor :password_confirmation

  validates_presence_of :nick_name,:password
  validates_uniqueness_of :nick_name
  validates_confirmation_of :password
  validates_format_of  :email,:with =>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,:message=>' email is not correct'


  validate :password_non_blank

  def password_non_blank
    errors.add_to_base("Missing password") if hashed_password.blank?
  end

  def self.encrypted_password(password,salt)
    string_to_hash =password+"wibble"+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt=self.object_id.to_s+rand.to_s
  end

  def password
    @password
  end

  def password=(pwd)
    @password=pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password=User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(email,password)
    user =self.find_by_email(email)
    if user
      expected_password=self.encrypted_password(password, user.salt)
      if user.hashed_password!=expected_password
        user=nil
      end
    end
    user
  end

  def after_destroy
    raise "Can not delete last admin" if Group.first(:conditions=>{:group_name=>'admin'}).users==[]
  end

  def admin?
    self.group==Group.first(:conditions=>{:group_name=>'admin'})
  end


end
