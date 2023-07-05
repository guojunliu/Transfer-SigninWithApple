class Migration
  attr_accessor :old_client
  attr_accessor :new_client
  attr_accessor :sub

  def initialize
  end

  def migrate!
    puts ''
    puts '---------------------------------------------------------'
    puts '💻  转让方 开始生成sub1'
    response = old_client.post(
      "/auth/usermigrationinfo",
      {
        sub: sub,
        target: new_client.team_id
      }
    )
    transfer_sub = response["transfer_sub"]
    return "❌  转让方 开始生成sub1 error : no sub1" if transfer_sub.nil?
    
    puts ''
    puts '---------------------------------------------------------'
    puts '💻  接收方 开始生成sub2'
    transfer_response = new_client.post(
      "/auth/usermigrationinfo",
      {
        transfer_sub: transfer_sub,
      }
    )
    new_sub = transfer_response["sub"]
    return "❌  接收方 生成sub2 error : no sub2" if new_sub.nil?
    
  end
end
