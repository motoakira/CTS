class CtsController < ApplicationController

# http POST
def del_post()
	to_del = params['to_del'].to_i
	ruin = nil
	delkey_entered = params['delkey_entered']
	Posting.transaction { 
	begin
		if  posting = Posting.authenticate(to_del, delkey_entered)
			note = "ユーザー削除"
			ruin = posting.disable(note)
			if !ruin.nil? && posting.save!
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
