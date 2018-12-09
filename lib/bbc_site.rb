require_relative 'pages/bbc_homepage'
require_relative 'pages/bbc_sign_in_page'

class BbcSite

  def bbc_homepage
    # instanciate the class bbc_hompage
    BbcHomepage.new
  end

  def bbc_sign_in_page
    # instanciate the class bbc_sing_in_page
    BbcSignInPage.new
  end

end
