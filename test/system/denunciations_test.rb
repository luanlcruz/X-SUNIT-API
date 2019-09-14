require "application_system_test_case"

class DenunciationsTest < ApplicationSystemTestCase
  setup do
    @denunciation = denunciations(:one)
  end

  test "visiting the index" do
    visit denunciations_url
    assert_selector "h1", text: "Denunciations"
  end

  test "creating a Denunciation" do
    visit denunciations_url
    click_on "New Denunciation"

    fill_in "Sender", with: @denunciation.sender_id
    fill_in "Survivor", with: @denunciation.survivor_id
    click_on "Create Denunciation"

    assert_text "Denunciation was successfully created"
    click_on "Back"
  end

  test "updating a Denunciation" do
    visit denunciations_url
    click_on "Edit", match: :first

    fill_in "Sender", with: @denunciation.sender_id
    fill_in "Survivor", with: @denunciation.survivor_id
    click_on "Update Denunciation"

    assert_text "Denunciation was successfully updated"
    click_on "Back"
  end

  test "destroying a Denunciation" do
    visit denunciations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Denunciation was successfully destroyed"
  end
end
