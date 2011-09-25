require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	fixtures :admins
	
	test "invalid with incorrect object" do
		admin = Admin.new	# empty object
		assert !admin.valid?
		
		admin = Admin.new(:name => "", :password => "1234",
					:password_confirmation => "1234", :salt => "nacl")	# lack of name
		assert !admin.valid?
		
		admin = Admin.new(:name => "root", :password => "1234",
					:password_confirmation => "", :salt => "nacl")	# lack of confirmation
		assert !admin.valid?

		admin = Admin.new(:name => "root", :password => "",
					:password_confirmation => "1234", :salt => "nacl")	# lack of password
		assert !admin.valid?
		
		admin = Admin.new(:name => "admin", :password => "1234",
					:password_confirmation => "1234", :salt => "nacl")	# name already exists in DB
		assert !admin.valid?
	end
	
	test "valid with correct object" do
# NOTE: name=="admin" is already created with fixture
		admin = Admin.new(:name => "root", :password => "1234",
					:password_confirmation => "1234", :salt => "nacl")
	
		assert admin.valid?
	end

	test "authenticate against fixture" do
		assert Admin.authenticate("admin", "0987").nil?	# incorrect password
		assert admin = Admin.authenticate("admin", "1234")	# correct password
#p admin.inspect		
	end

end
