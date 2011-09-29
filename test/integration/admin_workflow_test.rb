require 'test_helper'

class AdminWorkflowTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	test "login and delete a posting" do
		admin = admins(:admin)
		get "CTS/admin/list_postings"	# try admin page without login
		assert_redirected_to :controller => 'admin', :action => 'login'
		
		post 'CTS/admin/login', :name => admin.name, :password => '1234'
		assert_redirected_to :controller => 'admin', :action => 'index'
		assert_equal admin.id, session[:admin_id]

		get 'CTS/admin/change_passwd', :password => '0987', :password_confirmation => '0987'
		assert_response :success
		assert_template 'change_passwd'

		get 'CTS/admin/list_postings'
		assert_response :success
		assert_template 'list_postings'

		post_via_redirect 'CTS/admin/delete_posting', :id => '21'
		assert_response :success
		assert_template 'list_postings'

		assert_select "li#21", :text =>	/the Deleter.*管理者削除/
		
	end
end
