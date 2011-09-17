class RmGeneration < ActiveRecord::Migration
  def self.up
	remove_column :postings, :generation
  end

  def self.down
	add_column :postings, :generation, :integer
  end
end
