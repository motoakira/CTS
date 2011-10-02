require 'test_helper'

class CtsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	test "delete a post" do
		post :del_post, { :to_del => "10", :delkey_entered => "4044" }
		assert_redirected_to :controller => "thread", :action => "threads_out"
#		assert_select "a", /[000010  -- <<< the Deleter >>>] ユーザー削除/
	end

end
