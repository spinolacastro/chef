include_recipe 'deploy'

node[:deploy].each do |application, deploy|
 	if deploy[:application_type] != 'php'
  	Chef::Log.debug("Skipping php::configure application #{application} as it is not an PHP app")
 	end
end