# LoadBalancer 
# Written by: Scott Moe, Simplified Software Development

module CloudServers
  class LoadBalancer
    attr_reader :id
    attr_reader :name
    attr_reader :protocol
    attr_reader :port
    attr_reader :algorithm
    attr_reader :status
    attr_reader :connection_logging
    attr_reader :virtual_ips
    attr_reader :nodes
    attr_reader :session_persistence
    attr_reader :connection_throtle
    attr_reader :cluster
    attr_reader :updated_at
    attr_reader :created_at
    #attr_reader :account_id
    attr_reader :source_addresses

    def initialize(connection, id)
      @id = id
      @connection = connection
      @lbmgmthost   = connection.lbmgmthost
      @svrmgmtpath   = connection.svrmgmtpath
      @svrmgmtport   = connection.svrmgmtport
      @svrmgmtscheme = connection.svrmgmtscheme
      populate
    end

    def populate
      response = @connection.csreq("GET",@connection.lbmgmthost,"#{@connection.svrmgmtpath}/loadbalancers/#{URI.escape(self.id.to_s)}",@connection.svrmgmtport,@connection.svrmgmtscheme)
      CloudServers::Exception.raise_exception(response) unless response.code.match(/^20.$/)
      data = JSON.parse(response.body)["loadBalancer"]
      
      #@account_id = data["accountLoadBalancerServiceEvents"]["accountId"]
      @name = data["name"]
      @updated_at = DateTime.parse(data["updated"]["time"])
      @created_at = DateTime.parse(data["created"]["time"])
      @nodes = data["nodes"].map { |n| CloudServers::Node.new n }
      @virtual_ips = data['virtualIps']
      @algorithm = data['algorithm']
      @status = data['status']
      @protocol = data['protocol']
      return self
    end
    alias :refresh :populate
  end

  class Node
    attr_accessor :id
    attr_accessor :address
    attr_accessor :port
    attr_accessor :condition
    attr_accessor :status

    def initialize(data)
      @id = data["id"]
      @address = data["address"]
      @port = data["port"]
      @condition = data["condition"]
      @status = data["status"]
    end
  end

end
