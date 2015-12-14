require 'test_helper'

class RepoTest < ActiveSupport::TestCase
   test "Should not store repos without name" do
     repo = Repo.new
     assert_not repo.save
   end
end
