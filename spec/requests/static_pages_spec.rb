require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do

    it "should have the h1 'Proman'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Proman')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
                    text: "Proman 2013 | Home")
    end

  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                    text: "Proman 2013 | Help")
    end

  end

  describe "About page" do

    it "should have the h1 'About Proman'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Proman')
    end

    it "should have the title 'About Proman'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    text: "Proman 2013 | About Proman")
    end
  end
end
