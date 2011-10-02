require 'test_helper'

class PostingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	def test_invalid_with_empty_attributes
		posting = Posting.new
		assert !posting.valid?
		assert posting.errors.invalid?(:title)
		assert posting.errors.invalid?(:author)
		assert posting.errors.invalid?(:parent_id)
		assert posting.errors.invalid?(:comment_tree_id)
	
	end

	def test_numericality
		posting = Posting.new(:title => 'test', :author => 'jjj')
		posting.parent_id = 'zero'
		posting.comment_tree_id = 'one'
#p posting.inspect
		assert !posting.valid?
#p 'parent_id ==' + posting.parent_id.inspect
		assert posting.errors.invalid?(:parent_id)
#p "comment_tree_id ==" + posting.comment_tree_id.inspect
		assert posting.errors.invalid?(:comment_tree_id)
		assert_equal "is not a number", posting.errors.on(:parent_id)
		assert_equal "is not a number", posting.errors.on(:comment_tree_id)

		posting = Posting.new(:title => 'test', :author => 'jjj')
		posting.parent_id = 1
		posting.comment_tree_id = 1
#p posting.inspect
		assert posting.valid?
	end

	fixtures :postings
	
	def test_each
#		root = postings(:post_31)
		root = Posting.find(31)
#p root.inspect
		buf = []
		root.each(0) { |node, gen|
			buf << '<' + node.id.to_s + ' ' + gen.to_s + '>'
		}
#p buf.join
		assert "<31 0><32 1><34 2><35 3><33 1>" == buf.join
	end

	test "Quotation of Title" do 
		parent = Posting.find(31)
#p parent.inspect
		quoted_title = parent.title_quote
		assert_equal "Re:title_31", quoted_title
		parent = Posting.find(32)
#p parent.inspect
		quoted_title = parent.title_quote
		assert_equal "Re^2:title_32", quoted_title
		parent = Posting.find(34)
#p parent.inspect
		quoted_title = parent.title_quote
		assert_equal "Re^3:title_34", quoted_title
		parent = Posting.find(35)
#p parent.inspect
		quoted_title = parent.title_quote
		assert_equal "Re^4:title_35", quoted_title
	end
	
	test "Quotation of Article" do
		parent = Posting.find(31)
		quoted_article = parent.article_quote
		assert_equal "＞ The quick brown fox\n＞ jumps over\n＞ lazy dog.", quoted_article
	
		parent = Posting.find(32)
		quoted_article = parent.article_quote
		assert_equal "＞＞ The quick brown fox\n＞＞ jumps over\n＞＞ lazy dog.", quoted_article
	
		parent = Posting.find(34)
		quoted_article = parent.article_quote
		assert_equal "＞＞＞ The quick brown fox\n＞＞＞ jumps over\n＞＞＞ lazy dog.", quoted_article
	
		parent = Posting.find(35)
		quoted_article = parent.article_quote
		assert_equal "＞＞＞＞ The quick brown fox\n＞＞＞＞ jumps over\n＞＞＞＞ lazy dog.", quoted_article
	
	end

	test "disable" do
		root = Posting.find(31)
		disabled = Posting.find(31)
		ruin = disabled.disable("try to delete")
		assert_equal root.author, ruin.author
		assert_equal root.title, ruin.title
		assert_equal root.article, ruin.article
		assert_equal root.parent_id, ruin.parent_id
		assert_equal root.attached, ruin.attached

		disabled.save
		assert_equal "<<< the Deleter >>>", disabled.author
		assert_equal "--- try to delete ---", disabled.title
		assert_equal "!!! Deleted:　削除されました !!!", disabled.article
		assert_equal nil, disabled.attached
	end

	test "authenticate" do
		posting = Posting.authenticate(32, "")
		assert posting.nil?	# fail with posting that has empty delkey
		
		posting = Posting.authenticate(31, "0987")
		assert posting.nil?	# fail when delkeys don't match
		
		posting = Posting.authenticate(31, "4044")
#p posting.inspect
		assert_equal 31, posting.id	# success when delkeys match
	end
end
