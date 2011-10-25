$:.unshift File.dirname(__FILE__)
require 'test_helper'
require 'tempfile'

class CloudServersDomainsTest < Test::Unit::TestCase
  include TestConnection
  # test for Domain object and Rackspace DNS api

  def setup
    @conn=get_test_connection
  end
  
  def test_list_domains
    response = mock()
    response.stubs(:code => "200", :body => fixture('list_domains.json'))

    @conn.stubs(:csreq).returns(response)
    domains=@conn.list_domains

    assert_equal 1, domains.size
    assert_equal 2725511, domains[0][:id]
    assert_equal 5, domains[0][:recordsList][:records].size
    assert_equal "NS-6251982", domains[0][:recordsList][:records][1][:id]
  end

  def test_get_domain
    domain=get_test_domain
    assert_equal "rtb0007.com", domain.name
    assert_equal 5, domain.records.size
    assert_equal 2, domain.nameservers.size
    assert_equal 1234, domain.account_id
    assert_equal 2725511, domain.id
  end

private
  def get_test_domain

    response = mock()
    response.stubs(:code => "200", :body => fixture('test_domain.json'))

    @conn=get_test_connection

    @conn.stubs(:csreq).returns(response)
    return @conn.domain(2725511) 

  end
end
