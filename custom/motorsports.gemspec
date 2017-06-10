# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motorsports/version'

Gem::Specification.new do |spec|
  spec.name          = "motorsports"
  spec.version       = Motorsports::VERSION
  spec.authors       = ["Arumoy Shome"]
  spec.email         = ["arumoy.shome@gmail.com"]

  spec.summary       = %q{ This gem is part of the Motorsports Shopify store }
  spec.description   = %q{ This gem is responsible for pulling data from the 
                            external API(s) and update the products on the store periodically }
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rack", "~> 2.0"
  spec.add_development_dependency "webmock", "~> 3.0"

  spec.add_runtime_dependency "dotenv", "~> 2.2"
  spec.add_runtime_dependency "rubyzip", "~> 1.2"
  spec.add_runtime_dependency "smarter_csv", "~> 1.1"
  spec.add_runtime_dependency "activerecord", "~> 5.1"
  spec.add_runtime_dependency "sqlite3", "~> 1.3"
  spec.add_runtime_dependency "shopify_api", "~> 4.8"
end
