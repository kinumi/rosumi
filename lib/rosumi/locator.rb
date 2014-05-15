require "uri"
require 'json'
require 'net/http'
require 'net/https'
require 'base64'
require 'pry'
require_relative "post_helper"

class Rosumi::Locator
  include PostHelper  
    
  def initialize(user, pass)
    @user = user
    @pass = pass
    @devices = []
    super()
  end

  # Find a device by it's number.
  #
  # ==== Attributes
  #
  # * +device_num+ - Device number as returned from the update_devices method.
  # * +max_wait+ - Maximum wait in seconds to wait for call to complete.
  def locate(device_num = 0, max_wait = 300)
    
    start = Time.now
    
    init_client
    validate_response(device_num)
    begin
      raise "Unable to find location within '#{max_wait}' seconds" if ((Time.now - start) > max_wait)
      sleep(30)
      
      refresh_client
      validate_response(device_num)
    end until @devices[device_num]['location']['locationFinished']
    
    loc = {
      :name      => @devices[device_num]['name'],
      :latitude  => @devices[device_num]['location']['latitude'],
      :longitude => @devices[device_num]['location']['longitude'],
      :accuracy  => @devices[device_num]['location']['horizontalAccuracy'],
      :timestamp => @devices[device_num]['location']['timeStamp'],
      :position_type  => @devices[device_num]['location']['positionType'],
      :battery_level => @devices[device_num]['batteryLevel'],
      :battery_status => @devices[device_num]['batteryStatus'],
      };

    return loc;
  end
  
  def validate_response(device_num)
    # debug!
    # pp @devices[device_num]['location']['locationFinished']
    # puts "=" * 70
    # STDOUT.flush
    raise "Invalid device number!" if @devices[device_num].nil?
    raise "There is no location data for this device (#{@devices[device_num]['name']})" if @devices[device_num]['location'].nil?
  end
end
