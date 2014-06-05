require "spec_helper"

describe "Logging In" do 

	it "logs the user in and goes to the todo lists" do
		User.create( first_name: "Dave", 
                            last_name: "Moore", 
                            email: "dave@example.com", 
                            password: "qwerty", 
                            password_confirmation: "qwerty"
    )

		visit new_user_session_path
		fill_in "Email Address", with: "dave@example.com"
		fill_in "Password", with: "qwerty"
		click_button "Log In"

		expect(page).to have_content("Todo Lists")
		expect(page).to have_content("Thank you for logging in!")

	end

	it "displays the email address in the event of a failed login" do 
		visit new_user_session_path
		fill_in "Email Address", with: "dave@example.com"
		fill_in "Password", with: "asdfg"
		click_button "Log In"

		expect(page).to have_content("There was an error with your credentials.  Please check your email and password.")
		expect(page).to have_field("Email Address", with: "dave@example.com")
	end
end