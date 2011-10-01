require 'test_helper'
require 'multipart_form'

class ThreadControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	def test_no_threads
		Posting.delete_all
		Attached.delete_all
		CommentTree.delete_all

		get :threads_out
#p @controller.trees.inspect
#p @response.body.inspect
		assert_response :success
		assert_select "p", /No Threads/
	end

	def test_invalid_posts
		post :rcv_post, :parent_id => 0,
				:attached => { :file2up => 
					MultipartFormData.new("a_file",'image/jpeg', 400 * 1024, 'otuoiuewru') }
#p @controller.params.inspect
#p @response.body.inspect 
#		assert(/prohibited.+prohibited/ =~ @response.body)
#		assert(/prohibited/ =~ @response.body)
		assert_select "div.errorExplanation", 2
		post :rcv_post, :parent_id => 0,
				:posting => { :title => 'test', :author => 'moto'},
				:attached => { :file2up =>
					MultipartFormData.new("a_file",'script/javascript', 100 * 1024, 'otuoiuewru') }
		assert_select "div.errorExplanation", 1
		post :rcv_post, :parent_id => 0,
				:attached => { :file2up =>  
					MultipartFormData.new("a_file",'image/jpeg', 100 * 1024, 'otuoiuewru') }
		assert_select "div.errorExplanation", 1
		post :rcv_post, :parent_id => 0, 
				:posting => { :title => 'test', :author => 'moto'},
				:attached => { :file2up =>  
					MultipartFormData.new("a_file",'image/jpeg', 300 * 1024 + 1, 'otuoiuewru') }
		assert_select "div.errorExplanation", 1
#p @controller.inspect
#p @response.body.inspect 
	end
	
	def test_valid_posts
		post :rcv_post, :parent_id => 0, 
				:posting => { :title => 'test', :author => 'moto'},
				:attached => { :file2up => 
					MultipartFormData.new("a_file",'image/jpeg', 100 * 1024, 'otuoiuewru') }
#p @controller.params.inspect
#p @response.body.inspect 
		assert_redirected_to :action => :threads_out
#p @response.body.inspect 
#		assert !(/prohibited/ =~ @response.body)
#		assert /\[.*moto.*\]test/ =~ @response.body
	end

fixtures :comment_trees
fixtures :postings
	
	def test_recent_trees
=begin
tree_test = CommentTree.find(:all)
p tree_test.inspect
=end
		get :threads_out
#p @controller.inspect
#p @response.body.inspect 
		assert /000031/ =~ @response.body
	end
	
	def test_past_trees
		post :threads_out, :Past => 1
#p @controller.inspect
#p @response.body.inspect 
		assert /000001/ =~ @response.body
		assert !(/000011/ =~ @response.body)
		post :threads_out, :Past => 2
#p @controller.inspect
#p @response.body.inspect 
		assert /000011/ =~ @response.body
		assert !(/000021/ =~ @response.body)
	end
end
