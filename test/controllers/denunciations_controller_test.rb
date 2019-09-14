require 'test_helper'

class DenunciationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @denunciation = denunciations(:one)
  end

  test "should get index" do
    get denunciations_url
    assert_response :success
  end

  test "should get new" do
    get new_denunciation_url
    assert_response :success
  end

  test "should create denunciation" do
    assert_difference('Denunciation.count') do
      post denunciations_url, params: { denunciation: { sender_id: @denunciation.sender_id, survivor_id: @denunciation.survivor_id } }
    end

    assert_redirected_to denunciation_url(Denunciation.last)
  end

  test "should show denunciation" do
    get denunciation_url(@denunciation)
    assert_response :success
  end

  test "should get edit" do
    get edit_denunciation_url(@denunciation)
    assert_response :success
  end

  test "should update denunciation" do
    patch denunciation_url(@denunciation), params: { denunciation: { sender_id: @denunciation.sender_id, survivor_id: @denunciation.survivor_id } }
    assert_redirected_to denunciation_url(@denunciation)
  end

  test "should destroy denunciation" do
    assert_difference('Denunciation.count', -1) do
      delete denunciation_url(@denunciation)
    end

    assert_redirected_to denunciations_url
  end
end
