class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|

      t.string :name,                  :null => false, :default => ""

    end
  end
end
