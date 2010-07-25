class TwitterToken < OauthToken
  
  key :user_id
  
  settings "http://api.twitter.com",
    :authorize_url => "http://api.twitter.com/oauth/authenticate",
    :api_versions  => {1 => "1"},
    :api_version   => 1
  
end
