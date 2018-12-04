require 'spec_helper'

describe 'Incorrect user details produces valid error' do

  context 'it should respond with the correct error when incorrect details are input' do
    
    it "should produce an error when inputting an incorrect username" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_username
      @bbc_site.bbc_sign_in_page.enter_password
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.general_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.password_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_username_error_message).to eq "Sorry, we can’t find an account with that username. If you're over 13, try your email address instead or get help here."
    end

    it "should produce several errors when no username or password are input" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_no_username
      @bbc_site.bbc_sign_in_page.enter_no_password
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.return_general_error_message).to eq "Sorry, those details don't match. Check you've typed them correctly."
      expect(@bbc_site.bbc_sign_in_page.return_username_error_message).to eq "Something's missing. Please check and try again."
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Something's missing. Please check and try again."
    end

    it "should produce a password and general error when no username is input" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_username
      @bbc_site.bbc_sign_in_page.enter_no_password
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.username_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_general_error_message).to eq "Sorry, those details don't match. Check you've typed them correctly."
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Something's missing. Please check and try again."
    end

    it "should produce a password error of 'too short' when a short password is input" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_username
      @bbc_site.bbc_sign_in_page.enter_password_below_8
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.general_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.username_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Sorry, that password is too short. It needs to be eight characters or more."
    end

    it "should produce a password error of 'only letters' when a password with only letters is input" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_username
      @bbc_site.bbc_sign_in_page.enter_password_only_letters
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.general_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.username_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Sorry, that password isn't valid. Please include something that isn't a letter."
    end

    it "should produce a password error of 'no letters' when a password with only numbers and special characters is input" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_username
      @bbc_site.bbc_sign_in_page.enter_password_no_letters
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.general_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.username_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Sorry, that password isn't valid. Please include a letter."
    end

    it "should respond with an error when a correct email is given with the wrong, but valid, password" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_valid_username
      @bbc_site.bbc_sign_in_page.enter_password
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_sign_in_page.general_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.username_error_exists?).to eq false
      expect(@bbc_site.bbc_sign_in_page.return_password_error_message).to eq "Uh oh, that password doesn’t match that account. Please try again."
    end

    it "should correctlt redirect when valid information is given" do
      @bbc_site = BbcSite.new
      @bbc_site.bbc_homepage.visit_homepage
      @bbc_site.bbc_sign_in_page.visit_sign_in_page
      @bbc_site.bbc_sign_in_page.enter_valid_username
      @bbc_site.bbc_sign_in_page.enter_real_password(ENV['REAL_ACCOUNT_PASSWORD'])
      @bbc_site.bbc_sign_in_page.click_sign_in
      expect(@bbc_site.bbc_homepage.current_url).to eq 'https://www.bbc.co.uk/'
      expect(@bbc_site.bbc_homepage.check_if_logged_in).to eq 'Your account'
    end

  end

end
