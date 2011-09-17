class CommentTree < ActiveRecord::Base
	has_many :postings

	def each(&block)
		root = self.postings.find(:first, :conditions => "parent_id == 0")
		gen = 0
		root.each(gen, &block)
	end

end #end of class
