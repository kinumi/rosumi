require 'rubygems'
require 'bundler/setup'
require 'rosumi'
require 'yaml'
require "rspec"
require "pry"

CREDENTIALS_FILE = File.join(File.dirname(__FILE__), 'credentials.yml')

RSpec.configure do |config|
  unless File.exist?(CREDENTIALS_FILE) and File.file?(CREDENTIALS_FILE)
    raise "Please create a credentials.yml file containing your Apple email / password."
  end

  data = YAML.load_file(CREDENTIALS_FILE)
  @@username = data['email']
  @@password = data['password']
  @@rosumi = Rosumi.new @@username, @@password
end
