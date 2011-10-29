$:.unshift File.dirname(__FILE__)
require 'test_helper'
require 'tempfile'

class CloudServersLoadBalancersTest < Test::Unit::TestCase
  include TestConnection
  def setup
    @conn=get_test_connection
  end

  def test_list_loadbalancers
    response = mock()
    response.stubs(:code => "200", :body => fixture('list_loadbalancers.json'))

    @conn.stubs(:csreq).returns(response)
    loadbalancers=@conn.list_loadbalancers

    assert_equal 2, loadbalancers.size
    assert_equal 71, loadbalancers[0][:id]
    assert_equal "lb-site1", loadbalancers[0][:name]
  end

  def test_get_loadbalancer
    
    loadbalancer = get_test_loadbalancer
    assert_equal "sample-loadbalancer", loadbalancer.name
    assert_equal 2, loadbalancer.nodes.size
    assert_equal 1, loadbalancer.virtual_ips.size
    #assert_equal 406271, loadbalancer.account_id
    assert_equal 2000, loadbalancer.id
    assert_equal "RANDOM", loadbalancer.algorithm
    assert_equal "ACTIVE", loadbalancer.status
    assert_equal "HTTP", loadbalancer.protocol
    assert_equal "10.1.1.1", loadbalancer.nodes[0].address
  end


  def test_create_loadbalancer
    load_balancer = fixture('new_loadbalancer.json')
    response = mock()
    response.stubs(:code => "200", :body => fixture('create_lb_response.json'))
    @conn = get_test_connection
    @conn.stubs(:csreq).returns(response)
    @conn.create_loadbalancer( load_balancer )
  end

  private
  def get_test_loadbalancer
    response = mock()
    response.stubs(:code => "200", :body => fixture('test_loadbalancer.json'))

    @conn=get_test_connection

    @conn.stubs(:csreq).returns(response)
    @conn.loadbalancer(2000) 
  end

end
