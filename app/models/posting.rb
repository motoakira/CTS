require	'digest/sha1'

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
def disable(note)
	ruin = nil
	if self.isLive
		ruin = Posting.new
		ruin.id = self.id
		ruin.parent_id = self.parent_id
		ruin.author = self.author
		ruin.title = self.title
		ruin.article = self.article 
		ruin.attached = self.attached

		self.author = "<<< the Deleter >>>"
		self.title = "--- " + note + " ---"
		self.article = "!!! Deleted:　削除されました !!!"
		self.attached = nil
		self.isLive = false
	end
	ruin
end

	def self.authenticate(id, password)
		posting = self.find(id, :lock => true)
		if posting
			# abort if posting has as delkey an empty string.
			return nil if posting.delkey.nil? || posting.delkey == encrypted_password("", posting.salt)

			expedcted_password = encrypted_password(password, posting.salt)
			if posting.delkey != expedcted_password
				posting = nil
			end
		end
		posting
	end
	
	# 'delkey_entered' is a virtual attribute
	def delkey_entered
		@delkey_entered
	end
	
	def delkey_entered=(pwd)
		@delkey_entered = pwd
		return if pwd.blank?
		create_new_salt
		self.delkey = Posting.encrypted_password(self.delkey_entered, self.salt)
	end

private
	def self.encrypted_password(password, salt)
		string_to_hash = password + "wibble" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end
	
	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
end
