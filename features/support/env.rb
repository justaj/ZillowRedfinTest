require 'rubygems'
require 'capybara/cucumber'
require 'cucumber'
require 'rspec'
require 'faraday'
require 'active_support/core_ext/hash'

Capybara.default_driver = :selenium

Given /^I want to use the browser "(.*?)"$/ do |browser|
  case browser.downcase
  when "chrome"
    Capybara.register_driver :selenium do |app|
  @browser = Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
  end
end
