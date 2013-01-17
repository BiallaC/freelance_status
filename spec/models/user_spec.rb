require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar", status: "available", daily_rate: 1000)
	end

	subject { @user }

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:authenticate)}
	it {should respond_to(:remember_token)}
	it {should respond_to(:role)}

	it {should be_valid}

	describe "when name is not present" do
		before {@user.name =" "}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before {@user.email =" "}
		it {should_not be_valid}
	end

	describe "when email is not valid" do
	  it "should be invalid" do
	    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                   foo@bar_baz.com foo@bar+baz.com]
	    addresses.each do |invalid_address|
	      @user.email = invalid_address
	      @user.should_not be_valid
	    end
  	end
  end

  describe "when email is valid" do
  	it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end
  	it {should_not be_valid}
  end

  describe "when password is not present" do
  	before {@user.password = @user.password_confirmation = " "}
  	it {should_not be_valid}
  end

  describe "when password does not match confirmation" do
  	before {@user.password_confirmation = "barfoo"}
  	it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
  	before {@user.password_confirmation = nil}
  	it {should_not be_valid}
	end

	describe "when password is too short" do
		before {@user.password = @user.password_confirmation = "a"*5}
		it {should_not be_valid}
	end

	describe "when daily rate is not an integer" do
		before {@user.daily_rate = "1.000"}
		it {should_not be_valid}
	end

	describe "return value of authenticate method" do
		before {@user.save}
		let(:found_user) {User.find_by_email(@user.email)}

		# User-Object is equal to found_user with authentication via valid password
		describe "with valid password" do
			it {should == found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
			let(:user_with_invalid_password) {found_user.authenticate("invalid")}

			it {should_not == user_with_invalid_password}
			specify {user_with_invalid_password.should be_false}
		end
	end
	describe "remember_token" do
		before {@user.save}
		its(:remember_token) { should_not be_blank}
	end
end