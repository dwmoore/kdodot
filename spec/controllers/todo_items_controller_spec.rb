require 'spec_helper'

describe TodoItemsController do

  describe "GET 'index'" do
    it "returns http success" do
      get todo_list_todo_items_path
      response.should be_success
    end
  end

end
