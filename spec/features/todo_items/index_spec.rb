require 'spec_helper'

describe "Viewing todo items" do 
	let!(:todo_list) { TodoList.create(title: "My title", description: "My description") }

	it "displays the title of the todo list" do
		visit_todo_list(todo_list)
		within("h1.todo_items") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when the todo list is empty" do 
		visit_todo_list(todo_list)
		expect(page.all("table.todo_items tr").size).to eq(1)
	end

	it "dislpays item content when a todo list has items" do
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")

		visit_todo_list(todo_list)

		expect(page.all("table.todo_items tr").size).to eq(3)

		within "table.todo_items" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Eggs")
		end
	end
end