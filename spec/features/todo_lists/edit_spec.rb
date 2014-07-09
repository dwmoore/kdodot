require 'spec_helper'

describe "Editing todo lists" do
	
	let(:user) { create(:user) }
	let!(:todo_list) { todo_list = TodoList.create(title: "My title", description: "My description.") }

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "My description."

		todo_list = options[:todo_list]
		
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"

	end

	before do
		sign_in user, password: "treehouse1"
	end

	it "updates a todo list successfully with correct information" do

		update_todo_list todo_list: todo_list, title: "New title", description: "New description"

		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")

	end

	it "displays an error when there is no title" do

		update_todo_list todo_list: todo_list, title: ""
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content("error")

	end

	it "displays an error when ther title is to short" do

		update_todo_list todo_list: todo_list, title: "Hi"
		expect(page).to have_content("error")

	end

	it "displays an error when there is no description" do

		update_todo_list todo_list: todo_list, description: ""
		expect(page).to have_content("error")

	end

	it "displays an error when the description is too short" do

		update_todo_list todo_list: todo_list, description: "Hi"
		expect(page).to have_content("error")

	end
end