# Transfer-SigninWithApple

## Usage

### 1, Install Gems: 

```shell
bundle install
```

### 2, Configure Cliens

Open `start.rb ` and change Client Options

```ruby

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
end

```
### 3, Set Apple Sub

Open `start.rb` and change the Sub
```ruby
migration.sub = 'XXX'
```
### 4, Run Migration: 

```shell
ruby ./Tool/start.rb
```
