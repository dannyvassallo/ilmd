class AddNameToMicrposts < ActiveRecord::Migration
  def change
    add_column :microposts, :first_name, :string
    add_column :microposts, :last_name, :string
  end
end
