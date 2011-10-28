# $:.unshift File.dirname(__FILE__)
#
# Written by: Scott Moe, Simplified Software Development

module CloudServers
  class Domain

    # Represent Domain information
    attr_reader :id
    attr_reader :account_id
    attr_reader :records
    attr_reader :nameservers
    attr_reader :subdomains
    attr_reader :name
    attr_reader :updated_at
    attr_reader :created_at

    def initialize(connection, id)
      @id = id
      @connection = connection
      @dnsmgmthost   = connection.dnsmgmthost
      @svrmgmtpath   = connection.svrmgmtpath
      @svrmgmtport   = connection.svrmgmtport
      @svrmgmtscheme = connection.svrmgmtscheme
      populate
    end

    def populate
      response = @connection.csreq("GET",@connection.dnsmgmthost,"#{@connection.svrmgmtpath}/domains/#{URI.escape(self.id.to_s)}",@connection.svrmgmtport,@connection.svrmgmtscheme)
      CloudServers::Exception.raise_exception(response) unless response.code.match(/^20.$/)
      data = JSON.parse(response.body)
      
      @account_id = data["accountId"]
      @name = data["name"]
      @updated_at = DateTime.parse(data["updated"])
      @created_at = DateTime.parse(data["created"])
      @nameservers = data["nameservers"].map { |ns| CloudServers::NameServer.new ns }
      @records = data["recordsList"]["records"].map { |r| CloudServers::Record.new(r) unless r.nil? }
      @emailAddress = data["emailAddress"]
      @ttl = data["ttl"]
      @comment = data["comment"]
      return self
    end
    alias :refresh :populate

    #def delete!
      #response = @connection.csreq("DELETE",@connection.dnsmgmthost,"#{@connection.svrmgmtpath}/domains/#{URI.escape(self.id.to_s)}",@connection.svrmgmtport,@connection.svrmgmtscheme)
      #CloudServers::Exception.raise_exception(response) unless response.code.match(/^20.$/)
      #true
    #end
    
  end

  class Record
    attr_reader :name
    attr_reader :id
    attr_reader :type
    attr_reader :data
    attr_reader :updated
    attr_reader :ttl
    attr_reader :created

    def initialize data
      @name = data['name']
      @id = data['id']
      @type = data['type']
      @data = data['data']
      @ttl = data['ttl']
      @updated = DateTime.parse(data['updated'])
      @created = DateTime.parse(data['created'])
    end

  end

  class NameServer
    attr_reader :name

    def initialize data
      @name = data['name']
    end
  end

end

