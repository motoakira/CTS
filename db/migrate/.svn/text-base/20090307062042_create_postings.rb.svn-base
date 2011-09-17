class CreatePostings < ActiveRecord::Migration
  def self.up
    create_table :postings do |t|
#		t.integer id,	#t.integer root_num
		t.integer :parent_id
		t.boolean :isLive
		t.integer :generation

		t.string :author
		t.string :title
		t.text :article
		t.string :attached
		
		t.string :delkey

      t.timestamps :timestamp
    end
  end

  def self.down
    drop_table :postings
  end
end
