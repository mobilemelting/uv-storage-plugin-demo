# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{carrierwave}
  s.version = "0.3.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonas Nicklas"]
  s.date = %q{2009-10-12}
  s.description = %q{* RDoc Documentation {available at Rubyforge}[http://carrierwave.rubyforge.org/rdoc].
* Source code {hosted at GitHub}[http://github.com/jnicklas/carrierwave]
* Please {report any issues}[http://github.com/jnicklas/carrierwave/issues] on GitHub
* Please direct any questions at the {mailing list}[http://groups.google.com/group/carrierwave]}
  s.email = ["jonas.nicklas@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "features/fixtures/bork.txt", "features/fixtures/monkey.txt", "README.rdoc"]
  s.files = ["Generators", "History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "carrierwave.gemspec", "cucumber.yml", "features/caching.feature", "features/file_storage.feature", "features/file_storage_overridden_filename.feature", "features/file_storage_overridden_store_dir.feature", "features/file_storage_reversing_processor.feature", "features/fixtures/bork.txt", "features/fixtures/monkey.txt", "features/mount_activerecord.feature", "features/mount_datamapper.feature", "features/step_definitions/activerecord_steps.rb", "features/step_definitions/caching_steps.rb", "features/step_definitions/datamapper_steps.rb", "features/step_definitions/file_steps.rb", "features/step_definitions/general_steps.rb", "features/step_definitions/mount_steps.rb", "features/step_definitions/store_steps.rb", "features/support/activerecord.rb", "features/support/datamapper.rb", "features/support/env.rb", "features/versions_basics.feature", "features/versions_nested_versions.feature", "features/versions_overridden_filename.feature", "features/versions_overriden_store_dir.feature", "lib/carrierwave.rb", "lib/carrierwave/compatibility/paperclip.rb", "lib/carrierwave/core_ext/blank.rb", "lib/carrierwave/core_ext/inheritable_attributes.rb", "lib/carrierwave/core_ext/module_setup.rb", "lib/carrierwave/mount.rb", "lib/carrierwave/orm/activerecord.rb", "lib/carrierwave/orm/datamapper.rb", "lib/carrierwave/orm/mongomapper.rb", "lib/carrierwave/orm/sequel.rb", "lib/carrierwave/processing/image_science.rb", "lib/carrierwave/processing/rmagick.rb", "lib/carrierwave/sanitized_file.rb", "lib/carrierwave/storage/abstract.rb", "lib/carrierwave/storage/file.rb", "lib/carrierwave/storage/s3.rb", "lib/carrierwave/test/matchers.rb", "lib/carrierwave/uploader.rb", "lib/carrierwave/uploader/cache.rb", "lib/carrierwave/uploader/callbacks.rb", "lib/carrierwave/uploader/default_path.rb", "lib/carrierwave/uploader/default_url.rb", "lib/carrierwave/uploader/extension_whitelist.rb", "lib/carrierwave/uploader/mountable.rb", "lib/carrierwave/uploader/paths.rb", "lib/carrierwave/uploader/processing.rb", "lib/carrierwave/uploader/proxy.rb", "lib/carrierwave/uploader/remove.rb", "lib/carrierwave/uploader/store.rb", "lib/carrierwave/uploader/url.rb", "lib/carrierwave/uploader/versions.rb", "lib/generators/uploader_generator.rb", "rails_generators/uploader/USAGE", "rails_generators/uploader/templates/uploader.rb", "rails_generators/uploader/uploader_generator.rb", "script/console", "script/destroy", "script/generate", "spec/compatibility/paperclip_spec.rb", "spec/fixtures/bork.txt", "spec/fixtures/test.jpeg", "spec/fixtures/test.jpg", "spec/mount_spec.rb", "spec/orm/activerecord_spec.rb", "spec/orm/datamapper_spec.rb", "spec/orm/mongomapper_spec.rb", "spec/orm/sequel_spec.rb", "spec/sanitized_file_spec.rb", "spec/spec_helper.rb", "spec/uploader/cache_spec.rb", "spec/uploader/default_path_spec.rb", "spec/uploader/default_url_spec.rb", "spec/uploader/extension_whitelist_spec.rb", "spec/uploader/mountable_spec.rb", "spec/uploader/paths_spec.rb", "spec/uploader/processing_spec.rb", "spec/uploader/proxy_spec.rb", "spec/uploader/remove_spec.rb", "spec/uploader/store_spec.rb", "spec/uploader/url_spec.rb", "spec/uploader/versions_spec.rb"]
  s.homepage = %q{http://carrierwave.rubyforge.org}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{carrierwave}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{* RDoc Documentation {available at Rubyforge}[http://carrierwave.rubyforge.org/rdoc]}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_development_dependency(%q<cucumber>, [">= 0.3.96"])
      s.add_development_dependency(%q<activerecord>, [">= 2.3.3"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 1.2.5"])
      s.add_development_dependency(%q<dm-core>, [">= 0.9.11"])
      s.add_development_dependency(%q<do_sqlite3>, [">= 0.9.11"])
      s.add_development_dependency(%q<sequel>, [">= 3.2.0"])
      s.add_development_dependency(%q<rmagick>, [">= 2.10.0"])
      s.add_development_dependency(%q<jnunemaker-mongomapper>, [">= 0.3.3"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<cucumber>, [">= 0.3.96"])
      s.add_dependency(%q<activerecord>, [">= 2.3.3"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 1.2.5"])
      s.add_dependency(%q<dm-core>, [">= 0.9.11"])
      s.add_dependency(%q<do_sqlite3>, [">= 0.9.11"])
      s.add_dependency(%q<sequel>, [">= 3.2.0"])
      s.add_dependency(%q<rmagick>, [">= 2.10.0"])
      s.add_dependency(%q<jnunemaker-mongomapper>, [">= 0.3.3"])
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<cucumber>, [">= 0.3.96"])
    s.add_dependency(%q<activerecord>, [">= 2.3.3"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 1.2.5"])
    s.add_dependency(%q<dm-core>, [">= 0.9.11"])
    s.add_dependency(%q<do_sqlite3>, [">= 0.9.11"])
    s.add_dependency(%q<sequel>, [">= 3.2.0"])
    s.add_dependency(%q<rmagick>, [">= 2.10.0"])
    s.add_dependency(%q<jnunemaker-mongomapper>, [">= 0.3.3"])
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
