class Attached < ActiveRecord::Base
	belongs_to :posting

	validates_format_of :content_type, :with => /^image/,
		:message => "は受け付けられません<br>"

	validates_inclusion_of :size, :in => 0..MAXSIZE, 
		:message => "ファイルサイズが大き過ぎます<br>"

	def file2up=(f)
		self.name = tail_of_path(f.original_filename)
		self.content_type = f.content_type.chomp
		self.size = f.size.to_i
		self.data = f.read
	end
	
	def tail_of_path(path)
		tail = File.basename(path).gsub(/^\w._-/, '')
#		tail += File.extname(path)	No needs. basename contains suffixes.
	end

end
