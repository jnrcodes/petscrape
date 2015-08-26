#!/usr/bin/env ruby

require 'bundler/setup'
require 'selenium-webdriver'
require 'pry-debugger'

class BattlePets
  URL = 'https://theunderminejournal.com/#eu/silvermoon/category/battlepets'
  class <<self
    def print_names
      driver = Selenium::WebDriver.for :firefox
      driver.navigate.to URL
      sleep(5)
      driver.find_elements(:xpath, '//tr').each do |tr|
	#binding.pry
	if (td = tr.find_element(:xpath, './/td[@class="name"]') rescue nil) && td.text && td.text =~ /\S/ then
           $stderr.puts td.text
        end
      end
    end
  end
end

if __FILE__ == $0 then
  BattlePets.print_names
end
