require 'spec_helper.rb'

describe "Creating todo lists" do
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what i am doing today."
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "displays an error when todo list has no title" do
		visit "/todo_lists/new"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: ""
		fill_in "Description", with: "blah blah"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("blah blah")
	end
	
	it "displays an error when todo list has q title less than 3 characters" do
		visit "/todo_lists/new"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "12"
		fill_in "Description", with: "blah blah blah"
		click_button "Create Todo list"

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("blah blah blah")
	end

	it "displays an error when todo list has no description" do
		visit "/todo_lists/new"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Hello"
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("Hello")
	end

	it "displays an error when todo list has a description less than 5 characters" do
		visit "/todo_lists/new"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Hello"
		fill_in "Description", with: "1234"
		click_button "Create Todo list"

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("Hello")
	end
end