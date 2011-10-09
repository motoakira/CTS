
NO_ERR	=	0
ERR_NOHNDL	=	1
ERR_NOTTL	=	2
ERR_TYPE	=	0x40
ERR_TOOBIG	=	0x80

OneHour = 60 * 60
OneDay = 24 * OneHour
OneWeek = 7 * OneDay

class ThreadController < ApplicationController

# http POST
def rcv_post()
	if params[:posting].nil?
		author = ""
		delkey_entered = ""
	else
		author = params[:posting][:author]
		delkey_entered = params[:posting][:delkey_entered]
	end
	handle_cookie(author, delkey_entered)

	is_valid = form_accept()
	if is_valid 
		redirect_to :action => "threads_out"
	end
end

# http GET
def threads_out()
		if CommentTree.count < 1
			@trees = nil
		elsif params.nil? || params["Past"].nil? || (page =  params["Past"].to_i)  < 1
			
			offset = ((CommentTree.count - 1) / TreesPerPage) * TreesPerPage
			
			@trees = CommentTree.find(:all, :order => "id", 
				:limit => TreesPerPage, :offset => offset)
		else
			@trees = CommentTree.find(:all, :order => "id", 
				:limit => TreesPerPage, :offset => ((page - 1) * TreesPerPage) )
		end


	@page_title = "Threads"
end

private

# update cookies
	def handle_cookie(author, delkey_entered)
		cookies[:author] = { :value => author, :expires => 7.days.from_now }
		cookies[:delkey_entered] = { :value => delkey_entered, :expires => 7.days.from_now }
	end
		
def form_accept()
	result = nil
	begin
		if params.nil? || params[:attached].nil? ||
			 params[:attached][:file2up].nil? || params[:attached][:file2up] == ""
			@attached = nil
		else
			@attached = Attached.new(params[:attached])
		end
		
		
		@posting = Posting.new(params[:posting])	#???
		@posting.parent_id = params[:parent_id].to_i
		@posting.attached = @attached
		if @posting.parent_id == 0
			@tree = CommentTree.new
#			tree.postings_count = 1
		else
			@tree = @posting.parent.comment_tree
#			tree.postings_count += 1
		end
	CommentTree.transaction {
		@tree.save!
		@posting.comment_tree_id = @tree.id
		@posting.save!
		unless @attached.nil?
			@attached.posting_id = @posting.id
			@attached.save!
		end
	}
	rescue	ActiveRecord::RecordInvalid
		@attached.valid? unless @attached.nil?
		return false
	rescue	ActiveRecord::Rollback	# IOError
		flash[:msg] = "記事の書き込みに失敗し、記事は消失しました。" +
				"<br>書き込みを再度試すか、あきらめて下さい。"
		return false
	end
	return true
end

end #of ThreadController
