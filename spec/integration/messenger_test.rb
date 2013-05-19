require 'spec_helper'
DEVICE_TO_CHECK = 1

describe Rosumi do

  describe "#send_message" do
    it "Should send message to device" do
      @@rosumi.send_message(DEVICE_TO_CHECK, "Subject!", "Hello, word...!", false)
    end
  end

end
