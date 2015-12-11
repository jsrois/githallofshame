Given(/^that I am at the main page$/) do
    visit '/'    
end

Then(/^I should see the "(.*?)" repository in the list$/) do |arg1|
  find("a",arg1)  
end
