module CloudServers
  class Authentication

    # Performs an authentication to the Rackspace Cloud authorization servers.  Opens a new HTTP connection to the API server,
    # sends the credentials, and looks for a successful authentication.  If it succeeds, it sets the svrmgmthost,
    # svrmgtpath, svrmgmtport, svrmgmtscheme, authtoken, and authok variables on the connection.  If it fails, it raises
    # an exception.
    #
    # Should probably never be called directly.
    def initialize(connection)
      path = '/v1.0'
      hdrhash = { "X-Auth-User" => connection.authuser, "X-Auth-Key" => connection.authkey }
      begin
        server = Net::HTTP::Proxy(connection.proxy_host, connection.proxy_port).new(connection.auth_host,connection.auth_port)
        if connection.auth_scheme == "https"
          server.use_ssl = true
          server.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        server.start
      rescue
        raise CloudServers::Exception::Connection, "Unable to connect to #{server}"
      end
      response = server.get(path,hdrhash)
      if (response.code =~ /^20./)
        connection.authtoken = response["x-auth-token"]
        server_api_uri = URI.parse(response["x-server-management-url"])
        connection.svrmgmthost = server_api_uri.host
        connection.svrmgmtpath = server_api_uri.path
        connection.svrmgmtpath.sub!(/\/.*?\//, '/v1.0/')
        connection.svrmgmtport = server_api_uri.port
        connection.svrmgmtscheme = server_api_uri.scheme
        account_path = URI.split(server_api_uri.host)[5]
        connection.dnsmgmthost = URI.join("https://dns.api.rackspacecloud.com", account_path).host
        connection.lbmgmthost = URI.join("https://dfw.loadbalancers.api.rackspacecloud.com", account_path).host
        connection.authok = true
      else
        connection.authtoken = false
        raise CloudServers::Exception::Authentication, "Authentication failed with response code #{response.code}"
      end
      server.finish
    end
  end
end
