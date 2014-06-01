require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list) { TodoList.create(title: "My title", description: "My description") } 

	before do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "List Items"
		end
	end


	it "displays no items when a todo list is empty" do
		expect(page).to have_content("TodoItems#index")
	end
end