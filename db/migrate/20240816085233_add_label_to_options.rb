class AddLabelToOptions < ActiveRecord::Migration[7.2]
  def change
    add_column :options, :label, :string
  end
end