require 'test_helper'

class CommentTreeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	fixtures :comment_trees, :postings

	def test_each
		tree = comment_trees(:tree_31)
#p root.inspect
		buf = []
		tree.each { |node, gen|
			buf << '<' + node.id.to_s + ' ' + gen.to_s + '>'
		}
#p buf.join
		assert_equal "<31 0><32 1><34 2><35 3><33 1>", buf.join
	end

end
