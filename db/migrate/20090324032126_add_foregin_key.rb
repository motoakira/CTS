class AddForeginKey < ActiveRecord::Migration
  def self.up
	add_column :postings, :comment_tree_id, :integer
  end

  def self.down
	remove_column :postings, :comment_tree_id
  end
end
