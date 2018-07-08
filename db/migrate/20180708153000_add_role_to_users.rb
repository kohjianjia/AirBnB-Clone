class AddRoleToUsers < ActiveRecord::Migration[5.0]

  def change
  	#                                   0 = customer
    add_column :users, :role, :integer, default: 0
  end

end