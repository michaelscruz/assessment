# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

# require "rails_helper"

# RSpec.describe UsersController, type: :routing do
#   describe "routing" do

#     it "routes to #index" do
#       expect(:get => "/users").to route_to("users#index")
#     end

#     it "routes to #new" do
#       expect(:get => "/users/new").to route_to("users#new")
#     end

#     it "routes to #show" do
#       expect(:get => "/users/1").to route_to("users#show", :id => "1")
#     end

#     it "routes to #edit" do
#       expect(:get => "/users/1/edit").to route_to("users#edit", :id => "1")
#     end

#     it "routes to #create" do
#       expect(:post => "/users").to route_to("users#create")
#     end

#     it "routes to #update via PUT" do
#       expect(:put => "/users/1").to route_to("users#update", :id => "1")
#     end

#     it "routes to #update via PATCH" do
#       expect(:patch => "/users/1").to route_to("users#update", :id => "1")
#     end

#     it "routes to #destroy" do
#       expect(:delete => "/users/1").to route_to("users#destroy", :id => "1")
#     end

#   end
# end
