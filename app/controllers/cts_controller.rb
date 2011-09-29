class CtsController < ApplicationController

# http POST
def del_post()
	to_del = params['to_del'].to_i
	ruin = nil
	delkey_entered = params['delkey']
	Posting.transaction { 
	begin
		thePost = Posting.find(to_del, :lock => true)
		if thePost.delkey == ""
		elsif thePost.delkey == delkey_entered
			note = "ユーザー削除"
			ruin = thePost.disable(note)
			if !ruin.nil? && thePost.save!
# ここまで、エラーなく削除処理が辿り着けば、添付ファイルの残滓を消す。
				if ruin.attached.nil?
				else
					ruin.attached.delete
				end
			end
		else	# unknown case
		end
	rescue IOError	# interpreterに制御が戻らないように
		raise ActiveRecord::Rollback
	rescue ActiveRecord::Rollback
		flash[:msg] = "Failed to Delete"
	end
	}
	msg = ""

	redirect_to threads_url, :target => "Threads"
end


end # of CtsController
