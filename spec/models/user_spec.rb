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

  context "relationships" do
    it { should have_many(:todo_lists) }
  end

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

  describe "#generate_password_reset_token!" do
    let(:user) { create(:user) }

    it "changes the generate_password_reset_token attribute" do
      expect{ user.generate_password_reset_token! }.to change{ user.password_reset_token }
    end

    it "call SecureRandom.urlsafe_base64 to generate the password_reset_token" do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end
end



