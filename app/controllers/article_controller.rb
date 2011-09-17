class ArticleController < ApplicationController

# http GET
def article_out()
	cueto = params['cueto']
	if  cueto.nil? || cueto == ""
		id = CommentTree.sum(:postings_count)	# PostCounter.instance.read
	else	#リンクからの呼び出し
		id = cueto.to_i
	end
	if id < 1
		@posting = nil
		flash.now[:msg] = 'No Article' 
	else
		@posting = Posting.find(id)
	end
	@page_title = "Article"
end 

# URI for photos
def photo()
	@photo = Attached.find(:first,
		:conditions => ["posting_id = ?", params[:id]])
	send_data(@photo.data, :filename => @photo.name, :type => @photo.content_type, 
		:disposition => "inline")
end
	
end # of ArticleController
