require 'test_helper'

class AttachedTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

	class MultipartFormData
		def initialize(name, content_type, size, read)
			@original_filename = name
			@content_type = content_type
			@size = size
			@read = read
		end
		attr_reader :original_filename, :content_type, :size, :read
	end

	def test_valid_attached
		multi = MultipartFormData.new('a_file', 'image/jpeg', 10, '0123456789')
		form_data = { :file2up => multi }
		attached = Attached.new(form_data)
		assert attached.valid?
	end

	def test_invalid_attached
		form_data = { :file2up =>
				MultipartFormData.new('a_file', 'image/jpeg', 300 * 1024 + 1, '0123456789') }
		attached = Attached.new(form_data)
		assert !attached.valid?
		assert attached.errors.invalid?(:size)
		form_data = { :file2up => 
				MultipartFormData.new('a_file', 'script/javascript', 10, '0123456789') }
		attached = Attached.new(form_data)
		assert !attached.valid?
		assert attached.errors.invalid?(:content_type)
	end

end
