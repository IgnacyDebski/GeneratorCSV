class Trello

  def self.connect
    OAuth::Consumer.new("5d33b173873b7411d2cf824a2c3d1e78", "ef50c3c3ff50429d726a9e3c2266dcdb39713e3ad2c29fab2d82a5d2cf3fb1e8",
    {
      :site => "https://api.trello.com/1",
      :scheme => :header,
      :http_method => :post,
      :request_token_path => "/OAuthGetRequestToken/",
      :access_token_path => "/OAuthGetAccessToken/",
      :authorize_path => "/OAuthAuthorizeToken/",
      :scope => 'read,write,account'
    })
  end

  def self.set_callback
    Trello.connect.get_request_token(oauth_callback: ENV["APP_DOMAIN"] + "/trello_authorizes/callback")
  end

  def self.authorize(access_token, secret_token)
    OAuth::AccessToken.new(Trello.connect, access_token, secret_token)
  end



end
