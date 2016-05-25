class CreateCakes < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :cake_name
    end
  end
end
