module PostHelper
  URL="fmipmobile.icloud.com"
  PORT=443

  @devices = []

  @partition = nil

  @http = Net::HTTP.new(URL, PORT)
  @http.use_ssl=true

private 

  # Posts some data to the URL and the path specified.
  #
  # ==== Attributes
  #
  # * +path+ - The path to post to (relative to the URL constant).
  # * +data+ - Payload to send.
  def post(path, data)
		auth = Base64.encode64(@user+':'+@pass)
		headers = {
      'Content-Type' => 'application/json; charset=utf-8',
      'X-Apple-Find-Api-Ver' => '2.0',
      'X-Apple-Authscheme' => 'UserIdGuest',
      'X-Apple-Realm-Support' => '1.2',
      'User-Agent' => 'Find iPhone/1.1 MeKit (iPad: iPhone OS/4.2.1)',
      'X-Client-Name' => 'iPad',
      'X-Client-Uuid' => '0cf3dc501ff812adb0b202baed4f37274b210853',
      'Accept-Language' => 'en-us',
      'Authorization' => "Basic #{auth}"
    }

    unless @partition
      @partition = fetch_partition(path, JSON.generate(data), headers) 
      @http = Net::HTTP.new(@partition, PORT)
      @http.use_ssl=true
    end

    resp = fetch(path, JSON.generate(data), headers)
    
    return JSON.parse(resp.body);
  end

  # Posts some data to the URL and the path specified.
  #
  # ==== Attributes
  #
  # * +path+ - Path to do an http post to the URL constant.
  # * +data+ - Payload to send.
  # * +headers+ - HTTP headers.
  # * +limit+ - Number of redirects allowed.
  def fetch(path, data, headers, limit = 10)
    
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    response = @http.post(path, data, headers)

    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], data, headers, limit - 1)
    else
      response.error!
    end
  end

  # Posts some data to the path and returns the 'X-Apple-MMe-Host' portion
  # of the response.
  #
  # ==== Attributes
  #
  # * +path+ - Path to do an http post to the URL constant.
  # * +data+ - Payload to send.
  # * +headers+ - HTTP headers.
  def fetch_partition(path, data, headers)

    response = @http.post(path, data, headers)
    response['X-Apple-MMe-Host']

  end
end
