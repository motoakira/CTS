class CreateCommentTrees < ActiveRecord::Migration
  def self.up
    create_table :comment_trees do |t|
#		t.integer id
		t.integer :postings_count, :default => 0
		
      t.timestamps :timestamp
    end
  end

  def self.down
    drop_table :comment_trees
  end
end
