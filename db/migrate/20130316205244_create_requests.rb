class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|

      t.references :user

      t.string :address,                  :null => false, :default => ""
      t.string :price,                    :null => true,  :default => ""
      t.string :status,                   :null => true,  :default => ""
      t.boolean :is_phone,                :null => false, :default => false

      t.timestamps
    end
  end
end
