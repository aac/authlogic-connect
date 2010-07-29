class FoursquareToken < OauthToken
  key do |access_token|
    if access_token.consumer.http and access_token.consumer.http.address == "foursquare.com"    
      # reset the consumer
      access_token.consumer=access_token.consumer.class.new(credentials[:key], credentials[:secret], config)
    end

    user_path = "/user.json"
    user_path = user_path.insert(0, "/#{api_version}") unless api_version.nil?

    body = JSON.parse(access_token.get(user_path).body)
    user_id = body['user']['id'].to_s
  end
  
  settings "http://api.foursquare.com",
    :request_token_url  => "http://foursquare.com/oauth/request_token",
    :access_token_url   => "http://foursquare.com/oauth/access_token",
    :authorize_url      => "http://foursquare.com/oauth/authorize",
    :api_versions       => {1 => "v1", 2 => "v2"},
    :api_version        => 1
  
end
