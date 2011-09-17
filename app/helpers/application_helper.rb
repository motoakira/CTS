# Methods added to this helper will be available to all templates in the application.

Tags_text_il = [ "q", "cite", "em", "strong", "dfn", "abbr",
					 "sup", "sub", "code", "var", "kbd", "samp" ]
Tags_text_blk = ["h1", "h2", "h3", "h4", "h5", "h6", "p", "blockquote", "pre" ]
Tags_link = [ "a" ]
Tags_list = [ "ul", "ol", "li", "dl", "dt", "dd" ]
Tags_table = [ "table", "caption", "tr", "th", "td" ]
Tags_else_il = [ "span" ]
Tags_else_blk = [ "div" ]

module ApplicationHelper

def timestamp_lf()
	timestamp = Time.parse(@posting.updated_at)
	timestamp.localtime.strftime("%a&nbsp;%Y.%m.%d&nbsp;%H:%M:%S&nbsp;%Z")
end

def handle_read(handle)
#	handle = @posting.author
#	print "<p>Class of handle:#{handle.class}"
	if handle.nil? || handle.size <= 0
		""
	else
#		handle = CGI.escapeHTML(handle.read)
		tags_allowed = Tags_text_il + Tags_else_il
#		handle = CGI.unescapeElement(handle, tags_allowed)
		handle = sanitize(handle, :tags => tags_allowed)
#		unescapeChar(handle)
	end
end

def title_read(title)
#	title = @posting.title
#	print "<p>Class of title:#{title.class}"
	if title.nil? || title.size <= 0
		""
	else
#		title = CGI.escapeHTML(title.read)
		tags_allowed = Tags_text_il + Tags_else_il
#		title= CGI.unescapeElement(title, tags_allowed)
		title= sanitize(title, :tags => tags_allowed)
#		unescapeChar(title)
	end
end

def article_read(article)
#	article = @posting.article
#	print "<p>Class of article:#{article.class}"
	if article.nil? || article.size <= 0
		""
	else
#		article = CGI.escapeHTML(article.read)
		tags_allowed = Tags_text_il + Tags_text_blk + Tags_else_il + Tags_else_blk +
			Tags_link + Tags_list + Tags_table
#		article = CGI.unescapeElement(article, tags_allowed)
		article = sanitize(article, :tags => tags_allowed)
#		unescapeChar(article)
		article = article.gsub(/\r\n/, "\n").gsub(/\r|\n/, "<br />\n")
	end
end

end # of class
