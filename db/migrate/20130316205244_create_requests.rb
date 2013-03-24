class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|

      t.references :user
      t.references :local

      t.string :address,                  :null => false, :default => ""
      t.string :number,                   :null => false, :default => ""
      t.string :complement,               :null => false, :default => ""
      t.decimal :price,                   :null => true,  :precision => 4, :scale => 2
      t.string :status,                   :null => true,  :default => ""
      t.string :payment,                  :null => true,  :default => ""
      t.boolean :is_phone,                :null => false, :default => false

      t.timestamps
    end
  end
end
