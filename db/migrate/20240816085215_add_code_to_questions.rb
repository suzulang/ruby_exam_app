class AddCodeToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :code, :text
  end
end