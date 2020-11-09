class ChangeDataMaterialToProductions < ActiveRecord::Migration[6.0]
  def change
    change_column :productions, :material, :integer
  end
end
