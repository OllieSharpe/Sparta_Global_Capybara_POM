require 'capybara/dsl'

class BbcHomepage
  include Capybara::DSL
  # page objects
  HOMEPAGE = 'https://www.bbc.co.uk'
  SIGN_IN_LINK_ID = '#idcta-link'
  ACCOUNT_ID = '#idcta-username'

  def visit_homepage
    visit(HOMEPAGE)
  end

  def sign_in_link
    find(SIGN_IN_LINK_ID)
  end

  def click_sign_in_link
    find(SIGN_IN_LINK_ID).click
  end

  def check_if_logged_in
    find(ACCOUNT_ID).text
  end

end
