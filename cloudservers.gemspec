# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cloudservers"
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["H. Wade Minter", "Mike Mayo", "Dan Prince", "Scott Moe"]
  s.date = "2011-10-26"
  s.description = "A Ruby API the Rackspace Cloud Servers product."
  s.email = "scott.moe@snodm.com"
  s.extra_rdoc_files = [
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    "CHANGELOG",
    "COPYING",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "cloudservers.gemspec",
    "lib/cloudservers.rb",
    "lib/cloudservers/authentication.rb",
    "lib/cloudservers/connection.rb",
    "lib/cloudservers/domain.rb",
    "lib/cloudservers/entity_manager.rb",
    "lib/cloudservers/exception.rb",
    "lib/cloudservers/flavor.rb",
    "lib/cloudservers/image.rb",
    "lib/cloudservers/server.rb",
    "lib/cloudservers/shared_ip_group.rb",
    "lib/cloudservers/version.rb",
    "test/cloudservers_authentication_test.rb",
    "test/cloudservers_connection_test.rb",
    "test/cloudservers_domains_test.rb",
    "test/cloudservers_exception_test.rb",
    "test/cloudservers_servers_test.rb",
    "test/fixtures/create_server.json",
    "test/fixtures/list_domains.json",
    "test/fixtures/list_servers.json",
    "test/fixtures/test_domain.json",
    "test/fixtures/test_server.json",
    "test/test_helper.rb"
  ]
  s.homepage = "https://github.com/SimplifiedSD/ruby-cloudservers"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Rackspace Cloud Servers Ruby API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end

