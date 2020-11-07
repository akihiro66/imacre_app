class CreateMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :production_id
      t.string :amount
      t.timestamps
    end
    add_index :materials, :production_id
  end
end
