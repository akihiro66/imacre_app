class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.integer :production_id
      t.text :content
      t.timestamps
    end
    add_index :logs, :production_id
  end
end
