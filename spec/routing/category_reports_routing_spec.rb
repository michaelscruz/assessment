# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  value_key   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require "rails_helper"

RSpec.describe CategoryReportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/category_reports").to route_to("category_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/category_reports/new").to route_to("category_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/category_reports/1").to route_to("category_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/category_reports/1/edit").to route_to("category_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/category_reports").to route_to("category_reports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/category_reports/1").to route_to("category_reports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/category_reports/1").to route_to("category_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/category_reports/1").to route_to("category_reports#destroy", :id => "1")
    end

  end
end
