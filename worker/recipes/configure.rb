node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'other'
    Chef::Log.debug("Skipping php::configure application #{application} as it is not an PHP app")
    next
  end

  gem_package "webrick" do
		action :install
	end

  # write out opsworks.php
  template "#{deploy[:deploy_to]}/shared/config/opsworks.rb" do
    cookbook 'worker'
    source 'server.rb.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    only_if do
      File.exists?("#{deploy[:deploy_to]}/shared/config")
    end
  end
end