require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	test "index without admin" do
		get :index
		assert_redirected_to :action => "login"
		assert_equal "Please log in", flash[:notice]
	end
	test "list_postings without admin" do
		get :list_postings
		assert_redirected_to :action => "login"
		assert_equal "Please log in", flash[:notice]
	end
	test "change_passwd without admin" do
		get :change_passwd
		assert_redirected_to :action => "login"
		assert_equal "Please log in", flash[:notice]
	end

	test "index with admin" do
		get :index, {}, {:admin_id => admins(:admin).id }
		assert_redirected_to :action => "list_postings"
	end
	test "list_postings with admin" do
		get :list_postings, {}, {:admin_id => admins(:admin).id }
		assert_response :success
		assert_template "list_postings"
	end
	test "change_passwd with admin" do
		get :change_passwd, {}, {:admin_id => admins(:admin).id }
		assert_response :success
		assert_template "change_passwd"
	end

	test "login" do
		admin = admins(:admin)
		post :login, :name => admin.name, :password => "1234"
		assert_redirected_to :action => "index"
		assert_equal admin.id, session[:admin_id]
	end

	test "bad_password" do
		admin = admins(:admin)
		post :login, :name => admin.name, :password => "0987"
		assert_template "login"
		assert_equal "Invalid password", flash[:notice]
		
	end
end
