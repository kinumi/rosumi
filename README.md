# Rosumi
This gem allows you to locate and message iOS devices via Apple's 'Find my iPhone' web service. The code was originally ported from the [Sosumi](https://github.com/tylerhall/sosumi/) PHP project by [hpop](https://github.com/hpop/rosumi). In this fork I've reorganized the code, added messaging logic, and converted it into a gem. There's also a couple integration tests.
## Installation

Add this line to your application's Gemfile:

    gem 'rosumi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rosumi

## Usage

###Initialize:
```
require 'rosumi'

rosumi = Rosumi.new "you@example.com", "password"
```

###Get IDs of devices:
```
devices = rosumi.devices

puts "Device 0 name is '#{devices[0][:name]}', type is '#{devices[0][:type]}'"
```

###Get location of device:
```
location = rosumi.locate_device(id)

puts "---------- Device '#{id}' -------------"
puts "Name: #{location[:name]}" unless location[:name].nil?
puts "Coordinate: [#{location[:latitude]},#{location[:longitude]}]" unless location[:latitude].nil?
puts "Accurracy: #{location[:accurracy]}" unless location[:accurracy].nil?
puts "Timestamp: #{location[:timestamp]}" unless location[:timestamp].nil?
puts "-----------------------------------"
```

###Send message to device, no sound:
```
rosumi.send_message(id, "A subject", "Hello, world!", false)
```

You can get a working example in the [rosumi-example](https://github.com/kevineder/rosumi-example) repo.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
