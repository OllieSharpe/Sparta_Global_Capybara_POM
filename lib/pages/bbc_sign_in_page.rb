require 'Capybara/dsl'

class BbcSignInPage
  include Capybara::DSL

  SIGN_IN_PAGE_URL = 'https://www.bbc.co.uk/signin'
  USERNAME_ELEMENT = 'user-identifier-input'
  PASSWORD_ELEMENT = 'password-input'
  SIGN_IN_BUTTON = 'submit-button'
  USERNAME_ERROR_BOX = '#form-message-username'
  PASSWORD_ERROR_BOX = '#form-message-password'
  GENERAL_ERROR_BOX = '#form-message-general'
  USERNAME_ERROR_XPATH = '//*[@id="form-message-username"]'
  PASSWORD_ERROR_XPATH = '//*[@id="form-message-password"]'
  GENERAL_ERROR_XPATH = '//*[@id="form-message-general"]'

  def visit_sign_in_page
    visit(SIGN_IN_PAGE_URL)
  end

  def enter_username
    fill_in(USERNAME_ELEMENT, :with => 'something_invalid_with_Mongooses')
  end

  def enter_no_username
    fill_in(USERNAME_ELEMENT, :with => '')
  end

  def enter_password
    fill_in(PASSWORD_ELEMENT, :with => 'mongoosefan92')
  end

  def enter_password_below_8
    fill_in(PASSWORD_ELEMENT, :with => 'small')
  end

  def enter_password_only_letters
    fill_in(PASSWORD_ELEMENT, :with => 'mongooses')
  end

  def enter_password_no_letters
    fill_in(PASSWORD_ELEMENT, :with => '1234567890__')
  end

  def enter_no_password
    fill_in(PASSWORD_ELEMENT, :with => '')
  end

  def click_sign_in
    click_button(SIGN_IN_BUTTON)
  end

  def return_username_error_message
    find(USERNAME_ERROR_BOX).text
  end

  def return_password_error_message
    find(PASSWORD_ERROR_BOX).text
  end

  def return_general_error_message
    find(GENERAL_ERROR_BOX).text
  end

  def general_error_exists?
    page.has_xpath?(GENERAL_ERROR_XPATH)
  end

  def password_error_exists?
    page.has_xpath?(PASSWORD_ERROR_XPATH)
  end

  def username_error_exists?
    page.has_xpath?(USERNAME_ERROR_XPATH)
  end


end
