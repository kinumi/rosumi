class Rosumi

  def initialize(user, pass)
    @user = user.strip
    @pass = pass.strip
    @locator = Rosumi::Locator.new(user, pass)
    @locator = Rosumi::Messenger.new(user, pass)
  end

  def devices
    devices = @locator.update_devices

    result = {}
    devices.each_with_index do |device, i|
      result[i] = {:type => device['deviceClass'], :name => device['name']}
    end

    result
  end

  def locate_device(id)
    unless id
      raise "An id must be specified."
    end

    @locator.locate(id)
  end


  def send_message(id, message, subject="", sound=false)
    unless id
      raise "An id must be specified."
    end

    @messenger.send_message(id, subject, mesage, sound)
  end

end

require "rosumi/locator"
