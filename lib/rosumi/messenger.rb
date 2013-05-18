require "uri"
require 'json'
require 'net/http'
require 'net/https'
require 'base64'
require_relative "post_helper"

class Rosumi::Messenger
  include PostHelper  
    
  attr_accessor :devices
  
  def initialize(user, pass)
    @user = user
    @pass = pass
  end

  def send_message(id, subject, mesage, sound)
    data = {'clientContext' => {'appName'       => 'FindMyiPhone',
                                'appVersion'    => '1.4',
                                'buildVersion'  => '145',
                                'deviceUDID'    => '0000000000000000000000000000000000000000',
                                'inactiveTime'  => 2147483647,
                                'osVersion'     => '4.2.1',
                                'personID'      => 0,
                                'productType'   => 'iPad1,1'
                                },
                                "sound": true, 
                                "subject": "Test Subject",
                                "text": "Hello world!",
                                "device": 1,
                                "userText": true 
           };
    
    json_devices = self.send(:post,"/fmipservice/device/#{@user}/initClient", data)
  end

end
