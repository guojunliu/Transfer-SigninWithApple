require "openssl"
require 'jwt'
require 'httparty'
class Client
  attr_accessor :client_type
  attr_accessor :key_file_name
  attr_accessor :key_file
  attr_accessor :key_id
  attr_accessor :team_id
  attr_accessor :client_id
  attr_accessor :client_secret

  def initialize
  end

  def post(path, params={})
      
    headers = {
      "Authorization" => "Bearer #{access_token}",
      "Content-Type" => "application/x-www-form-urlencoded"
    }
    
    params[:client_id] = client_id
    params[:client_secret] = client_secret
    
    print ' 🚀 '
    print client_type
    puts ' 开始生成sub'
    puts '  ▶️  request  ===>'
    print '  1️⃣  Path: https://appleid.apple.com'
    puts path
    print '  2️⃣  Headers: '
    puts headers
    print '  3️⃣  Body: '
    puts params
    
    r = HTTParty.post("https://appleid.apple.com#{path}", body: params, headers: headers)
    
    print '  ✅ response ===>  '
    puts r.body
    
    JSON.parse(r.body)
  end

  private

  def access_token
      
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }
      
    self.client_secret = client_secret_func
    params = {
      grant_type: "client_credentials",
      scope: "user.migration",
      client_id: client_id,
      client_secret: client_secret
    }
    
    
    print ' 🚀 '
    print client_type
    puts ' 开始生成 token'
    puts '  ▶️  request  ===>'
    puts '  1️⃣  Path: https://appleid.apple.com/auth/token'
    print '  2️⃣  Headers: '
    puts headers
    print '  3️⃣  Body: '
    puts params
    
    r = HTTParty.post('https://appleid.apple.com/auth/token', body: params, headers: headers)
    
    print '  ✅ response ===>  '
    puts r.body
    
    JSON.parse(r.body)["access_token"]
  end

  def client_secret_func
    validity_period = 180 
    private_key = OpenSSL::PKey::EC.new IO.read key_file
    
    token = JWT.encode(
      {
        iss: team_id,
        iat: Time.now.to_i,
        exp: Time.now.to_i + 86400 * validity_period,
        aud: "https://appleid.apple.com",
        sub: client_id
      },
      private_key,
      "ES256",
      header_fields=
      {
        kid: key_id 
      }
    )
    
    print ' 🚀 '
    print client_type
    puts ' 开始生成 client_secret'
    print "  1️⃣  team_id: "
    puts team_id
    print "  2️⃣  key_id: "
    puts key_id
    print "  3️⃣  key_file_name: "
    puts key_file_name
    print '  ✅ client_secret ===>  '
    puts token
    
    token
  end
end
