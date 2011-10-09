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
	@posting.author = ( cookies[:author].blank? ) ? "": cookies[:author]
	@posting.delkey_entered = ( cookies[:delkey_entered].blank? ) ? "": cookies[:delkey_entered]

	@attached = Attached.new
	@page_title = "PostForm"
end



end # of PostFormContorller
