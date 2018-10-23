
Given(/^I "([^"]+)" to Redfin$/) do |action|
require 'yaml'
redfin_yml = YAML::load(File.open(Dir.pwd + '/features/step_definitions/Redfin/redfin_helper.yml'))
username = redfin_yml['redfin']['username']
password = redfin_yml['redfin']['password']

  case action
    when 'login'
      click_button('Log In')
      sleep 5
      click_button('Continue with Email')
      sleep 2
      fill_in('Email', with: username)
      sleep 1
      fill_in('Password', with: password)
      sleep 1
      click_button('Sign In')
      sleep 2
  end

end

Given(/^I verify I "([^"]+)" signed in$/) do |status|
  case status
    when 'am'
      name = page.has_content?('A.J.')
      raise "Test Failed.  You are not signed in" if !name
    when 'am not'
      name = page.has_content?('A.J.')
      raise "Test Failed.  You are not signed in" if name
  end
end

Given(/^I search for "([^"]+)" in the search field$/) do |criteria|
  @search_criteria = criteria.split(',')
  fill_in('City, Address, School, Agent, ZIP', with: criteria)
  within('#homepageTabContainer') do
    click_button('Search')
  end
  sleep 5
end

Then(/^I add the filters "([^"]+)" to the search$/) do |filter|
  @filters = filter.split(',')
  sleep 2
  click_button('Filters')
  sleep 3
  @filters.each do |row|
    row = row.split('=')
    case row[0]
      when 'House','Condo','Townhouse','Multi-family','Land','Other types'
      click_button(row[0]) if row[1]
      sleep 2
      when 'MinBeds'
      min_beds = all('.minBeds')
      sleep 2
      min_beds[0].click
      sleep 2
      find(".option", text: row[1]).click
      sleep 2
    end
  end
click_button('Apply Filters')
sleep 5
end


Then(/^I assert the search results$/) do
  all('.homecard').each do |single_card|
    single_home = single_card.text
    # Testing search/filter criteria of City and State
        i = 0
      while i < @search_criteria.count
        test = single_home.include?(@search_criteria[i])
        if !ENV['bypass']
        raise "Test Failed. Result does not include #{@search_criteria[i]}" if !test
        end
        i += 1
      end

    # Testing additional filter
      @filters.each do |row|
          filter = row.split('=')
          case filter[0]
            when 'MinBeds'
              text = single_home.gsub(/\n/,"|")
              text = text.split('|')
              bed_index = text.index('Beds')
              #setting the number of bedrooms equal to the value of the position in the array before Beds
              number_of_bedrooms = text[bed_index - 1]
              raise "Test Failed. Minimum number of bedrooms not returned" if number_of_bedrooms.to_i < filter[1].to_i
          end

      end


  end
end
