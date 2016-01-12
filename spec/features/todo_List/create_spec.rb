require 'spec_helper.rb'


describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||="My default title"
		options[:description] ||="My default message"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end


	it "redirects to the todo list index page on success" do
		create_todo_list

		expect(page).to have_content("My default title")
	end

	it "displays an error when todo list has no title" do
		create_todo_list title:""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("blah blah")
	end
	
	it "displays an error when todo list has a title less than 3 characters" do
		create_todo_list title:"12"

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("blah blah blah")
	end

	it "displays an error when todo list has no description" do
		create_todo_list description:""

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("Hello")
	end

	it "displays an error when todo list has a description less than 5 characters" do
		create_todo_list description:"1234"

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).not_to have_content("Hello")
	end
end