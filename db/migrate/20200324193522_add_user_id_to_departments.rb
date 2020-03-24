class AddUserIdToDepartments < ActiveRecord::Migration[6.0]
  def change
    add_column :departments, :user_id, :integer
  end
end
