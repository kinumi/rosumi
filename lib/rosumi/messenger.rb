require "uri"
require 'json'
require 'net/http'
require 'net/https'
require 'base64'
require_relative "post_helper"

class Rosumi::Messenger
  include PostHelper  
    
  def initialize(user, pass)
    @user = user
    @pass = pass
    super()
  end

  # Sends a message to the specified device.
  #
  # ==== Attributes
  #
  # * +id+ - id of the device (0,1,2,3 et cetera).
  # * +subject+ - Subject of the message.
  # * +message+ - The message to display on the device.
  # * +sound+ - If true, plays a sound on the device.
  def send_message(id, subject, message, sound)

    update_devices
    device_id = @devices[id]['id']

    data = {'clientContext' => client_context(device_id),
            'device' => device_id,
            'sound' => sound,
            'subject' => subject,
            'text' => message,
            'userText' => true
           };
    
    self.send(:post,"/fmipservice/device/#{@user}/sendMessage", data)

  end

end
