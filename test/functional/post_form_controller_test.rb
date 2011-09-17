require 'test_helper'

class PostFormControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

=begin	# @postingにアクセス不可らしい。no method error。
	test "title quote" do 
		post :post_form, :parent_id => 31
		posting = @controller.posting
		assert /^＞ / =~ posting.title
	end
=end

	test "Elements in the form for NEW" do
		post :post_form, :parent_id => 0
		assert_select "h2", "基記事（新規発言）"
		assert_select "form" do 
			assert_select "input#parent_id[type=hidden]"
			assert_select "input#posting_author[type=text]"
			assert_select "input#posting_title[type=text]"
			assert_select "textarea#posting_article"
			assert_select "input#attached_file2up[type=file]"
			assert_select "input#posting_delkey[type=password]"
			assert_select "input[name=commit][type=submit]"
			assert_select "input[type=reset]"
		
		end
	end
	test "Elements in the form for COMMENT" do
		post :post_form, :parent_id => 32
		assert_select "h2", "記事: ＃000032へのコメント"
		assert_select "form" do 
			assert_select "input#parent_id[type=hidden]"
			assert_select "input#posting_author[type=text]"
			assert_select "input#posting_title[type=text]"
			assert_select "textarea#posting_article"
			assert_select "input#attached_file2up[type=file]"
			assert_select "input#posting_delkey[type=password]"
			assert_select "input[name=commit][type=submit]"
			assert_select "input[type=reset]"
		
		end
	end


end
