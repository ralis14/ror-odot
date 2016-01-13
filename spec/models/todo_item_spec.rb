require 'spec_helper.rb'

describe TodoItem do
  it { should belong_to :todo_list }
end
