require 'test_helper'

class PropiedadesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get propiedades_index_url
    assert_response :success
  end

end
