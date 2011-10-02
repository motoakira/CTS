class AddSalt < ActiveRecord::Migration
  def self.up
	add_column :postings, :salt, :string
  end

  def self.down
	remove_column :postings, :salt
  end
end
