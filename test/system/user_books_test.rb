require "application_system_test_case"

class UserBooksTest < ApplicationSystemTestCase
  setup do
    @user_book = user_books(:one)
  end

  test "visiting the index" do
    visit user_books_url
    assert_selector "h1", text: "User books"
  end

  test "should create user book" do
    visit user_books_url
    click_on "New user book"

    fill_in "Book", with: @user_book.book_id
    fill_in "User", with: @user_book.user_id
    click_on "Create User book"

    assert_text "User book was successfully created"
    click_on "Back"
  end

  test "should update User book" do
    visit user_book_url(@user_book)
    click_on "Edit this user book", match: :first

    fill_in "Book", with: @user_book.book_id
    fill_in "User", with: @user_book.user_id
    click_on "Update User book"

    assert_text "User book was successfully updated"
    click_on "Back"
  end

  test "should destroy User book" do
    visit user_book_url(@user_book)
    click_on "Destroy this user book", match: :first

    assert_text "User book was successfully destroyed"
  end
end
