class RenameType < ActiveRecord::Migration
  def self.up
	rename_column :attacheds, :type, :content_type
  end

  def self.down
	rename_column :attacheds, :content_type, :type
  end
end
