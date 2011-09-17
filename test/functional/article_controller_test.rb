require 'test_helper'

class ArticleControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	def test_without_fixtures
		get :article_out
#p  @response.body.inspect
		assert /No Articles/ =~ @response.body
	end

	fixtures :comment_trees, :postings
	
	def test_with_fixtures
		get :article_out
		res_button = find_tag :tag => "input",
				:attributes => { :type => "submit" }
		assert_equal "000034", res_button.attributes["value"]
		
		get :article_out, :cueto => 22
		res_button = find_tag :tag => "input",
				:attributes => { :type => "submit" }
		assert_equal "000022", res_button.attributes["value"]
	end
end
