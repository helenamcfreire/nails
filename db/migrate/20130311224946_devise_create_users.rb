class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,                  :null => false, :default => ""
      t.string :phone,                  :null => false, :default => ""
      t.string :firstName,              :null => false, :default => ""
      t.string :lastName,               :null => false, :default => ""
      t.string :gender,                 :null => false, :default => ""
      t.datetime :birth,                :null => false
      t.boolean :isBeauty,              :null => false, :default => false
      t.string :encrypted_password,     :null => false, :default => ""

      t.timestamps
    end

    add_index :users, :email,                :unique => true
  end
end