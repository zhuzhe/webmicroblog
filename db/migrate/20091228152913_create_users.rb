class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :nick_name
      t.string :password
      t.string :picture
      t.boolean :active
     
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
