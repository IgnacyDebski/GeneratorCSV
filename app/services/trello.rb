class Trello

  def self.connect
    OAuth::Consumer.new(ENV["API_TRELLO_TOKEN"], ENV["API_TRELLO_SECRET"],
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

  def self.set_callback(callback)
    Trello.connect.get_request_token(oauth_callback: callback)
  end

  def self.authorize(access_token, secret_token)
    OAuth::AccessToken.new(Trello.connect, access_token, secret_token)
  end



end
