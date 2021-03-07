# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index if signed in' do
    sign_in users(:regular)
    get home_index_url
    assert_response :success
  end

  test 'should get index redirect if not signed in' do
    get home_index_url
    assert_response :redirect
  end
end
