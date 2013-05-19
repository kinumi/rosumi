class Rosumi

  def initialize(user, pass)
    @user = user.strip
    @pass = pass.strip
    @locator = Rosumi::Locator.new(user, pass)
    @messenger = Rosumi::Messenger.new(user, pass)
  end

  def devices
    devices = @locator.update_devices

    result = {}
    devices.each_with_index do |device, i|
      result[i] = {:type => device['deviceClass'], :name => device['name']}
    end

    result
  end

  # Gets location information for a device.
  #
  # ==== Attributes
  #
  # * +id+ - ID to locate (0,1,2,3, et cetera).
  def locate_device(id)
    unless id
      raise "An id must be specified."
    end

    @locator.locate(id)
  end

  # Sends a message to the specified device.
  #
  # ==== Attributes
  #
  # * +id+ - id of the device (0,1,2,3 et cetera).
  # * +subject+ - Subject of the message.
  # * +message+ - The message to display on the device.
  # * +sound+ - If true, plays a sound on the device.
  def send_message(id, subject="", message, sound)
    unless id
      raise "An id must be specified."
    end

    @messenger.send_message(id, subject, message, sound)
  end

end

require "rosumi/locator"
require "rosumi/messenger"
