require 'test_helper'

class VisitOldPagesTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "visit old pages" do
		get "CTS/buttons"
#p @response.body
		assert_select "select#Past"
		
		get "CTS/threads", :Past => 1
		assert_template "thread/threads_out"
		assert_select "a#1"
		assert_select "a#10"
#		!assert_select "a#11"

		get "CTS/threads", :Past => 2
		assert_template "thread/threads_out"
		assert_select "a#11"
		assert_select "a#19"
		
  end
  
end
