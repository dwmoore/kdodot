require 'spec_helper'

describe "Deleting todo items" do 
	let!(:todo_list) { TodoList.create(title: "My title", description: "My description") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }
	let(:user) { create(:user) }

	before do
		sign_in user, password: "treehouse1"
	end

	it "successfully deletes an item" do
		visit_todo_list(todo_list)
		within "#todo_item_#{todo_item.id}" do
			click_link "Delete"
		end
		expect(page).to have_content("Todo list item was deleted.")
		expect(TodoItem.count).to eq(0)
	end
end