require 'test_helper'

class ButtonControllerTest < ActionController::TestCase
	fixtures :comment_trees
	fixtures :postings

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	def test_new_button
		get :buttons_out
		new_button = find_tag :tag => "input",
				:attributes => { :type => "submit" }
		assert_equal "New", new_button.attributes["value"]
	end

	test "Past form" do
		get :buttons_out
=begin
		past_sel = find_tag :tag => "option",
				:attributes => { :selected => "selected" }
		assert past_sel.attributes["value"] == 0
=end
		past_sel = find_tag :tag => "option",
				:attributes => { :value => 0 }
		assert past_sel.attributes["selected"] == "selected"
	end

end
