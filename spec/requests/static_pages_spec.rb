require 'spec_helper'

describe "StaticPages" do
	  
	subject { page }

	describe "Home page" do
  	before { visit root_path }

    it { should have_selector('h1'   , text: 'Freelance Status') }
    it { should have_selector('title', text: 'Home') }
    it { should have_link('Sign up now!') }
	end
  
	describe "About Us" do
  	before { visit aboutus_path }
  	
  	it { should have_selector('h1', text: 'About Us') }
  	it { should have_selector('title', text: 'About Us') }
	end

	describe "How it Works" do
  	before { visit howitworks_path }
  	
  	it { should have_selector('h1', text: 'How it Works') }
  	it { should have_selector('title', text: 'How it Works') }
	end

	describe "Impressum" do
  	before { visit impressum_path }
  	
  	it { should have_selector('h1', text: 'Impressum') }
  	it { should have_selector('title', text: 'Impressum') }
	end

	describe "Log in" do
  	before { visit login_path }
  	
  	it { should have_selector('h1', text: 'Log in') }
  	it { should have_selector('title', text: 'Log in') }
	end

	describe "Contact" do
  	before { visit contact_path }
  	
  	it { should have_selector('h1', text: 'Contact') }
  	it { should have_selector('title', text: 'Contact') }
	end

  describe "Sign Up Freelancer" do
    before { visit signup_freelancer_path }
    
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', text: 'Sign Up') }
  end
end
