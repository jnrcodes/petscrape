#!/usr/bin/env ruby

require 'bundler/setup'
require 'capybara'
require 'capybara/poltergeist'
require 'pry-debugger'

Capybara.register_driver :poltergeist do |app|
  options = {
    inspector: true,
    js_errors: true,
    extensions: [ 'vendor/poltergeist/bind.js' ]
   }
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.default_driver = :poltergeist

class BattlePets
  class << self
    include Capybara::DSL
    def print_names
      visit "https://theunderminejournal.com/#eu/silvermoon/category/battlepets"
      # binding.pry  # uncomment or move around to enter debugger
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
