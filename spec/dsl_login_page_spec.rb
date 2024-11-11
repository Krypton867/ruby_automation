# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Authentication Tests' do
  include Capybara::DSL

  before(:each) do
    visit @url
  end

  context "Valid login attempt" do
    users = ['standard_user']
    pass = 'secret_sauce'

    users.each do |user|
      it "allows #{user} to log in with correct credentials" do
        fill_in 'user-name', with: user
        fill_in 'password', with: pass
        click_button 'Login'
        page_header = find('span.title')
        expect(page_header.text).to eq "Products"
      end
    end
  end

  context "Invalid login attempt with wrong password" do
    test_data = [{ user: 'standard_user', pass: 'bad_password' }]

    test_data.each do |credentials|
      it "denies access for #{credentials[:user]} with incorrect password" do
        fill_in 'user-name', with: credentials[:user]
        fill_in 'password', with: credentials[:pass]
        click_button 'Login'
        error_message = find('h3[data-test="error"]')
        expect(error_message.text).to include "Epic sadface: Username and password do not match any user in this service"
      end
    end
  end

  context "Restricted accounts" do
    accounts = [
      { user: 'locked_out_user', pass: 'secret_sauce' },
      { user: 'error_user', pass: 'secret_sauce' }
    ]

    accounts.each do |account|
      it "prevents login for #{account[:user]}" do
        fill_in 'user-name', with: account[:user]
        fill_in 'password', with: account[:pass]
        click_button 'Login'
        expect(page).to have_no_selector('span.title')
      end
    end
  end
end

RSpec.describe 'Cart Functionality' do
  include Capybara::DSL

  before(:each) do
    visit @url
  end

  context "Adding items to cart" do
    users = ['standard_user']
    pass = 'secret_sauce'

    users.each do |user|
      it "allows #{user} to add two items to the cart" do
        fill_in 'user-name', with: user
        fill_in 'password', with: pass
        click_button 'Login'
        find_button('add-to-cart-sauce-labs-backpack').click
        backpack_button = find('button[data-test="remove-sauce-labs-backpack"]')
        expect(backpack_button.text).to eq "Remove"

        find_button('add-to-cart-sauce-labs-bike-light').click
        bike_light_button = find('button[data-test="remove-sauce-labs-bike-light"]')
        expect(bike_light_button.text).to eq "Remove"
      end
    end
  end
end
