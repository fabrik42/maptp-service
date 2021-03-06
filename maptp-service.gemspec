# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{maptp-service}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christian Bäuerlein"]
  s.date = %q{2010-05-23}
  s.description = %q{This gem provides access to the MapTP web services.

In order to use them, you need your MapTP credentials aka your Map24 id.

For more information head over to http://www.nn4d.com

You should consider that this client solely works with WGS´84 coordinates in the Decimal Degrees format.
Usually MapTP services work with the Decimal Minutes format, but because Decimal Degrees are much more
established we use it for this lib. To work with MapTP the parameters as well as the responses are
converted internally.

*Note*: This is *not* an official client of MapTP or NAVTEQ, but a private project. :)}
  s.email = ["christian@ffwdme.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/maptp-service.rb", "lib/maptp-service/parser/geocoding_result.rb", "lib/maptp-service/geocoding.rb", "lib/maptp-service/parser/route.rb", "lib/maptp-service/routing.rb", "script/console", "script/destroy", "script/generate", "spec/maptp-service_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{maptp-service}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{This gem provides access to the MapTP web services}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<savon>, [">= 0.7.6"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.0"])
    else
      s.add_dependency(%q<savon>, [">= 0.7.6"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.0"])
    end
  else
    s.add_dependency(%q<savon>, [">= 0.7.6"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.0"])
  end
end
