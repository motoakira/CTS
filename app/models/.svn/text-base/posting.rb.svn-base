class Posting < ActiveRecord::Base
	attr_protected :parent_id, :isLive
	
	belongs_to :parent, :class_name => "Posting"
	has_many :children, :class_name => "Posting",
		:foreign_key => "parent_id",
		:order => "id"
	
	belongs_to :comment_tree, :counter_cache => true

	has_one :attached
	
	validates_presence_of :author, :message => "がありません<br>"
	validates_presence_of :title, :message => "がありません<br>"
	
	validates_numericality_of :parent_id
	validates_numericality_of :comment_tree_id

	def after_validation
		# escape tags
		
	end

	def before_create
		self.isLive = true
	end
	
	def each(gen, &block)
		yield self, gen
		unless children(true).nil?
			gen += 1
			children.each { |node|
				node.each(gen, &block)
			}
		end
	end

#private
def title_quote
	if self.title.nil?
		""
	else
		if self.title.index(/^Re(:|\^)/) == nil
			self.title.gsub(/^/, "Re:")
		elsif self.title.index(/^Re:/) != nil
			self.title.gsub(/^Re:/, "Re^2:")
		else
			self.title.gsub(/^Re\^(\d+):/) {
				"Re^" + ($1.to_i + 1).to_s + ":"
			}
		end
	end
end
def article_quote
	q = []
	if self.nil? || self.article.nil?
		""
	else	# 引用符は、escape-unescapeに無関係な文字が適切。
		self.article.gsub!(/<br>\n/, "\n") 
		self.article.split("\n").each do |l|
			if l.index(/^＞+ /).nil?
				q << l.gsub!(/^/, "＞ ")
			else
				q << l.gsub!(/^＞/, "＞＞")
			end
		end
		q.join("\n")
	end
end

end
