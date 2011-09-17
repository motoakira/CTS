class ButtonController < ApplicationController
def buttons_out
	trees_count = CommentTree.count # trees_range(0).size
	@option_array = Array.new
	if trees_count > 0
		pages = trees_count / TreesPerPage
		pages += 1 if  (trees_count % TreesPerPage)  > 0
		for page in 1..pages 
			@option_array << [sprintf("Page %3d", page), page]
		end
	end
	@option_array << ["Current", "0"]
	@page_title = "Buttons"
end
end # of Class
