require 'test_helper'

class TicketsControllerTest < ActionController::TestCase


  test "should be redirected if not logged in" do
    get :index
    assert_redirected_to log_in_path
  end
  
  

end
