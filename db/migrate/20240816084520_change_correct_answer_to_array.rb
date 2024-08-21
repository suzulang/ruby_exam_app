class ChangeCorrectAnswerToArray < ActiveRecord::Migration[7.2]
  def change
    # SQLite 不需要改变列类型，因为它已经是字符串类型
    # 我们只需要确保它允许为空，以便后续可以更新现有记录
    change_column_null :questions, :correct_answer, true
  end
end