class AddPrivacypolicyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :tos_agreement, :boolean, :default => true
  end

  def self.down
    remove_column :users, :tos_agreement
  end
end
