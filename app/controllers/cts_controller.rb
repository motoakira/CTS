class CtsController < ApplicationController

# http POST
def del_post()
	to_del = params['to_del'].to_i
	ruin = nil
	delkey_entered = params['delkey']
	Posting.transaction { 
	begin
		thePost = Posting.find(to_del, :lock => true)
		if !thePost.isLive
			# 削除のcontentionで、寸前に削除された
=begin
CANCELED；
	Admin業務は、データベースを直に保守すればいいので、
	このCGIからは、その機能は削除する。
		elsif  admin_pwd() == delkey_entered
			note = "管理者削除"
			ruin = del_exec(cgi, tree, thePost, note)
=end
		elsif thePost.delkey == ""
		elsif thePost.delkey == delkey_entered
			note = "ユーザー削除"
			ruin = del_exec(thePost, note)
# ここまで、エラーなく削除処理が辿り着けば、添付ファイルの残滓を消す。
			if ruin.attached.nil?
			else
				ruin.attached.delete
			end
		else	# unknown case
		end
	rescue ActiveRecord::Rollback
		flash[:msg] = "Failed to Delete"
	end
	}
	msg = ""

	redirect_to threads_url, :target => "Threads"
end

private
def del_exec(post, note)
	ruin = Posting.new
	ruin.id = post.id
	ruin.parent_id = post.parent_id
	ruin.author = post.author
	ruin.title = post.title
	ruin.article = post.article 
	ruin.attached = post.attached

	post.author = "<<< the Deleter >>>"
	post.title = "--- " + note + " ---"
	post.article = "!!! Deleted:　削除されました !!!"
	post.attached = nil
	post.isLive = false
	post.save!
#	if ruin.nil?
#	else
	begin
=begin
# 添付ファイルを削除フォルダへ
		unless attached.nil?
			FileUtils.cp(Live + attached.untaint, Del)
		end
# 削除記事を削除フォルダ中のファイルへ書き出し
		File.open(Del + sprintf("%06d.html", ruin.id), 'w') { | fd |
			fd.puts ruin.show(cgi)
		}
=end
	rescue IOError	# interpreterに制御が戻らないように
		raise ActiveRecord::Rollback
	end
#	end
	ruin
end

=begin
	File.open(saved, "w") { | fd |
		fd.write(client_file.read)
	}
=end

end # of CtsController
