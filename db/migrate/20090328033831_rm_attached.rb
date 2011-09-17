class RmAttached < ActiveRecord::Migration
  def self.up
	remove_column :postings, :attached
  end

  def self.down
	add_column :postings, :attached, :string
  end
end
