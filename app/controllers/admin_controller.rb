class AdminController < ApplicationController

#	layout "admin"

  def login
#!!! a bootstrap
	if (Admin.find_by_name(Admin::NAME)).nil?
		admin = initial_administrator()
		admin.save
	end
#!!!
	session[:admin_id] = nil
	if request.post?
		admin = Admin.authenticate(Admin::NAME, params[:password])
		if admin
			session[:admin_id] = admin.id
			redirect_to(:action => "index")
		else
			flash[:notice] = "Invalid password"
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
		@admin = Admin.find_by_name(Admin::NAME)
		@admin.password = params[:admin][:password]
		@admin.password_confirmation = params[:admin][:password_confirmation]
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

private
	def initial_administrator
		Admin.new(:name => Admin::NAME, :password => Admin::PASSWORD, 
				:password_confirmation => Admin::PASSWORD, :salt => Admin::SALT)
	end
end
