require 'test_helper'

class PostAndDeleteTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	test "new post then comment lastly delete" do
		get "CTS/buttons"
		assert_select "input[type=submit][name=New]"
		
		get "CTS/post_form", :parent_id => "0"
		assert_template "post_form/post_form"
		
		post_via_redirect "CTS/threads", :posting => {
				:author => "moto",
				:title => "base article",
				:delkey => "0226",
				:article => "Rain\nIn Spain\n\nmainly in the plain."
			}, :parent_id => "0"
				
		assert_template "thread/threads_out"
		assert_select "a#36", 
			sprintf("[%06d -- %-16s] %-40s", 36, "moto", "base article").gsub(/ /, "&nbsp;")

		get "CTS/article/", :cueto => "36"
		assert_template "article/article_out"
		assert_select "form > input[type=submit][value=000036]"
#p @response.body
#		assert /000036/ =~ @response.body
		
		get "CTS/post_form", :parent_id => "36"
		assert_template "post_form/post_form"
		
		post_via_redirect "CTS/threads", :posting => {
				:author => "moto",
				:title => "comment",
				:delkey => "0226",
				:article => "Rain\nIn Spain\n\nmainly in the plain."
			}, :parent_id => "36"
		assert_template "thread/threads_out"
		assert_select "a#37", 
			sprintf("&mdash;[%06d -- %-16s] %-40s", 37, "moto", "comment").gsub(/ /, "&nbsp;")

		get "CTS/article/", :cueto => "37"
		assert_template "article/article_out"

		posting = Posting.find(37)
		assert_equal 36, posting.parent_id
		
#p @response.body
		assert_select "form > input[type=submit][value=000037]"
		assert /000036へのコメント/ =~ @response.body

# wrong delete key
		post_via_redirect "CTS/del_post", :to_del => "36", :delkey => "1226" 
		assert_template "thread/threads_out"
		assert_select "a#36", 
			sprintf("[%06d -- %-16s] %-40s", 36, "moto", "base article").gsub(/ /, "&nbsp;")

# correct delete key
		post_via_redirect "CTS/del_post", :to_del => "36", :delkey => "0226" 
		assert_template "thread/threads_out"
		assert_select "a#36", 
			sprintf("[%06d -- %-16s] %-40s", 36, "<<< the Deleter >>>", "--- ユーザー削除 ---").
				gsub(/ /, "&nbsp;").gsub(/</, '&lt;')

		post_via_redirect "CTS/del_post", :to_del => "37", :delkey => "0226" 
		assert_template "thread/threads_out"
		assert_select "a#37", 
			sprintf("&mdash;[%06d -- %-16s] %-40s", 37, "<<< the Deleter >>>", "--- ユーザー削除 ---").
				gsub(/ /, "&nbsp;").gsub(/</, '&lt;')
	end

end
