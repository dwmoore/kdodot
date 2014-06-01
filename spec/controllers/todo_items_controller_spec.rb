require 'spec_helper'

describe TodoItemsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'p'" do
    it "returns http success" do
      get 'p'
      response.should be_success
    end
  end

end
