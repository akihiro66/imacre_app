class CreateProductions < ActiveRecord::Migration[6.0]
  def change
    create_table :productions do |t|
      t.string :name
      t.text :description
      t.float :material
      t.text :tips
      t.text :reference
      t.integer :required_time
      t.integer :popularity
      t.text :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :productions, [:user_id, :created_at]
  end
end
