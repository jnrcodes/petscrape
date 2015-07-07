#!/usr/bin/env ruby

require 'bundler/setup'
require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: false
   }
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.default_driver = :poltergeist

class BattlePets
  class << self
    include Capybara::DSL
    def print_names
      visit "https://theunderminejournal.com/#eu/silvermoon/category/battlepets"
      sleep(5)
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
