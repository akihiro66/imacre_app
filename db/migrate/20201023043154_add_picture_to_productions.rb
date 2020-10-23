class AddPictureToProductions < ActiveRecord::Migration[6.0]
  def change
    add_column :productions, :picture, :string
  end
end
