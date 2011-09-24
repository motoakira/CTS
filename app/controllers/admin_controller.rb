class AdminController < ApplicationController

#	layout "admin"

  def login
	session[:admin_id] = nil
	if request.post?
		admin = Admin.authenticate(params[:name], params[:password])
		if admin
			session[:admin_id] = admin.id
			redirect_to(:action => "index")
		else
			flash[:notice] = "Invalid admin/password combination"
		end
	end
  end

  def logout
	session[:admin_id] = nil
	flash[:notice] = "Logged Out"
	redirect_to(:action => "login")
  end

  def index
	redirect_to(:action => :list_postings)
  end

  def list_postings
	@all_postings = Posting.find(:all)
  end

	def change_passwd
		@admin = Admin.new(params[:admin])
		if request.post? && @admin.save
			flash.now[:notice] = "Password is changed."
			@admin = Admin.new
		end
	end

	def delete_posting
		if request.post?
			posting = Posting.find(:params[:id])
			posting.disable	#!!!! モデル：Postingに、記事削除の機能を !!!!
		end
		redirect_to(:action => :list_postings)
	end
end
