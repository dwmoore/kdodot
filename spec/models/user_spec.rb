require 'spec_helper'

describe User do

	let(:valid_attributes) {
  		{
  			first_name: "Dave",
  			last_name: "Moore",
  			email: "davesemail@email.com",
  			password: "qwerty",
  			password_confirmation: "qwerty"
  		}
  	}

  context "validations" do
  	let(:user) { User.new(valid_attributes) }

  	before do
  		User.create(valid_attributes)
  	end
  		
  	it "requires an email" do
  		expect(user).to validate_presence_of(:email)
  	end

  	it "requires a unique email" do
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires a unique email (case insensitive)" do
  		user.email = "DAVESEMAIL@email.com"
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires the email address to look like an email" do
  		user.email = "dave"
  		expect(user).to_not be_valid
  	end
  end

  context "#downcase_email" do
  	it "makes the email attribute lower case" do
  		user = User.new(valid_attributes.merge(email: "DAVESEMAIL@EMAIL.COM"))
  		#user.downcase_email
  		#expect(user.email).to eq("davesemail@email.com")
  		expect{ user.downcase_email }.to change{ user.email }.
  			from("DAVESEMAIL@EMAIL.COM").
  			to("davesemail@email.com")
  	end

  	it "downcases an email before saving" do
  		user = User.new(valid_attributes)
  		user.email = "DavesEmAil@email.COM"

  		expect(user.save).to be_true
  		expect(user.email).to eq("davesemail@email.com")
  	end
  end
end
