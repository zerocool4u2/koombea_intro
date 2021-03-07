# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular)
    sign_in @user
  end

  test 'should get index if signed in' do
    get users_url
    assert_response :success
  end

  test 'should get show if signed in' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit if signed in' do
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should get index after destroy if signed in' do
    delete user_url(@user)
    assert_response :redirect
  end

  test 'should get index redirect if signed out' do
    sign_out :user
    get users_url
    assert_response :redirect
  end

  test 'should get show redirect if signed out' do
    sign_out :user
    get user_url(@user)
    assert_response :redirect
  end

  test 'should get edit redirect if signed out' do
    sign_out :user
    get edit_user_url(@user)
    assert_response :redirect
  end

  test 'should get index after destroy redirect if signed out' do
    sign_out :user
    delete user_url(@user)
    assert_response :redirect
  end
end
