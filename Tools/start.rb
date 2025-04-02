require_relative 'migration.rb'
require_relative 'client.rb'

class Apple
  def self.test
    migration = Migration.new
    # 老账号下用户登录产生的sub
    migration.sub = '111111.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.1111'
    migration.new_client = new_client
    migration.old_client = old_client
   
    migration.migrate!
  end

  private

  def self.new_client
    client = Client.new
    client.client_type = '接收方'
    # p8文件key id
    client.key_id = 'NEWXXXXXXX'
    # p8文件相对路径
    client.key_file_name = '/p8/new_AuthKey.p8'
    client.key_file = File.dirname($0) + client.key_file_name
    # 包名
    client.client_id = 'com.new.xxxxx'
    # 开发者账号id
    client.team_id = 'NEWXXXXXXX'
    client
  end

  def self.old_client
    client = Client.new
    client.client_type = '转让方'
    # p8文件key id
    client.key_id = 'OLDXXXXXXX'
    # p8文件相对路径
    client.key_file_name = '/p8/old_AuthKey.p8'
    client.key_file = File.dirname($0) + client.key_file_name
    # 包名
    client.client_id = 'com.old.xxxxx'
    # 开发者账号id
    client.team_id = 'OLDXXXXXXX'
    client
  end
end

puts Apple.test
