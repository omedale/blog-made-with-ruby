class AddUserIdToPosts < ActiveRecord::Migration[5.1]
  def change
    #adds feild 'user_id' tp posts table when you run migration
    add_column :posts, :user_id, :integer
  end
end
