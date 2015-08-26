#!/usr/bin/env ruby

require 'bundler/setup'
require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :firefox do |app|
  options = {
    inspector: true,
    js_errors: false
   }
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.default_driver = :firefox

class BattlePets
  class << self
    include Capybara::DSL
    def print_names
      visit "https://theunderminejournal.com/#eu/silvermoon/category/battlepets"
      #page.debug
      sleep 5
      find(:xpath, '//tr', match: :first)
      all(:xpath, '//tr').each do |row|
         if (td = row.find(:xpath, './/td[@class="name"]') rescue nil) then
           $stderr.puts td.text
         end
      end
    end
  end
end

if __FILE__ == $0 then
  BattlePets.print_names
end
