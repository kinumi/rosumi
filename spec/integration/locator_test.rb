require 'spec_helper'
DEVICE_TO_CHECK = 0

describe Rosumi do

  describe "#devices" do
    it "should return a devices hash mapping id => {:type, :name}" do
      devices = @@rosumi.devices
      devices.should_not be_nil
      devices[0].should_not be_nil
      devices[0][:type].should_not be_nil
      devices[0][:name].should_not be_nil
    end
  end

  describe "#locate_device" do
    it "should return location information for device #{DEVICE_TO_CHECK}" do
      location = @@rosumi.locate_device(DEVICE_TO_CHECK)
      location.should_not be_nil
      location.should_not be_nil
      location[:name].should_not be_nil
      location[:latitude].should_not be_nil
      location[:longitude].should_not be_nil
      location[:accuracy].should_not be_nil
      location[:timestamp].should_not be_nil
    end
  end

end
