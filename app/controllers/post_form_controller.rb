class PostFormController < ApplicationController

# http POST
def post_form()
	@posting = Posting.new
	@posting.parent_id = params['parent_id'].to_i
	parent = (@posting.parent_id < 1) ? Posting.new: Posting.find(@posting.parent_id)
# Quote title to the instance
	@posting.title = parent.title_quote
# Quote article to the instance
	@posting.article = parent.article_quote
	
# set Handle
=begin
	pref_cookie = cgi.cookies["preferences"]
	saved_handle = ( pref_cookie == [] ) ? "": pref_cookie.value[0]
	@posting.handle = 
=end

	@attached = Attached.new
	@page_title = "PostForm"
end



end # of PostFormContorller
