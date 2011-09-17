class CreateAttacheds < ActiveRecord::Migration
  def self.up
    create_table :attacheds do |t|
		t.integer :posting_id	# foregin key to Posting
		t.string :name	# original_filename
		t.string :type	# content type
		t.integer :size	# data size
		t.binary :data	# content data
		
      t.timestamps
    end
  end

  def self.down
    drop_table :attacheds
  end
end
